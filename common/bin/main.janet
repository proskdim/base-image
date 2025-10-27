#!/usr/bin/env janet

(use spork/path)
(use sh)

(def root-path "/opt/codex/common")

(def validations-path (join root-path "validations"))

(defn file-exists? [path]
  (= (os/stat path :mode) :file))

(defn validate-spec
    [yml-file json-file]
    (if (file-exists? yml-file)
        (unless ($? ajv -s, (join validations-path json-file) -d, yml-file)
            (os/exit 1))
        (do
            (error (string "file: " yml-file " not exist"))
            ((os/exit 1)))))

(defn main
  [& args]
  (validate-spec "spec.yml" "spec.json"))
