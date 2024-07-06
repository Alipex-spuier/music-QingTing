while true; do
  bash -c 'echo " " >> src/web/faces.py'
  sleep 10

  sed -i '${/^[[:space:]]*$/d}' src/web/faces.py
  sleep 10
done
