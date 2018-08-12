function send_notification {
    MESSAGE=$1
    terminal-notifier -message "$MESSAGE" -title "Bash notification"
}

function o {
    COMMAND=$*
    $COMMAND && send_notification "'$COMMAND' done" || send_notification "'$COMMAND' not successful'"
}

