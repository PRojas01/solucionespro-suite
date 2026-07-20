# Suite de Gobernanza IA — SolucionesPro

Punto de entrada único para instalar toda la suite. Gobernanza, orquestación,
automatización industrial, análisis de enlaces con evidencia trazable, y un
asesor comercial de WhatsApp — todos con aprobación humana obligatoria antes
de cualquier acción sensible.

## ¿No eres técnico?

Abre la guía interactiva — te acompaña paso a paso, con botones para copiar
cada comando: [`onboarding/guia-integrar-ia.html`](onboarding/guia-integrar-ia.html)

O simplemente escribe **"guía"** en el chat de tu asistente de IA (Claude Code,
Codex, opencode) y te guía él mismo.

## Instalación en un solo comando

```bash
curl -fsSL https://raw.githubusercontent.com/PRojas01/solucionespro-suite/main/install.sh | bash
```

Esto descarga los 5 módulos, instala sus dependencias, y te imprime los
comandos exactos para conectarlos a tu editor. No conecta nada por sí solo —
tú decides qué conectar.

## Catálogo de módulos

| Módulo | Qué hace | Madurez | Repo |
|---|---|---|---|
| **DevControl** | Gobernanza: aprueba/rechaza cambios de la IA, políticas de riesgo, compliance | GA | [sp-devcontrol](https://github.com/PRojas01/sp-devcontrol) |
| **devSteps** | Orquesta el ciclo de vida de un proyecto en pasos con aprobación humana | GA | [devSteps](https://github.com/PRojas01/devSteps) |
| **ForgePilot** | Automatización industrial (PLC, Modbus, SCADA) con agentes de IA | GA | [ForgePilot](https://github.com/PRojas01/ForgePilot) |
| **linkAnalizer** | Analiza un enlace y guarda evidencia trazable con cadena de custodia | GA | [SP-Linkanalizer](https://github.com/PRojas01/SP-Linkanalizer) |
| **Asesor1Pro** | Clasifica y sugiere respuestas comerciales de WhatsApp — tú apruebas cada envío | GA (piloto local) | [Asesor1Pro](https://github.com/PRojas01/Asesor1Pro) |

Herramienta transversal: **[llmgraph](https://github.com/PRojas01/llmgraph)**
comprime la documentación de cada proyecto para que los agentes de IA
consuman ~97% menos tokens. Se activa solo, no requiere configuración.

## Orden recomendado

1. **DevControl** — instálalo primero, es la gobernanza que protege todo lo demás.
2. **devSteps** — si vas a construir un proyecto desde cero.
3. **linkAnalizer** — el más simple para probar el patrón "un módulo, una superficie".
4. **ForgePilot** — si tienes procesos industriales que automatizar.
5. **Asesor1Pro** — si necesitas un asesor comercial de WhatsApp con supervisión humana.

## Seguridad

Todos los módulos comparten el mismo estándar: fail-closed por defecto (si
falta configuración, la acción se bloquea, nunca se permite por accidente),
autenticación obligatoria en toda escritura, y aprobación humana explícita
antes de cualquier acción irreversible o sensible. Ver el `SECURITY.md` /
sección de seguridad de cada repo para el detalle.

## Superficies

Cada módulo GA está disponible como: app/CLI, servidor MCP (Claude Code,
Codex, ChatGPT), skill de Claude, skill de Codex, plugin de Claude Code, y
extensión de editor (VS Code, Cursor, Windsurf).
