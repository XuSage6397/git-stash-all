#!/bin/bash

for repo in $(find . -type d -name ".git" | sed 's|/.git||'); do
  echo "Checking $repo..."
  cd "$repo" || continue
  
  # 检查是否有未提交的更改
  if git diff --quiet && git diff --cached --quiet; then
    echo "✅ Clean repository, skipping: $repo"
  else
    git stash push -m "Batch stash" && echo "✅ Stashed: $repo" || echo "❌ Failed: $repo"
  fi
  
  cd - > /dev/null
done
