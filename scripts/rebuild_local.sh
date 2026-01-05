#!/bin/bash
set -e

SITE=local.test

echo "🔥 REBUILDING LOCAL BENCH (DATA WILL BE LOST)"

read -p "Are you sure? This will DELETE the site. (yes/no): " CONFIRM
if [ "$CONFIRM" != "yes" ]; then
  echo "Aborted."
  exit 1
fi

cd ../..

bench drop-site $SITE --force || true

bench new-site $SITE
bench set-config -g developer_mode 1
bench --site $SITE install-app erpnext
bench --site $SITE install-app india_compliance
bench --site $SITE install-app logi

bench --site $SITE migrate
bench build
bench clear-cache

echo "✅ Local rebuild complete"
echo "👉 Run: bench start"

