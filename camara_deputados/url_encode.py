# Codificar cada linha da entrada como um parametro URL

import sys
import urllib.parse


lines = sys.stdin.readlines()

for line in lines:
    print(urllib.parse.quote(line.strip()))
