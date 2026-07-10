#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

if ! command -v yazi &>/dev/null; then
	echo "Installing yazi..."
	sudo apt install -y yazi
fi

echo "Installing plugins from package.toml..."
ya pkg install
