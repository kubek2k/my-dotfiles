curl -s https://slack.com/api/chat.postMessage -X POST -d "{ \"channel\": \"$1\", \"text\": \"$2\", \"as_user\": true}" -H "Authorization: Bearer $SLACK_TOKEN" -H "Content-Type: application/json; charset=utf-8"