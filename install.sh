#!/usr/bin/env bash
# Instalador de la Suite de Gobernanza IA (para no técnicos).
# Descarga (clona) cada módulo desde GitHub, instala sus dependencias, y te
# deja las instrucciones exactas para conectarlo a tu editor/asistente de IA.
#
# Uso:
#   bash install.sh                 (clona/instala todos los módulos en ./suite-ia)
#   bash install.sh /ruta/destino   (usa esa carpeta en vez de ./suite-ia)
#
# Por seguridad este script NUNCA conecta nada a tu editor por sí solo — solo
# descarga e instala. La conexión (MCP, plugin, extensión) la haces tú con
# los comandos exactos que te imprime al final, o le pides a tu asistente
# "conéctame <módulo>" y él te guía.
set -uo pipefail

DEST="${1:-$(pwd)/suite-ia}"

say()  { printf "\n\033[1;36m%s\033[0m\n" "$*"; }
ok()   { printf "  \033[1;32m✓\033[0m %s\n" "$*"; }
warn() { printf "  \033[1;33m!\033[0m %s\n" "$*"; }
err()  { printf "  \033[1;31m✗\033[0m %s\n" "$*"; }

command -v git >/dev/null 2>&1 || { err "Necesitas git instalado primero (https://git-scm.com/downloads)"; exit 1; }
command -v node >/dev/null 2>&1 || { err "Necesitas Node.js instalado primero (https://nodejs.org)"; exit 1; }

say "Suite de Gobernanza IA — instalador"
echo "Voy a descargar los 5 módulos en: $DEST"
mkdir -p "$DEST"

# nombre-carpeta | repo GitHub | comando de build/prep (vacío = solo npm install)
MODULES=(
  "sp-devcontrol|https://github.com/PRojas01/sp-devcontrol.git|npm run build"
  "devSteps|https://github.com/PRojas01/devSteps.git|npm run build"
  "ForgePilot|https://github.com/PRojas01/ForgePilot.git|"
  "SP-Linkanalizer|https://github.com/PRojas01/SP-Linkanalizer.git|npm run build"
  "Asesor1Pro|https://github.com/PRojas01/Asesor1Pro.git|"
)

for entry in "${MODULES[@]}"; do
  IFS='|' read -r name repo build <<<"$entry"
  say "$name"
  dir="$DEST/$name"
  if [ -d "$dir/.git" ]; then
    ok "ya estaba descargado, actualizando..."
    (cd "$dir" && git pull --ff-only >/dev/null 2>&1) && ok "actualizado" || warn "no se pudo actualizar automáticamente (¿cambios locales?), sigo con lo que hay"
  else
    if git clone --depth 1 "$repo" "$dir" >/dev/null 2>&1; then
      ok "descargado"
    else
      err "no pude descargar $name — revisa tu conexión a internet"
      continue
    fi
  fi
  if [ -f "$dir/package.json" ]; then
    (cd "$dir" && npm install >/dev/null 2>&1) && ok "dependencias instaladas" || warn "npm install falló, revisa manualmente"
    if [ -n "$build" ]; then
      (cd "$dir" && eval "$build" >/dev/null 2>&1) && ok "listo para usar" || warn "build falló, revisa manualmente"
    fi
  fi
done

say "Listo. Los 5 módulos están descargados en: $DEST"
echo
echo "Siguiente paso — conecta cada uno a tu editor/asistente con UNO de estos comandos"
echo "(copia el que corresponda a tu herramienta; puedes conectar varios):"
echo
echo "  Claude Code (o Codex, con 'codex mcp add' en vez de 'claude mcp add'):"
echo "    claude mcp add sp-devcontrol -- node $DEST/sp-devcontrol/dist/mcp.js"
echo "    claude mcp add linkanalizer  -- node $DEST/SP-Linkanalizer/scripts/mcp_server.mjs"
echo "    claude mcp add asesor1pro    -- node $DEST/Asesor1Pro/scripts/mcp_server.mjs"
echo
echo "  CLI directo (funciona en cualquier terminal):"
echo "    $DEST/sp-devcontrol/dist/cli.js --help"
echo "    $DEST/devSteps/dist/cli.js --help"
echo "    $DEST/ForgePilot/cli/bin/forgepilot --help"
echo
echo "  VS Code / Cursor / Windsurf (pestaña del editor):"
echo "    cd $DEST/<módulo>/extension && npx vsce package && code --install-extension *.vsix"
echo
echo "¿Dudas? Abre la guía interactiva (guia-integrar-ia.html) o escribe \"guía\" en el chat de tu editor."
