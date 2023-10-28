#!/bin/zsh
echo "We start up a local python server on the commandline... (try open http://localhost:8000/)"
/usr/bin/env python3 -m http.server  --directory ./heros-demo-data 8000