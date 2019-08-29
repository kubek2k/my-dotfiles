#!/bin/bash

owner="$1"
repo="$2"
id="$3"

hub api repos/$owner/$repo/issues/$id | jq '"# " + .title + "\n" + .html_url + "\n## @" + .user.login + " created issue " + .updated_at + "\n" + (.labels | [.[] | "**" + .name + "**"] | join(" ")) + "\n\n" + .body' -r 
hub api repos/$owner/$repo/issues/$id/comments | jq '.[] | "\n## @" + .user.login + " commented " + .updated_at + "\n\n" + .body' -r 
