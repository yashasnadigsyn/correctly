#!/usr/bin/env sh

# Set base URL, API key, model ID, and temperature
BASE_URL="http://localhost:1234/v1"
API_KEY="lm-studio"
MODEL_ID="GRMR-2b-instruct-GGUF"
TEMPERATURE="0.0"

# Set system prompt
SYSTEM_PROMPT="Below is the original text. Please rewrite it to correct any grammatical errors if any, improve clarity, and enhance overall readability."

# Get user prompt from clipboard
USER_PROMPT=$(wl-paste) || {
  echo "Error: Failed to get user prompt from clipboard" >&2
  exit 1
}

# Create payload using jq
PAYLOAD=$(jq -n \
  --arg model "$MODEL_ID" \
  --arg system_prompt "$SYSTEM_PROMPT" \
  --arg user_prompt "$USER_PROMPT" \
  --arg temp "$TEMPERATURE" \
  '{
    "model": $model,
    "messages": [
      {"role": "system", "content": $system_prompt},
      {"role": "user", "content": $user_prompt}
    ],
    "temperature": ($temp | tonumber)
  }') || {
  echo "Error: Failed to create payload" >&2
  exit 1
}

# Send request to API
RESPONSE=$(curl -s -X POST \
  "$BASE_URL/chat/completions" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_KEY" \
  -d "$PAYLOAD") || {
  echo "Error: Failed to send request to API" >&2
  exit 1
}

# Extract response content using jq
RESPONSE_CONTENT=$(echo "$RESPONSE" | jq -r '.choices[0].message.content') || {
  echo "Error: Failed to extract response content" >&2
  exit 1
}

# Send notification and copy response content to clipboard
notify-send "Correctly" "$RESPONSE_CONTENT" --action "copy" -u critical -t 0
if [ $? -eq 0 ]; then
  echo "$RESPONSE_CONTENT" | wl-copy
fi
