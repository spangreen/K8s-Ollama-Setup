#/bin/sh

# aider will use the openapi endpoint and pass "default" for the model
HOST=localhost
PORT=8000
API_KEY=abcde

URL="http://${HOST}:${PORT}/v1"
OPENAI_API_KEY=${API_KEY} aider -openai-api-base ${URL}
