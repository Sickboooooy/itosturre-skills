# itosturre-skills

Skills y comandos personalizados del Agente Itosturre — sincronizados entre PCGAMER (WSL2) y MacBook Air M4.

## Estructura

```
itosturre-skills/
├── skills/
│   └── itosturre-validator/   ← Auditoría legal anti-alucinaciones (VVCA + RAG)
│       └── SKILL.md
├── commands/
│   └── screenshot.md          ← Captura de escritorio → Telegram
└── scripts/
    ├── install.sh             ← Instala skills en ~/.claude/ (cualquier máquina)
    └── sync-local.sh          ← rsync SSH directo (red local)
```

## Instalación en nuevo equipo

```bash
git clone git@github.com:Sickboooooy/itosturre-skills.git
cd itosturre-skills
bash scripts/install.sh
```

## Sincronización

### Git (cualquier red)
```bash
# En PCGAMER — después de modificar una skill:
cd ~/itosturre-skills && bash scripts/push-skills.sh

# En MacBook — para obtener últimas skills:
cd ~/itosturre-skills && git pull && bash scripts/install.sh
```

### rsync SSH (red local — más rápido)
```bash
# Desde PCGAMER hacia MacBook:
bash ~/itosturre-skills/scripts/sync-local.sh push

# Desde MacBook hacia PCGAMER:
bash ~/itosturre-skills/scripts/sync-local.sh pull
```
