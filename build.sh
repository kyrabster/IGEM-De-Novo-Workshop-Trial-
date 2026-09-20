#!/usr/bin/env sh
# Assembles the single self-contained page from src/ into index.html
# De Novo AI Bio-Design Studio · HKU iGEM
set -e
cd "$(dirname "$0")"

SRC=src
OUT=index.html

# Fail early and loudly if a piece is missing.
for f in \
  style.html \
  markup-1.html markup-2.html markup-3.html \
  core.js \
  steps-1-3.js steps-4-6.js steps-7-9.js steps-10-12.js \
  studio.js
do
  [ -f "$SRC/$f" ] || { printf 'missing: %s/%s\n' "$SRC" "$f" >&2; exit 1; }
done

{
  printf '<!doctype html>\n<html lang="en">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover">\n'
  cat "$SRC/style.html"
  printf '<style>body{margin:0}[hidden]{display:none!important}img{max-width:100%%}</style>\n</head>\n<body>\n'
  cat "$SRC/markup-1.html" "$SRC/markup-2.html" "$SRC/markup-3.html"
  printf '<script>\n'
  cat "$SRC/core.js" \
      "$SRC/steps-1-3.js" \
      "$SRC/steps-4-6.js" \
      "$SRC/steps-7-9.js" \
      "$SRC/steps-10-12.js" \
      "$SRC/studio.js"
  printf '</script>\n</body>\n</html>\n'
} > "$OUT"

printf 'Built %s (%s bytes)\n' "$OUT" "$(wc -c < "$OUT" | tr -d ' ')"
