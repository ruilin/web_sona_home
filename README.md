# Sona — marketing site

Static one-page site for [Sona](https://play.google.com/store/apps/details?id=com.ruilin.sona),
a voice-first Android notes app. No build step, no dependencies — plain HTML with
inline CSS and one self-hosted font.

## Deploying on Vercel

Import the repo at [vercel.com/new](https://vercel.com/new). Vercel serves the
repo root as a static site; leave the framework preset as **Other** and leave the
build/output settings empty. `vercel.json` supplies the cache and security
headers.

## Changing the domain

`canonical`, the Open Graph tags, `sitemap.xml` and `robots.txt` all contain
absolute URLs, and they must match wherever the site is actually served — a
canonical pointing somewhere else tells Google to index that other URL instead.
After attaching a custom domain, rewrite them all in one go:

```sh
./set-domain.sh https://your-domain.com
git commit -am "point site at your-domain.com" && git push
```

Then submit `https://your-domain.com/sitemap.xml` in
[Google Search Console](https://search.google.com/search-console).

## Files

| File | Purpose |
|---|---|
| `index.html` | The whole page — markup, CSS and the hero animation |
| `manrope.ttf` | Brand typeface, self-hosted so there is no third-party request |
| `og-cover.png` | 1200×630 social share image |
| `favicon.svg` / `icon-180.png` | Tab icon and iOS home-screen icon |
| `sitemap.xml` / `robots.txt` | Crawler directives |
| `vercel.json` | Cache + security headers |
| `set-domain.sh` | Rewrites absolute URLs to a new origin |

## Notes

- The privacy policy is hosted separately (linked from the footer) because the
  Play Console listing already points at that URL.
- The hero animation is paused while off-screen and skipped entirely under
  `prefers-reduced-motion`.
- Both light and dark themes are defined; the page follows the visitor's system
  preference.

Source of truth for the design tokens is the app itself — the palette is lifted
from `lib/theme/app_theme.dart` in the app repo, so the site and the product
match.
