sleep 5
if curl -L web | grep -q 'title'; then
  echo "Tests passed!"
  exit 0
else
  echo "Tests failed!"
  echo `curl -L web`
  exit 1
fi
