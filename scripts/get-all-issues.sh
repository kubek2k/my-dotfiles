#!/bin/bash

hub api notifications | jq '.[] | select(.subject.type == "Issue") | [.subject.title, .subject.url] | @csv' -r | tr -d '"' 
