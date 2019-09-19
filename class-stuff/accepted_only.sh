#!/usr/bin/bash

# Provides cleaned data from Google Classroom takeout (json)
# Input: classroom json file
# Output: Fullname, Email (ACCEPTED INVITATION ONLY)

jq -r '.students[]| "\(.profile.name.fullName) \(.profile.emailAddress)"' "$1" | sort | uniq
