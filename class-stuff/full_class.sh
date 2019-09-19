#!/usr/bin/bash

# Provides cleaned data from Google Classroom takeout (json)
# Input: classroom json file
# Output: Fullname, Email

# TODO: Add @csv stuff.. for now just xclip copy/paste into spreadsheet and data to columns

jq -r '.students[], .invitations[]| "\(.profile.name.fullName) \(.profile.emailAddress)"' "$1" | sort | uniq
