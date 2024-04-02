#!/bin/sh
echo "Starting, checking data directory"
echo "find -type f -name '*.guard'"
find -type f -name "*.guard"
if [ -z "$INPUT_DATA_DIRECTORY" ]; then
  echo "Environment variable DATA_DIRECTORY is not set. Quitting."
  exit 1
fi

if [ ! -e "$INPUT_DATA_DIRECTORY" ]; then
  echo "${INPUT_DATA_DIRECTORY} not found. Quitting."
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

# Split the comma-separated rule sets
IFS=',' read -ra RULE_SETS <<< "$INPUT_RULE_SET"

# Iterate over each rule set
for rule_set in "${RULE_SETS[@]}"; do
  # Construct the full command based on the rule set
  full_command="${command_prefix} --rules /guard-files/${rule_set}.guard"

  echo "Running: ${full_command}"
  # Execute the command
  sh -c "${full_command}"
done
