#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MODULE_PATH="$ROOT_DIR/modules"

sudo puppet apply --modulepath="$MODULE_PATH" "$ROOT_DIR/manifests/site.pp"
