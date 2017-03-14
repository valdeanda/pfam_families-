
1) Dowload the secuences from pfam database 

  $ wget "ftp://ftp.ebi.ac.uk/pub/databases/Pfam/current_release/Pfam-A.fasta.gz"
  $ gunzip Pfam-A.fasta.gz
  
  #In this point we are going to use all the pfams? or only the informative ones?
 
 
 less entropies_matrix_entropies.tab  | cut -f 1,2 | awk '$2>=0.3'  | wc > informative.pfams 




  

2) Obtain fasta secuenes from each pfams (pfam_terms.tab)  in separated files 

  $ for pfam in `cat pfam_terms.tab ` ; do grep $pfam --after-context=1 Pfam-A.fasta > $pfam.fasta ; done 

3) Check if the number of sequences corresponde to the numer of sequences for each model, (check number_seq.txt file)  

  $ grep -c ">" *.fasta 
  
    
PF00374.fasta:3045
PF01058.fasta:2941
PF01568.fasta:8859
PF01747.fasta:906
PF02635.fasta:3268
PF02662.fasta:794
PF02665.fasta:1025
PF03916.fasta:1597
PF04358.fasta:752
PF04879.fasta:5399
PF08770.fasta:661
PF09242.fasta:325
PF09459.fasta:311
PF10418.fasta:1903
PF12139.fasta:130
PF12800.fasta:1181
PF13247.fasta:3373
PF13501.fasta:671
PF14306.fasta:1382
PF14697.fasta:2096
PF17179.fasta:485

4) From the header of each sequence, obtain the list of UNIPROT identifiers in order to obtain the corresponding species for each
protein sequence

 $for fasta in *; do grep  ">" $fasta | sed 's/ /\t/g' | sed 's/>//g' | sed 's/\//\t/g' | cut -f 1  > $fasta.uniprot.txt ; done

5) Fore each gene family (fasta.uniprot.tx) we have a header of the uniprot identifiers, with the latter, obtain a fasta file with the corresponding 
specie in the header.  Check the script get_sps_uniprot, and change the fasta path

$ nohup for file in *.txt ; do get_sps_uniprot.sh $file ; done &  

DONE!




easy way ..for consulsts of less than 100 uniprot headers (not our case) 


 $ for i in *.txt; do mkdir $i.names && mv $i $i.names ; done 

Execute every time in the folder (not recomended for more thant 1000 request!! not useful! 
for uni in `cat PF14306.fasta.uniprot.txt.names/PF14306.fasta.uniprot.txt `; do  perl -MSOAP::Lite -e '$soap=SOAP::Lite->service("http://www.ebi.ac.uk/Tools/webservices/wsdl/WSDbfetch.wsdl");print $soap->fetchData("uniprot:'$uni'","fasta","raw")'>> PF14306.fasta.uniprot.txt ; done
