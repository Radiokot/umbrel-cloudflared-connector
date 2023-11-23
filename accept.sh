cat default-response | nc -lp 8018 -W 1 | head -1 | sed 's/POST \///; s/\sHTTP.*//'
