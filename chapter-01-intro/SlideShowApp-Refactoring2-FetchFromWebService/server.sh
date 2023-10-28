#!/bin/bash
echo "Static Python server started."
echo " Try on commandline curl http://localhost:8000/holidayslideshow.json"
echo " Try in browser http://localhost:8000/."
echo " Stop with CTRL-C"
/usr/bin/env python3 -m http.server  --directory ./ws-static-demo-data 8000
