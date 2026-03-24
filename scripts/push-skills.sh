#!/bin/bash
# push-skills.sh — Copia skills actuales de ~/.claude/ al repo y hace push a GitHub

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "📦 Sincronizando ~/.claude/ → repo..."

# Copiar skills al repo
for skill_dir in "$CLAUDE_DIR/skills/itosturre-"*/; do
    skill_name=$(basename "$skill_dir")
    mkdir -p "$REPO_DIR/skills/$skill_name"
    cp -f "$skill_dir"*.md "$REPO_DIR/skills/$skill_name/" 2>/dev/null
    echo "   ✅ $skill_name"
done

# Copiar commands al repo
for cmd in "$CLAUDE_DIR/commands"/*.md; do
    cp -f "$cmd" "$REPO_DIR/commands/" 2>/dev/null
    echo "   ✅ $(basename $cmd)"
done

# Git push
cd "$REPO_DIR"
git add -A
git diff --cached --quiet && echo "ℹ️  Sin cambios — nada que commitear." && exit 0

TIMESTAMP=$(date '+%Y-%m-%d %H:%M')
git commit -m "sync: skills actualizadas $TIMESTAMP"
git push origin main

echo ""
echo "✅ Skills publicadas en GitHub."
