# make a file from IPS with grep Rhodops | cut -f 1 > list_rhodo_ips.txt
zgrep "rhodops" envision.all_clustered_plus_debris.refseq_protein.reads2ips.no_1.tsv.gz > rhodo_by_name_prov.tsv

# put the header on prov.tsv
echo -e "sequences\tIPR" | cat - rhodo_by_name_prov.tsv > rhodo_by_name.tsv
rm rhodo_by_name_prov.tsv

# make a list from rhodo_by_name
rhodo_by_name.tsv cut -f1 > list_rhodo_by_name_sequences.txt

# make a file from uc99 with grep -P to have the samples that I am interest in and call it sample_read_proj_3.txt
zgrep -P "ENV[1-3]_D[0-10]_M" uc099_debris.pe_global.idxstats.tsv.gz  > sample_read_proj_3_prov.tsv

# make a cicle for with list_rhodo_by_name_sequences.txt > sample_sequences_rhodo_by_name_prov.tsv
for string in $(cat list_rhodo_by_name_sequences.txt);
do grep $string sample_read_prj_3.tsv;
done > sample_sequences_rhodo_by_name_prov.txt;

# put the header on prov.tsv and peel unecessary names
echo -e "sample\tsequence\tseqlen\tn_mapped\tn_unmapped" | cat - sample_sequences_rhodo_by_name_prov.tsv > ENV_D_M_samples_sequences_prov.tsv
sed 's/ca.pesickle.pe-erne-filter.moranrna.pe.bowtie2//g' ENV_D_M_samples_sequences_prov.tsv > ENV_D_M_samples_sequences.tsv
rm sample_read_proj_3_prov.tsv sample_sequences_rhodo_by_name_prov.txt ENV_D_M_samples_sequences_prov.tsv

# make a cicle for with list_rhodo_by_name_sequences.txt  and combine with envision_tax >  sample_rhodo_taxa_id_prov.txt
for lines in $(cat list_rhodo_by_name_sequences.txt);
do zgrep $lines envision.all_clustered_plus_debris.refseq_protein.reads2taxonids.no_1.tsv.gz;
done > taxon_reads_rhodo_prov.tsv

# put the header on prov.tsv
echo -e "sample\ttaxonid" | cat - taxon_reads_rhodo_prov.tsv > taxon_reads_rhodo.tsv
rm  taxon_reads_rhodo_prov.tsv

# follow Rscript combine_table.R

