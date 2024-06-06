#!/bin/bash

# Найти все файлы data.yml на определенном уровне вложенности
find modules -mindepth 2 -maxdepth 2 -name 'description.*.yml' -print0 | while IFS= read -r -d '' file; do
	ajv -s /opt/basics/common/module.json -d $file || exit 1
done
