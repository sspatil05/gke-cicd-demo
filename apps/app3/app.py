import os
from http.server import BaseHTTPRequestHandler, HTTPServer

APP_NAME = os.getenv("APP_NAME", "app3")
VERSION = os.getenv("APP_VERSION", "dev")


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/healthz":
            body = b"ok\n"
        else:
            body = f"Hello World from {APP_NAME} (version {VERSION})\n".encode()
        self.send_response(200)
        self.send_header("Content-Type", "text/plain; charset=utf-8")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)


if __name__ == "__main__":
    HTTPServer(("0.0.0.0", 8080), Handler).serve_forever()