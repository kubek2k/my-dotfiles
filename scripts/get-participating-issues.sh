#!/bin/bash

hub api notifications?participating=true | jq '.[] | [.subject.title, .subject.url] | @csv' -r | tr -d '"' 
