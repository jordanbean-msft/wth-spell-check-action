#!/bin/bash -l

echo "Starting..."
echo "Setup languages and spelling tool..."
#$1 is the config file, $2 is the path to the markdown files, $3 is the space separated list of files that have changed and need to be checked
configFile="$1"; shift
pathToMarkdownFiles="$1"; shift
changedFiles=("$@")

echo "Config file: $configFile"
echo "Path to markdown files: $pathToMarkdownFiles"
echo "Changed files: ${changedFiles[@]}"

python /generate-spellcheck.py "$configFile" "$pathToMarkdownFiles" "${changedFiles[@]}"

# convert from JSON to YAML
yq -P "$configFile".tmp > "$configFile"

rm -rf /var/lib/apt/lists/*

echo "Using PySpelling according to configuration from $configFile"

pyspelling --config "$configFile"

EXITCODE=$?

test $EXITCODE -gt 1 && echo "\033[91Spelling check action failed, please check diagnostics\033[39m";

test $EXITCODE -eq 1 && echo "\033[91mFiles in repository contain spelling errors\033[39m";

exit $EXITCODE