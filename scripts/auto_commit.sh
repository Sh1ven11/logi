#!/bin/bash
set -e

cd apps/logi

read -p "Commit message: " MSG

git add .
git commit -m "$MSG" || echo "Nothing to commit"
git push origin Main

echo "✅ Code pushed to GitHub"

