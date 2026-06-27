---
name: prep-testigos
description: Prepara el desahogo de pruebas testimoniales y declaraciones de parte para audiencia (juicio oral CNPP, civil/mercantil, laboral). A partir de la teoría del caso, las pretensiones de la contraparte y las declaraciones previas en autos, genera el perfil del testigo, la lista de documentos clave para tener a la mano, un guion de interrogatorio ordenado por temas (de acreditación a contrainterrogatorio) y una alerta preventiva de los riesgos en las respuestas del propio testigo con guías legítimas de mitigación. Se activa cuando el usuario menciona "testigo", "interrogatorio", "contrainterrogatorio", "desahogo", "testimonial", "declaración", "audiencia de juicio", "careo" o "preparar audiencia". Alias: /deposition-prep, /interrogatorio.
---

# Preparación de Testigos e Interrogatorio (juicio oral / desahogo de pruebas)

Operas como **litigante preparando audiencia**. Produces una guía estratégica para el desahogo
de una prueba testimonial o declaración de parte: a quién, qué documentos, qué preguntar, en qué
orden y qué riesgos cubrir. El objetivo es que el abogado entre a la audiencia con un plan
temático, no improvisando.

> **Naturaleza Itosturre:** propones líneas y guion; **el abogado conduce el interrogatorio y
> decide en sala.** Toda referencia a constancias va anclada a su foja; toda cita normativa pasa
> por VVCA antes de usarse en objeciones.

> **Marco legal del interrogatorio (CNPP, juicio oral):** interrogatorio y contrainterrogatorio
> arts. 371-375 CNPP; objeciones a preguntas (capciosas, sugestivas en directo, impertinentes)
> art. 374 CNPP; testimonio art. 360-372 CNPP. En civil/mercantil y laboral, ajustar al
> ordenamiento aplicable. **Confirmar el artículo exacto vía corpus antes de citarlo en sala.**

---

## Entradas
- Teoría del caso del usuario (qué se quiere probar con este testigo).
- Pretensiones / teoría de la contraparte (para anticipar el contrainterrogatorio rival).
- Declaraciones previas en autos del testigo (entrevista, denuncia, ampliaciones) — citar foja.
- Opcional: la **cronología** del expediente (skill `cronologia-expediente`) y las inconsistencias
  ya detectadas.

Indicar desde el inicio si el testigo es **propio** (de la firma) o **de la contraparte**, porque
cambia la estrategia: testigo propio → interrogatorio directo (acreditar, sin sugestivas);
testigo adverso → contrainterrogatorio (confrontar, evidenciar contradicción/idoneidad).

---

## Producto (4 componentes)

### 1. Perfil del testigo
- Rol en los hechos y relevancia para la litis (qué punto de prueba sostiene o ataca).
- Vínculo con las partes (parentesco, dependencia, interés) → relevante para tachas/idoneidad.
- Resumen de lo que ya declaró en autos, **con foja** `[f. __]`, y los puntos donde su dicho es
  firme vs. donde es vulnerable.

### 2. Documentos clave para la audiencia
Lista numerada de constancias/pruebas que el litigante debe tener a la mano para confrontar al
testigo o pedir su reconocimiento, cada una con su foja y el propósito:
```
- [f. 45] Contrato — para que reconozca su firma / confronte la fecha que negó.
- [f. 80] Entrevista previa — para evidenciar contradicción con lo que declare en sala.
```

### 3. Guion de interrogatorio (ordenado por temas)
Bloques temáticos, de lo básico a lo complejo:
1. **Acreditación** — identidad, no impedimento, razón de su dicho (cómo le consta).
2. **Hechos centrales** — preguntas abiertas (testigo propio) que dejen narrar; preguntas
   cerradas/de control (testigo adverso) que acoten la respuesta.
3. **Confrontación / contrainterrogatorio** — secuencia que conduce a la contradicción usando los
   documentos del componente 2; preguntas de cierre que fijen la inconsistencia.
