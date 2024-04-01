#!/bin/sh
echo "Starting, checking data directory"

if [ -z "$INPUT_DATA_DIRECTORY" ]; then
  echo "Environment variable DATA_DIRECTORY is not set. Quitting."
  exit 1
fi

if [ ! -d "$INPUT_DATA_DIRECTORY" ]; then
  echo "${INPUT_DATA_DIRECTORY} path not found. Quitting."
  exit 1
fi

echo "data directory found, selecting rule set"

# Define the command prefix
command_prefix="cfn-guard validate --data ${INPUT_DATA_DIRECTORY} --show-summary ${INPUT_SHOW_SUMMARY} --output-format ${INPUT_OUTPUT_FORMAT}"

# Check if the INPUT_RULE_SET is set
if [ -z "$INPUT_RULE_SET" ]; then
  echo "Environment variable RULE_SET is not set. Quitting."
  exit 1
fi

# Construct the full command based on the rule set
full_command="${command_prefix} --rules /${INPUT_RULE_SET}.guard"

echo "Running: ${full_command}"
sh -c "${full_command}"
