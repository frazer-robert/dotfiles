git diff --cached --quiet $2

if [ $? -eq 0 ]; then
  git add $2
else
  git reset --quiet $2
fi
