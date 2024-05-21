#!/bin/bash

# Usage: ./merge_techniques.sh file1.json file2.json output.json

FILE1=$1
FILE2=$2
OUTPUT=$3

jq -s '
  # Ensure that the techniques arrays exist and are arrays
  .[0] as $a | .[1] as $b |
  {
    techniques: (
      ($a.techniques // []) + ($b.techniques // [])
    ) | unique_by(.techniqueID + .tactic)
  }' "$FILE1" "$FILE2" > "$OUTPUT"

echo "Merged JSON saved to $OUTPUT"
