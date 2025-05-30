#/bin/sh
# try different curl tests

HOST=ollama.llm-host

# Just print out models
curl -s http://$HOST/v1/models | jq '.data[].id'

# Something more complex
curl -s http://$HOST/v1/chat/completions -d '{ "model": "qwen2.5:0.5b", "stream": false, "messages": [ { "role": "user", "content": "Write a small Python program that reverses a string. Just print the program."} ] }' | jq '.choices[0].message.content'
