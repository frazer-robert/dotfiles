git reset -- $2

if [ "$1" == "M" ] || [ "$1" == "D" ]; then
  git checkout -- $2
else
  git clean -fd $2
fi
