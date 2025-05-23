#/bin/sh

curl http://llm-host:31134/api/chat -d '{ "model": "tinyllama", "stream": false, "messages": [ { "role": "user", "content": "Write a Python function that reverses a string." } ] }' | jq -r '.message.content'
