#!/usr/bin/env bash
set -euo pipefail

# -----------------------
# Configura el path de PD2
# -----------------------
PD2_DIR="$HOME/Games/Diablo II/ProjectD2"
SETTINGS_JSON="$PD2_DIR/AppData/launcherSettings.json"
FILTERS_DIR="$PD2_DIR/filters/online"
ACTIVE_FILTER="$PD2_DIR/loot.filter"

# Validar las opciones
if [[ $# -ne 1 ]]; then
    echo "Uso: $0 [E|K]"
    echo "E para Erazure-Main y K para Kryszard"
    exit 1
fi

FILTER_TYPE="$1"

case "$FILTER_TYPE" in
E)
    AUTHOR_NAME="Erazure's PD2 Loot Filter"
    AUTHOR_AUTHOR="Erazure"
    AUTHOR_URL="https://api.github.com/repos/FiltersBy-Erazure/PD2-Loot-Filter/contents"

    FILE_NAME="Erazure-Main.filter"
    FILE_DOWNLOAD="https://raw.githubusercontent.com/FiltersBy-Erazure/PD2-Loot-Filter/main/Erazure-Main.filter"
    FILE_URL_API="https://api.github.com/repos/FiltersBy-Erazure/PD2-Loot-Filter/contents/Erazure-Main.filter?ref=main"
    FILE_HTML="https://github.com/FiltersBy-Erazure/PD2-Loot-Filter/blob/main/Erazure-Main.filter"
    FILE_GIT="https://api.github.com/repos/FiltersBy-Erazure/PD2-Loot-Filter/git/blobs/740df9ad4ed13694f8a3a9e3fbdb1c2fbaf7ac6d"
    FILE_SHA="740df9ad4ed13694f8a3a9e3fbdb1c2fbaf7ac6d"
    FILE_SIZE=770819
    ;;
K)
    AUTHOR_NAME="Kryszard's PD2 Loot Filter"
    AUTHOR_AUTHOR="Kryszard"
    AUTHOR_URL="https://api.github.com/repos/Kryszard-POD/Kryszard-s-PD2-Loot-Filter/contents"

    FILE_NAME="item.filter"
    FILE_DOWNLOAD="https://raw.githubusercontent.com/Kryszard-POD/Kryszard-s-PD2-Loot-Filter/main/item.filter"
    FILE_URL_API="https://api.github.com/repos/Kryszard-POD/Kryszard-s-PD2-Loot-Filter/contents/item.filter?ref=main"
    FILE_HTML="https://github.com/Kryszard-POD/Kryszard-s-PD2-Loot-Filter/blob/main/item.filter"
    FILE_GIT="https://api.github.com/repos/Kryszard-POD/Kryszard-s-PD2-Loot-Filter/git/blobs/a1f137ca8fea2dd0013db1429ab41666f3007e75"
    FILE_SHA="a1f137ca8fea2dd0013db1429ab41666f3007e75"
    FILE_SIZE=720579
    ;;
*)
    echo "Debes usar una opción: E or K"
    exit 1
    ;;
esac

# -----------------------
# Chequea que existan los archivos
# -----------------------
[[ -f "$SETTINGS_JSON" ]] || {
    echo "Falta el archivo $SETTINGS_JSON"
    exit 1
}

[[ -f "$FILTERS_DIR/$FILE_NAME" ]] || {
    echo "Falta el archivo de filtro $FILE_NAME"
    exit 1
}

# -----------------------
# Descomentar para hacer backup a los settings antes de cambiar el filtro
# -----------------------
# cp "$SETTINGS_JSON" "$SETTINGS_JSON.bak.$(date +%s)"

# -----------------------
# Actualizar SelectedAuthorAndFilter
# -----------------------
jq \
  --arg author_name "$AUTHOR_NAME" \
  --arg author_url "$AUTHOR_URL" \
  --arg author_author "$AUTHOR_AUTHOR" \
  --arg file_name "$FILE_NAME" \
  --arg download "$FILE_DOWNLOAD" \
  --arg path "$FILE_NAME" \
  --arg sha "$FILE_SHA" \
  --argjson size "$FILE_SIZE" \
  --arg url "$FILE_URL_API" \
  --arg html "$FILE_HTML" \
  --arg git "$FILE_GIT" \
'
.SelectedAuthorAndFilter = {
  selectedAuthor: {
    name: $author_name,
    url: $author_url,
    author: $author_author
  },
  selectedFilter: {
    name: $file_name,
    download_url: $download,
    path: $path,
    sha: $sha,
    size: $size,
    url: $url,
    html_url: $html,
    git_url: $git,
    type: "file"
  }
}
' "$SETTINGS_JSON" > "$SETTINGS_JSON.tmp"

mv "$SETTINGS_JSON.tmp" "$SETTINGS_JSON"

# -----------------------
# Activa el filtro, lo copia a ProjectD2/loot.filter
# -----------------------
cp "$FILTERS_DIR/$FILE_NAME" "$ACTIVE_FILTER"

echo "Filtro de loot cambiado a: $AUTHOR_NAME"
