#!/usr/bin/env sh
# Assembles the single self-contained page from src/ into index.html
# De Novo AI Bio-Design Studio
set -e
cd "$(dirname "$0")"

{
  printf '<!doctype html>\n<html lang="en">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover">\n'
  cat src/style.html
  printf '<style>body{margin:0}[hidden]{display:none!important}img{max-width:100%%}</style>\n</head>\n<body>\n'
  cat src/markup-1.html src/markup-2.html src/markup-3.html
  printf '<script>\n'
  cat src/core.js src/steps-1-3.js src/steps-4-6.js src/steps-7-9.js src/steps-10-12.js src/studio.js
  printf '</script>\n</body>\n</html>\n'
} > index.html

echo "Built index.html ($(wc -c < index.html) bytes)"
