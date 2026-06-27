# itosturre-skills

Skills y comandos personalizados del Agente Itosturre — sincronizados entre PCGAMER (WSL2) y MacBook Air M4.

## Estructura

```
itosturre-skills/
├── skills/
│   ├── itosturre-validator/      ← Auditoría legal anti-alucinaciones (VVCA + RAG)
│   ├── cronologia-expediente/    ← Cronología foliada de expedientes (plazos + inconsistencias)
│   ├── escrito-judicial/         ← Motor de redacción (proemio→hechos→derecho→pedimentos)
│   ├── prep-testigos/            ← Preparación de testigos e interrogatorio (CNPP juicio oral)
│   ├── review-contract/          ← Revisión de contrato + redlining vs. playbook (semáforo)
│   └── triage-nda/               ← Triaje masivo de NDAs en 3 flujos de ruteo
│       └── SKILL.md
├── commands/
│   └── screenshot.md          ← Captura de escritorio → Telegram
└── scripts/
    ├── install.sh             ← Instala skills en ~/.claude/ (cualquier máquina)
    └── sync-local.sh          ← rsync SSH directo (red local)
```

### Trío de litigio (jun-2026)

Tres skills mexicanas para equipos de litigio, integradas al menú de `CLAUDE.md` (opciones 10-12)
y al núcleo anti-alucinación VVCA:

| Skill | Menú | Qué hace |
|-------|------|----------|
| `cronologia-expediente` | 10 | Línea de tiempo foja por foja; detecta inconsistencias 🔴/🟡/⚪, plazos 🚨 y pruebas omitidas. |
| `escrito-judicial` | 11 | Arma el esqueleto del escrito en cascada doctrinal; marca `[VERIFICAR EN SJF]`/`[COMPLETAR]`. |
| `prep-testigos` | 12 | Perfil del testigo, documentos clave, guion de interrogatorio y riesgos (arts. 371-375 CNPP). |

Componen entre sí (cronología → hechos del escrito → munición del interrogatorio) y con `pdf`
(OCR), `docx` (export a Word) y `itosturre-validator` (auditoría VVCA de toda cita).

### Par comercial B2B (jun-2026)

Dos skills mexicanas para trabajo corporativo/transaccional, integradas al menú (opciones 13-14):

| Skill | Menú | Qué hace |
|-------|------|----------|
| `review-contract` | 13 | Revisión cláusula a cláusula vs. playbook con semáforo 🔴/🟡/🟢 y razonamiento holístico; redlines en control de cambios de Word con justificación (CCF/CCom). |
| `triage-nda` | 14 | Triaje masivo de NDAs en 3 flujos (estándar/asesor/completa); marco LFPDPPP, secreto industrial, art. 5 CPEUM. |

Reducen el tiempo de revisión a minutos y componen con `pdf`, `docx` y `itosturre-validator`.

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
