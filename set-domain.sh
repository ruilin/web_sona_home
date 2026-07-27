#!/usr/bin/env bash
# Rewrite the site's absolute URLs (canonical, Open Graph, sitemap, robots) to a
# new origin. Run this after pointing a custom domain at the Vercel project —
# search engines treat a wrong canonical as a instruction to index the other URL,
# so these must match wherever the site actually lives.
#
#   ./set-domain.sh https://sona.app
#
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "usage: $0 https://your-domain.com" >&2
  exit 1
fi

NEW="${1%/}"
if [[ ! "$NEW" =~ ^https?:// ]]; then
  echo "error: include the scheme, e.g. https://sona.app" >&2
  exit 1
fi

CUR="$(grep -o 'https://[^"/]*' index.html | grep -v play.google | grep -v ruilin.github | head -1)"
if [[ -z "$CUR" ]]; then
  echo "error: could not detect the current origin in index.html" >&2
  exit 1
fi

echo "Rewriting $CUR -> $NEW"
for f in index.html sitemap.xml robots.txt; do
  [[ -f "$f" ]] || continue
  perl -pi -e "s{\Q$CUR\E}{$NEW}g" "$f"
  echo "  updated $f"
done

echo
echo "Done. Verify with:"
echo "  grep -n 'canonical\\|og:url\\|og:image' index.html"
