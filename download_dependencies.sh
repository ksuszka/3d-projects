#!/bin/sh

function process_folder() {
	function process_grep_results() {
		while IFS=: read -r filename dependency_tag dependency_url; do
			pwd
			directory="$(dirname "$filename")/.dependencies"
			echo Downloading $dependency_url to folder $directory...
			mkdir -p $directory
			(cd $directory && curl -L -O "$dependency_url")
		done
	}
	find . -type f -iname "*.scad" -exec grep -Hi '//dependency:' {} + | process_grep_results
}

process_folder
