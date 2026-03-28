#!/usr/bin/env python3

from pathlib import Path

from httk.web import publish

ROOT = Path(__file__).parent
publish(ROOT / "src", ROOT / "public", "http://127.0.0.1/")

print("*****\nNow open public/index.html in your web browser.\n*****")
