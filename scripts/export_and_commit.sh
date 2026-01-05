#!/bin/bash
set -e

SITE=local.test
APP=logi

echo "📦 Exporting fixtures for $APP"
cd ../..
bench --site $SITE export-fixtures --app $APP

cd apps/logi

echo "📄 Git status:"
git status

read -p "Commit message: " MSG

git add .
git commit -m "$MSG" || echo "Nothing to commit"
git push origin Main

echo "✅ Exported fixtures + pushed to GitHub"

