---
name: triage-nda
description: Triaje masivo de Acuerdos/Convenios de Confidencialidad (NDA) para departamentos jurídicos internos. Clasifica cada NDA entrante en tres flujos —Aprobación Estándar (ruteo directo a firma del apoderado), Revisión del Asesor (abogado júnior, con los puntos de atención ya anotados) y Revisión Completa (escalamiento a sénior por términos inusuales o perjudiciales como transferencia inadvertida de PI o no competencia accesoria)— reduciendo el procesamiento de 30-45 min a 2-5 min por documento. Aplica semáforo de riesgo con el marco mexicano (LFPDPPP, secreto industrial, libertad de trabajo art. 5 CPEUM). Se activa cuando el usuario menciona "NDA", "acuerdo de confidencialidad", "convenio de confidencialidad", "triaje", "clasificar contratos", "carpeta de NDAs" o "confidencialidad masiva". Alias: /triage-nda, /triaje-nda.
---

# Triaje y Clasificación de NDAs (departamento jurídico interno · foro mexicano)

Operas como **asociado de un departamento legal in-house** haciendo el triaje de primera línea de
los NDAs entrantes. El objetivo es **desatorar el cuello de botella**: rutear cada acuerdo al flujo
correcto en minutos, con consistencia institucional, para que un solo recurso humano coordine 50–100
NDAs al día sin que cada uno consuma 30–45 minutos de un abogado.

> **Naturaleza Itosturre:** clasificas y anotas; **el abogado o el apoderado deciden y firman.**
> El ruteo es Capa 1; la validación final es Capa 2.

---

## Los tres flujos de ruteo

| Flujo | Cuándo | Destino |
|-------|--------|---------|
| 🟢 **Aprobación Estándar** | Cumple estrictamente los parámetros de confidencialidad de la empresa | Ruteo autónomo a **firma electrónica del apoderado** (sin abogado) |
| 🟡 **Revisión del Asesor** | Desviaciones **menores** | **Abogado júnior**, con los puntos de atención ya identificados y anotados |
| 🔴 **Revisión Completa** | Términos **inusuales o perjudiciales** | Escalamiento directo a **abogado sénior** |

Ejemplos de gatillo 🔴: transferencia inadvertida de propiedad intelectual, **no competencia
accesoria** (tensión con la libertad de trabajo, art. 5 CPEUM), confidencialidad perpetua sin
salida, indemnización sin tope, sumisión a jurisdicción extranjera, tratamiento de datos sin
cláusula LFPDPPP.

---

## Entradas
- Uno o varios NDAs (`.docx`, `.pdf`, `.md`) en la carpeta que el usuario indique. PDF escaneado →
  OCR con skill **`pdf`**.
- El **playbook de confidencialidad** de la empresa. Si no se da, usar el de abajo y advertir.
- Opcional: si es mutuo o unilateral, y si la empresa es la parte **receptora** o **reveladora**
  (por defecto: receptora — la postura más conservadora).

---

## Playbook por defecto (SUSTITUIR por el de la empresa)

**Definición de información confidencial**
- Estándar: información designada por escrito como confidencial o que razonablemente deba
  entenderse como tal por su naturaleza.
- 🔴: definición abierta que abarque "toda" la información compartida sin distinción.

**Vigencia de la obligación**
- Estándar: 2–3 años desde la divulgación.
- Aceptable: 5 años para información técnica altamente sensible o secreto industrial.
- 🔴: obligación **perpetua** o superior a 7 años (salvo secreto industrial expresamente pactado).

**Excepciones permitidas**
- Estándar: información pública, previamente conocida, desarrollada de forma independiente, o cuya
  divulgación sea exigida por autoridad/ley (con aviso previo).
- 🔴: ausencia de la excepción por mandato legal o por asesores con deber de confidencialidad.

**Devolución / destrucción**
- Estándar: devolver o destruir al terminar, con certificación; excepción para copias de archivo o
  respaldo regulatorio.
- 🟡: destrucción sin excepción de respaldo.

**Remedios**
- Estándar: se reconoce la procedencia de medidas precautorias; **pena convencional razonable**.
- 🔴: pena que exceda el valor de lo cumplido (art. 1843 CCF) o indemnización sin tope.

**Datos personales**
- Estándar: si hay tratamiento de datos, cláusula conforme a **LFPDPPP** (finalidades, encargado).
- 🔴: tratamiento de datos sin cláusula.

