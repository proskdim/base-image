#!/bin/bash

find . -mindepth 1 -maxdepth 1 -name 'spec.yml' -print0 | while IFS= read -r -d '' file; do
  ajv -s /opt/basics/common/spec.json -d "$file" || exit 1
done
