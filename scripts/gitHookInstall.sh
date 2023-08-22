#!/bin/bash

GIT_DIR=$(git rev-parse --git-dir)

echo "Installing hooks..."
chmod +x scrips/pre-commit.sh
ln -s -f ../../scripts/pre-commit.sh $GIT_DIR/hooks/pre-commit
echo "Done!" 