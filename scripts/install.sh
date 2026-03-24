#!/bin/bash
# install.sh — Instala skills de itosturre en ~/.claude/ (PCGAMER o MacBook)

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "🔧 Instalando Itosturre Skills..."
echo "   Origen: $REPO_DIR"
echo "   Destino: $CLAUDE_DIR"

# Skills
mkdir -p "$CLAUDE_DIR/skills"
for skill_dir in "$REPO_DIR/skills"/*/; do
    skill_name=$(basename "$skill_dir")
    mkdir -p "$CLAUDE_DIR/skills/$skill_name"
    cp -f "$skill_dir"*.md "$CLAUDE_DIR/skills/$skill_name/" 2>/dev/null
    echo "   ✅ skill: $skill_name"
done

# Commands
mkdir -p "$CLAUDE_DIR/commands"
for cmd in "$REPO_DIR/commands"/*.md; do
    cp -f "$cmd" "$CLAUDE_DIR/commands/" 2>/dev/null
    echo "   ✅ command: $(basename $cmd)"
done

echo ""
echo "✅ Instalación completa."
