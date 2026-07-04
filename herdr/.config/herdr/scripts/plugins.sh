set -e

plugins=(
  "PhucBruh/herdr-launcher"
  "PhucBruh/herdr-mode"
)

installed=$(herdr plugin list 2>/dev/null)

for p in "${plugins[@]}"; do
  if ! echo "$installed" | grep -qi "$(basename $p)"; then
    echo "Installing $p..."
    herdr plugin install "$p" --yes
  else
    echo "$p already installed"
  fi
done
