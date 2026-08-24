#!/usr/bin/env bash
set -euo pipefail

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

required_files=(
  "$root_dir/manifests/site.pp"
  "$root_dir/modules/webserver/manifests/init.pp"
  "$root_dir/modules/webserver/templates/nginx.conf.erb"
  "$root_dir/modules/webserver/files/index.html"
  "$root_dir/modules/users/manifests/init.pp"
)

for file in "${required_files[@]}"; do
  test -f "$file"
done

grep -q "include webserver" "$root_dir/manifests/site.pp"
grep -q "include users" "$root_dir/manifests/site.pp"
grep -q "package { 'nginx'" "$root_dir/modules/webserver/manifests/init.pp"
grep -q "file { '/var/www/myapp/index.html'" "$root_dir/modules/webserver/manifests/init.pp"
grep -q "puppet:///modules/webserver/index.html" "$root_dir/modules/webserver/manifests/init.pp"
grep -q "service { 'nginx'" "$root_dir/modules/webserver/manifests/init.pp"
grep -q "require => Package\['nginx'\]" "$root_dir/modules/webserver/manifests/init.pp"
grep -q "user { 'deploy'" "$root_dir/modules/users/manifests/init.pp"

echo "Project 17 structural checks passed."
