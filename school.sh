#!/bin/bash

BASE_PATH="/home/kaj/school"

get_all() {
	if [[ -z "$1" ]]; then
		exit
	fi

	path="$1"
	echo "null"

	for target in "$path"/*; do
    	if [[ ! -d "$target" ]] || [[ -h "$target" ]]; then
			continue
		fi
		
		echo "$(basename "$target")"
   	done
}

set_current() {
	if [[ -z "$1" ]] || [[ -z "$2" ]] || [[ -z "$3" ]]; then
		exit
	fi

	path="$1"
	target_path="$2"
	choice="$3"

	if [[ "$choice" == "null" ]]; then
		if [[ -e "$target_path" ]]; then
			rm -r "$target_path"
		fi

		exit
	fi

	for target in "$path"/*; do
		if [[ "$target" != "$path/$choice" ]]; then
			continue
		fi

		if [[ -e "$target_path" ]]; then
			rm -r "$target_path"
		fi

		ln -s "$target" "$target_path"
	done
}

courses() {
	if [[ -z $1 ]]; then
		get_all "$BASE_PATH/semester"
		exit
	fi

	choice="$1"
	set_current "$BASE_PATH/semester" "$BASE_PATH/course" "$choice"
}

semesters() {
	if [[ -z $1 ]]; then
		get_all "$BASE_PATH"
		exit
	fi

	choice="$1"
	set_current "$BASE_PATH" "$BASE_PATH/semester" "$choice"
}

if [[ $# -lt 1 ]]; then
    exit
fi

case "$1" in
	courses) courses "$2" ;;
	semesters) semesters "$2" ;;
esac
