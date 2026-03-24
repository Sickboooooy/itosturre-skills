# Itosturre Validator — Auditoría Legal Anti-Alucinaciones

Skill para validar documentos legales con protocolo VVCA, auditoría RAG y entrega de reporte PDF corporativo. Incluye verificación de corpus antes de proceder.

## Cuándo se activa

- Cuando se genera o modifica una Demanda de Nulidad, Concepto de Impugnación o cualquier documento legal
- Cuando se citan artículos o jurisprudencias en un borrador
- Cuando Fabián solicita una auditoría de un escrito

---

## Protocolo completo (ejecutar en orden estricto)

### PASO 0 — Verificación de corpus (OBLIGATORIA, NO OMITIR)

1. Leer el borrador e identificar todas las leyes, códigos y reglamentos citados o implicados
2. Comparar contra la lista de PDFs indexados en ChromaDB (ver CLAUDE.md → sección "ChromaDB RAG")
3. **Si hay leyes NO indexadas:**
   - DETENERSE completamente
   - Enviar mensaje por Telegram a Fabián (chat_id: 6621648166):

   > ⚠️ Corpus incompleto — antes de auditar encontré [N] ley(es) no indexada(s):
   > • [Ley o Código 1] — [Estado/Ámbito]
   > • [Ley o Código 2] — [Estado/Ámbito]
   >
   > ¿Procedo a buscarlas en fuente oficial e integrarlas al corpus antes de la auditoría?

   - Esperar confirmación explícita (sí/no) de Fabián
   - Si confirma: buscar PDF en fuente oficial → convertir → copiar a OneDrive/Documentos/ → re-indexar con OpenNotebook.py ingest
   - Si rechaza: continuar con nota "⚠️ Corpus parcial — resultados pueden ser incompletos"

4. **Si el corpus está completo:** continuar directamente al Paso 1

---

### PASO 1 — RAG Audit

```bash
source /home/licjo/venv/bin/activate
python3 /home/licjo/OpenNotebook.py audit --file /ruta/borrador.md
```

Analizar el JSON resultante:
- `"alerts"` → corregir automáticamente usando `"retrieved_sources"`
- No continuar si hay alerts sin resolver
- Documentar: N fuentes verificadas, N alertas resueltas

---

### PASO 2 — Aplicar semáforo VVCA a cada referencia

Para cada artículo o tesis citada:

| Color | Score | Acción |
|-------|-------|--------|
| 🟢 Verde | >85 | Citar con seguridad |
| 🟡 Amarillo | 60–84 | Citar con reserva, indicar |
| 🔴 Rojo | <60 | No citar — investigar más |

---

### PASO 3 — Guardar en Google Docs

```bash
source /home/licjo/venv/bin/activate
python3 /home/licjo/itosturre-core/gdocs.py "Título del documento" /ruta/borrador_auditado.md
```

---

### PASO 4 — Generar PDF corporativo Itosturre

```bash
source /home/licjo/venv/bin/activate
python3 /home/licjo/juicios/generar_pdf_auditoria.py
```

Estructura del PDF:
- Encabezado ITOSTURRE LEGALTECH (azul oscuro + cyan #4fb9df)
- Tablas VVCA con semáforo
- Mapa de riesgos
- Handoff al abogado
- Pie de carpeta con número de expediente

---

### PASO 5 — Notificar por Telegram

Mensaje final a chat_id 6621648166:

> ✅ Auditoría RAG completada
> 📄 Expediente: [nombre]
> 🔍 Fuentes verificadas: [N]
> ⚠️ Alertas resueltas: [N]
> 🟢 Score promedio VVCA: [score]
> 📎 Google Docs: [URL]
> 📄 PDF adjunto ↑

Adjuntar el PDF generado al mensaje de Telegram.

---

## Fallback (si OpenNotebook.py falla)

- Aplicar semáforo VVCA manualmente artículo por artículo
- Marcar con 🟡 todas las tesis no verificadas en el scraper SJF
- Notificar: "⚠️ Auditoría RAG no disponible — se aplicó VVCA manual. Recomiendo re-ejecutar cuando el sistema esté disponible."

---

## Fuentes oficiales para buscar leyes faltantes

1. Cámara de Diputados — diputados.gob.mx/LeyesBiblio/
2. DOF — dof.gob.mx
3. Congresos estatales (ej: hcnl.gob.mx para Nuevo León)
4. SCJN — scjn.gob.mx
5. SAT — sat.gob.mx

Proceso de indexación de ley nueva:
```bash
# 1. Descargar PDF oficial con wget o PowerShell
# 2. Copiar a OneDrive/Documentos/
cp /tmp/nueva_ley.pdf "/mnt/c/Users/licjo/OneDrive/Documentos/NOMBRE LEY 2026.pdf"

# 3. Re-indexar corpus
source /home/licjo/venv/bin/activate
python3 /home/licjo/OpenNotebook.py ingest --directory "/mnt/c/Users/licjo/OneDrive/Documentos/"

# 4. Verificar chunk count en output — debe aumentar
```
