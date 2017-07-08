#!/usr/bin/bash

grep -P "\tgene\t" ../../genome/Rhizopus_stolonifer_B9770.gff3 | grep -v 'tRNA' | perl -p -e 's/ID=\S+;locus_tag=//' | awk 'BEGIN{OFS="\t"} {print $1,$4,$5,$9}'  > Rstol.genes.bed
