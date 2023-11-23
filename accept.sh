echo "HTTP/1.1 202\nContent-Length: 0" | nc -l 8018 -W 1 | head -1 | sed 's/POST \///; s/\sHTTP.*//'