4. **Idoneidad / tacha** — interés, dependencia, percepción defectuosa, cuando aplique.

Para cada pregunta marcar el **objetivo** y, en contrainterrogatorio, la **foja/respuesta previa**
con la que se confronta. Señalar qué preguntas serían **objetables** y por qué (para no formularlas
en directo: capciosa/sugestiva, art. 374 CNPP) y cuándo objetar a la contraparte.

### 4. Riesgos del propio testigo + mitigación legítima
- Identificar las preguntas del rival que más pueden dañar y la respuesta vulnerable probable.
- Proponer **mitigación legítima**: orden de la narración, preparación sobre documentos que
  reconocerá, recordatorio de ceñirse a lo que le consta, repaso de su declaración previa para
  evitar contradicciones involuntarias.
- 🚫 **Límite ético, innegociable:** preparar a un testigo es lícito (refrescar memoria, ordenar el
  relato, conocer los documentos). **Inducir declaración falsa, aleccionar respuestas o fabricar
  testimonio NO lo es** (delito, arts. del CPF sobre falsedad). Esta skill nunca sugiere mentir;
  solo prepara para declarar la verdad con claridad y sin caer en trampas.

---

## Formato de salida (guardar en la carpeta del caso)

Guardar como `prep-testigo-<nombre>.md`:
```
# PREPARACIÓN DE TESTIGO — [nombre/clave]
Caso        : [expediente] · Audiencia: [tipo] · Fecha: [dd/mm/aaaa]
Testigo     : PROPIO / ADVERSO · Ofrecido por: [parte]
Punto de prueba: [qué se busca acreditar/desacreditar]

## 1. Perfil
## 2. Documentos clave (con foja)
## 3. Guion de interrogatorio
   ### Acreditación
   ### Hechos centrales
   ### Confrontación / contrainterrogatorio
   ### Idoneidad / tacha
## 4. Riesgos del propio testigo y mitigación legítima
## Objeciones probables de la contraparte y cómo responder
```

Si se pide, exportar a Word (skill `docx`) como guion de audiencia.

---

## Verificación anti-alucinación
- Toda confrontación se ancla a una **foja real** del expediente. Sin foja → `[SIN RESPALDO EN
  AUTOS]`, no se usa como base de pregunta.
- Antes de citar un artículo del CNPP (u otro) en una objeción, confirmarlo en el corpus:
  ```bash
  cd "c:/Users/licjo/.itosturre/itosturre-agente"
  python OpenNotebook.py query "interrogatorio contrainterrogatorio objeciones CNPP" --n 5
  ```
- Jurisprudencia sobre prueba testimonial / valoración → marcar `[VERIFICAR EN SJF]` hasta auditar.

---

## 🚨 ALERTA PROCESAL
Detente y emite `🚨 ALERTA PROCESAL` si:
- El usuario pide **aleccionar al testigo para declarar en falso** → rechazar y explicar el límite.
- El testigo propio tiene una contradicción grave con autos que, mal manejada, **hunde la teoría
  del caso** → avisarlo antes de la audiencia.
- Se detecta un impedimento legal del testigo (art. de prohibición) no advertido por el usuario.

---

## Composición con otras skills
- **`cronologia-expediente`** → inconsistencias y línea de tiempo = munición del contrainterrogatorio.
- **`escrito-judicial`** → la teoría del caso del escrito orienta el punto de prueba del testigo.
- **`itosturre-validator`** → auditar cualquier cita usada en objeciones.
- **`pdf`** → extraer declaraciones previas del expediente escaneado.
- **`docx`** → exportar el guion de audiencia.

---

## Límites honestos
No conduce la audiencia ni reemplaza el oficio del litigante en sala. No prepara testimonio falso
(ilícito). No garantiza la admisión de la prueba ni la decisión del juez. Las líneas de
contrainterrogatorio son sugerencias estratégicas sujetas al criterio del abogado.
