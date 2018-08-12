function connect_to_psql {
    if [ -z "$1" ]; then
        echo 'No URL provided' >2
        return 1
    fi
    nix-shell -p postgresql --command "psql $1"
}

function connect_to_heroku_psql {
    local env_name
    env_name="$1"
    if [ -z "$env_name" ]; then
        echo "Falling back to DATABASE_URL"
        env_name="DATABASE_URL"
    fi
    URL=`heroku config:get "${env_name}"`
    connect_to_psql "$URL"
}

function connect_to_local_psql {
    local env_name
    env_name="$1"
    if [ -z "$env_name" ]; then
        echo "Falling back to DATABASE_URL"
        env_name="DATABASE_URL"
    fi
    URL=`cat .env | grep ${env_name} | head | cut -f2 -d= | tr -d "\'"`
    connect_to_psql "$URL"
}


