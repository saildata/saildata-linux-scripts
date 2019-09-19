#!/usr/bin/bash

# Provides cleaned data from Google Classroom takeout (json)
# Input: classroom json file
# Output: Fullname, Email (PENDING EMAIL ACCEPT ONLY)

jq -r '.invitations[]| "\(.profile.name.fullName) \(.profile.emailAddress)"' "$1" | sort | uniq