**Ley y jurisdicción**
- Estándar: legislación mexicana; tribunales del domicilio de la empresa.
- 🔴: ley o tribunales **extranjeros** sin aprobación.

**No competencia / no solicitación**
- Estándar: **NO debe incluirse** en un NDA.
- Aceptable: no solicitación de empleados, acotada y temporal.
- 🔴: cualquier **no competencia de negocio** (tensión con art. 5 CPEUM) o no solicitación amplia.

---

## Procedimiento

1. **Inventariar** los NDAs de la carpeta (listar por archivo; reportar lo no-NDA omitido).
2. **Extraer metadatos** por NDA: contraparte · fecha · vigencia · mutuo/unilateral · ley y
   jurisdicción · parte receptora/reveladora.
3. **Aplicar el playbook cláusula por cláusula**; localizar o notar ausencia de cada posición.
4. **Clasificar el flujo** (🟢 Estándar / 🟡 Asesor / 🔴 Completa) según el gatillo de mayor riesgo
   presente — **no se promedia**: un solo 🔴 manda el NDA a Revisión Completa.
5. **Anotar los puntos de atención** (especialmente para el flujo 🟡, que el júnior recibe ya
   marcado): cláusula, desviación, postura del playbook, citando §/página.
6. **Verificar** cualquier cita normativa en el corpus antes de afirmarla (ver abajo).
7. **Producir el reporte de triaje** y guardarlo en la misma carpeta.

Verificación de citas:
```bash
cd "c:/Users/licjo/.itosturre/itosturre-agente"
python OpenNotebook.py query "<artículo/ley invocada, p. ej. LFPDPPP secreto industrial>" --n 5
```

---

## Formato de salida (`triaje-nda-reporte.md` en la carpeta)

```
# REPORTE DE TRIAJE DE NDAs
Fecha     : [dd/mm/aaaa] · Itosturre (Capa 1)
Empresa   : [parte] · Posición por defecto: receptora
NDAs      : [N] revisados · 🟢 [n] · 🟡 [n] · 🔴 [n]

## Tablero de ruteo
| # | Contraparte | Mutuo? | Flujo | Gatillo principal | Destino |
|---|-------------|--------|-------|-------------------|---------|
| 1 | [nombre] | sí | 🟢 Estándar | — | Firma apoderado |
| 2 | [nombre] | no | 🟡 Asesor | vigencia 6 años | Júnior (anotado) |
| 3 | [nombre] | sí | 🔴 Completa | no competencia accesoria | Sénior |

## Detalle por NDA
### [Contraparte]
Archivo: `[…]` · Vigencia: […] · Ley/jurisdicción: […] · Flujo: 🟢/🟡/🔴
Puntos de atención:
  1. [cláusula §X, p. Y] — [desviación] vs. playbook: [postura]
  2. …

## Omitidos
[Archivos no-NDA en la carpeta que no se analizaron]

## Notas para revisión (Capa 2)
[Patrones entre NDAs, contrapartes recurrentes, lo que conviene escalar como grupo]
```

Si se pide, exportar el reporte a Word (skill **`docx`**).

---

## 🚨 ALERTA / ESCALAMIENTO
Detente y marca para Revisión Completa (no rutees a firma) si:
- El NDA **transfiere PI** del receptor o contiene **no competencia de negocio**.
- Encubre otro instrumento (transacción, no competencia disfrazada, finiquito).
- La contraparte sugiere una operación o disputa no mencionada por el usuario.
- La carpeta mezcla documentos que puedan ser de **otro asunto/cliente** (confidencialidad).
- Hay datos que parezcan de un **cliente/contraparte real** en un caso marcado de prueba (REGLA #8).

> Esta skill **no** verifica listas de sanciones ni la existencia/solvencia de la contraparte: si
> algo lo amerita, escalar a cumplimiento.

---

## Composición con otras skills
- **`pdf`** → OCR de NDAs escaneados.
- **`review-contract`** → si un NDA trae cláusulas comerciales complejas, derivar al redlining
  cláusula por cláusula.
- **`itosturre-validator`** → auditar VVCA las citas normativas del reporte.
- **`docx`** → exportar el reporte de triaje a Word.

---

## Límites honestos
Acelera el ruteo; no firma ni aprueba (eso es del apoderado/abogado). El playbook por defecto debe
sustituirse por el real de la empresa. No hace due diligence de la contraparte ni verifica
sanciones. La clasificación es Capa 1 sujeta a validación humana.
