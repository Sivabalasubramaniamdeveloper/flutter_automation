#!/bin/bash

# === Configuration ===
MODEL="gpt-4o-mini"  # You can change to gpt-4o, gpt-3.5-turbo, etc.
#OPENAI_API_KEY="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" # Load from env if available

#!/bin/bash

MODEL="gpt-4o-mini"
API_KEY="${OPENAI_API_KEY:-}"

if [ -z "$API_KEY" ]; then
    read -sp "🔑 Enter your OpenAI API Key: " API_KEY
    echo
fi

HISTORY='[{"role":"system","content":"You are a helpful assistant"}]'

echo "🤖 AI Assistant - Type 'exit' to quit."

while true; do
    read -p "You: " USER_INPUT
    if [[ "$USER_INPUT" == "exit" ]]; then
        break
    fi

    RESPONSE=$(curl -s https://api.openai.com/v1/chat/completions \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer $API_KEY" \
      -d "{
            \"model\": \"$MODEL\",
            \"messages\": [{\"role\": \"user\", \"content\": \"$USER_INPUT\"}]
          }")

    # Extract and display just the AI's message content
    echo -n "AI: "
    echo "$RESPONSE" | jq -r '.choices[0].message.content'
done