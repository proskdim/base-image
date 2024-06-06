#!/bin/bash

find modules -mindepth 4 -maxdepth 4 -name 'data.yml' -print0 | while IFS= read -r -d '' file; do
	ajv -s /opt/basics/common/lesson.json -d $file || exit 1
done
