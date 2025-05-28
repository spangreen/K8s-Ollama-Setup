#/bin/sh

#curl -s http://ollama.llm-host/v1/chat/completions -d '{ "model": "tinyllama", "stream": false, "messages": [ { "role": "user", "content": "Write a Python function that reverses a string." } ] }' | jq -r '.message.content'

curl -s http://ollama.llm-host/v1/models | jq '.data[].id'
