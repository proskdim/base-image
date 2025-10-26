#!/usr/bin/env janet

(use spork/path)
(use sh)

(def codex-path "../")
(def validations-path-json (join codex-path "validations/spec.json"))

(defn file-exists? [path]
  (not (nil? (os/stat path))))

(defn validate-spec
    [name]
    (if (file-exists? name)
        (unless ($? ajv -s, validations-path-json -d, name)
            (os/exit 1))
        (do
            (error (string "file with name " name " not exist"))
            ((os/exit 1)))))

(defn main
  [& args]
  (validate-spec "spec.yml"))
