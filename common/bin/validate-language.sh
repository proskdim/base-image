#!/bin/bash

find . -mindepth 1 -maxdepth 1 -name 'description.*.yml' -print0 | while IFS= read -r -d '' file; do
  ajv -s /opt/basics/common/language.json -d $file || exit 1
done
