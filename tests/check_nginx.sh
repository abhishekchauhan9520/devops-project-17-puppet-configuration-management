#!/usr/bin/env bash
set -euo pipefail

if systemctl is-active --quiet nginx; then
  echo 'nginx is running'
else
  echo 'nginx not running'
  exit 1
fi
