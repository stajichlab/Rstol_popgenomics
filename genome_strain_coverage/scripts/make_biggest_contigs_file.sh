#!/usr/bin/bash
 wc -l plot/*_norm.tab | sort -nr | head -n 100 | perl -p -e 's/\s+\d+\s+plot\/(jcf\d+)\.\S+/$1/' | grep -v total > biggest_contigs.dat
