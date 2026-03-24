#!/bin/bash
# sync-local.sh — rsync SSH directo entre PCGAMER y MacBook (red local o Tailscale)
#
# Uso:
#   bash sync-local.sh push   → PCGAMER → MacBook
#   bash sync-local.sh pull   → MacBook → PCGAMER

# ── Configura aquí tu MacBook ──────────────────────────────────────────────────
MAC_USER="fabian"           # usuario en el MacBook (ajusta si es diferente)
MAC_HOST="macbook-m4.local" # hostname local o IP Tailscale del MacBook
MAC_CLAUDE_DIR="~/.claude"
# ──────────────────────────────────────────────────────────────────────────────

LOCAL_SKILLS="$HOME/.claude/skills/"
LOCAL_COMMANDS="$HOME/.claude/commands/"

case "$1" in
  push)
    echo "📤 Enviando skills PCGAMER → MacBook ($MAC_HOST)..."
    rsync -avz --progress "$LOCAL_SKILLS" "$MAC_USER@$MAC_HOST:$MAC_CLAUDE_DIR/skills/"
    rsync -avz --progress "$LOCAL_COMMANDS" "$MAC_USER@$MAC_HOST:$MAC_CLAUDE_DIR/commands/"
    echo "✅ Skills enviadas al MacBook."
    ;;
  pull)
    echo "📥 Recibiendo skills MacBook → PCGAMER..."
    rsync -avz --progress "$MAC_USER@$MAC_HOST:$MAC_CLAUDE_DIR/skills/" "$LOCAL_SKILLS"
    rsync -avz --progress "$MAC_USER@$MAC_HOST:$MAC_CLAUDE_DIR/commands/" "$LOCAL_COMMANDS"
    echo "✅ Skills recibidas del MacBook."
    ;;
  *)
    echo "Uso: bash sync-local.sh [push|pull]"
    echo "  push → PCGAMER envía al MacBook"
    echo "  pull → PCGAMER recibe del MacBook"
    exit 1
    ;;
esac
