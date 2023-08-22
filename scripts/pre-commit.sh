#!/bin/bash

LOG_FILE="pre-commit.log"
rm -f "${LOG_FILE}"

printf "This is a pre commit script \n" >> "$LOG_FILE"

hasChanges=$(git diff) 

if [ -n "$hasChanges" ]; then
  printf "The code has some changes in it \n So I will now stash the unstaged changes" >> "$LOG_FILE"
  git stash push --keep-index >> "$LOG_FILE"
fi

printf "I am going to format all your files with prettier spec" >> "$LOG_FILE"

flutter format

hasMadeSomeFormattingChange=$(git diff)

if [ -n "$hasMadeSomeFormattingChange" ]; then
  printf "There are some formatting changes in your code \n Please add them manually" >> "$LOG_FILE"
  exit 1
fi

if [ -n "$hasChanges" ]; then
  printf "Applying stashed changes back to your directory" >> "$LOG_FILE"
  git stash pop
fi





