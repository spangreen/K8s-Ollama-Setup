#/bin/sh

# aider will use the openapi endpoint and pass "default" for the model
HOST=ollama.llm-host
PORT=80
API_KEY=abcde

URL="http://${HOST}:${PORT}/v1"
OPENAI_API_KEY=${API_KEY} aider --openai-api-base ${URL}
