function set_slack_status {
    if [ -z "${SLACK_TOKEN}" ]; then
        echo "Can't set the status because no slack token is provided" >&2
        return 
    fi
    profile=`encodeURIComponent "{\"status_text\": \"$1\", \"status_emoji\": \"$2\"}"`
    curl -X POST "https://slack.com/api/users.profile.set?token=${SLACK_TOKEN}&profile=${profile}"
}

function send_to_slack {
    if [ -z "${SLACK_TOKEN}" ]; then
        echo "Can't set the status because no slack token is provided" >&2
        return 
    fi
    channel=$1
    text=`encodeURIComponent "$2"`
    curl -X POST "https://slack.com/api/chat.postMessage?token=${SLACK_TOKEN}&text=${text}&channel=${channel}&as_user=true"
}
