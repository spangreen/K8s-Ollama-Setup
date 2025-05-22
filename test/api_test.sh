#/bin/sh

# This tests the openapi endpoint access to a running vllm instance
HOST=localhost
PORT=8000
API_KEY=abcde

# these can remain constant, even default for the model when using the openapi endpoint
ENDPOINT=v1/chat/completions
MODEL=default

# for openai
#ENDPOINT =v1/completions
URL="http://${HOST}:${PORT}/${ENDPOINT}"

echo curl -X POST  ${URL}  \
       -H "Content-Type: application/json" \
       -H "Authorization: Bearer ${API_KEY}" \
       -d \'{ \
         "model": ${MODEL}, \
         "prompt": "Hello, how are you?", \
         "max_tokens": 50 \
       }\'
