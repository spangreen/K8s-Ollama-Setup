#/bin/sh

#curl -s http://ollama.llm-host/v1/chat/completions -d '{ "model": "tinyllama", "stream": false, "messages": [ { "role": "user", "content": "Write a small Python program that reverses a string."} ] }' | jq '.choices[0].message.content'

curl -s http://ollama.llm-host/v1/models | jq '.data[].id'
