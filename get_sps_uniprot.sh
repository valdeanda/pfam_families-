#!/bin/bash
filename="$1"
while read line
do
uniprot="$line"
#echo "reading :$line"
grep $line --after-context=1  /path/to/uniprot_trembl.fasta  >> $filename.names.fa
done <"$filename"

#http://www.ebi.ac.uk/uniprot/database/download.html

wget "ftp://ftp.ebi.ac.uk/pub/databases/uniprot/knowledgebase/uniprot_trembl.fasta.gz"



