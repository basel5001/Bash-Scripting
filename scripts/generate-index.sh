#!/usr/bin/env bash
# generate-index.sh — Generates SCRIPTS.md index from all .sh files in the repo
set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || dirname "$0"/..)"
OUTPUT="$REPO_ROOT/SCRIPTS.md"

{
  echo "# Script Index"
  echo ""
  echo "Auto-generated index of all scripts in this repository."
  echo ""
  echo "| Script | Description |"
  echo "|--------|-------------|"

  find "$REPO_ROOT" -name "*.sh" -not -path "*/.git/*" -not -path "*/node_modules/*" | sort | while read -r script; do
    rel_path="${script#$REPO_ROOT/}"
    # Get description from first comment line (after shebang)
    description=$(sed -n '2s/^#[[:space:]]*//p' "$script" 2>/dev/null | head -1)
    if [[ -z "$description" ]]; then
      description="_(no description)_"
    fi
    echo "| \`$rel_path\` | $description |"
  done

  echo ""
  echo "---"
  echo ""
  echo "## Scripts by Directory"
  echo ""

  find "$REPO_ROOT" -name "*.sh" -not -path "*/.git/*" -printf "%h\n" 2>/dev/null | sort -u | while read -r dir; do
    rel_dir="${dir#$REPO_ROOT/}"
    [[ "$rel_dir" == "$REPO_ROOT" ]] && rel_dir="."
    echo "### \`$rel_dir/\`"
    echo ""
    find "$dir" -maxdepth 1 -name "*.sh" | sort | while read -r script; do
      rel_path="${script#$REPO_ROOT/}"
      description=$(sed -n '2s/^#[[:space:]]*//p' "$script" 2>/dev/null | head -1)
      echo "- **\`$(basename "$script")\`** — ${description:-_(no description)_}"
    done
    echo ""
  done

  echo "---"
  echo "_Generated on $(date -u '+%Y-%m-%d %H:%M UTC') by \`scripts/generate-index.sh\`_"
} > "$OUTPUT"

echo "[INFO] Generated $OUTPUT"
