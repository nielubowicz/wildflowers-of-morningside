#!/bin/bash

while read plant; do ./wikisearch.sh "$plant"; done < <(cut -f1-2 -d' ' plant-names-only.txt)


