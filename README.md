PIPseq
======

Scripts for running PIP-seq pipeline


###### Shuffle the reads
## Input
#RNase_PlusP.BAM > RNase Footprint
#RNase_MinusP.BAM > RNase Digestion Control

## Execution
perl shuffle_reads_BAM.pl ~./CSAR/RNase_PlusP.BAM ~./CSAR/RNase_MinusP.BAM ~./CSAR/Shuffled_RNase_PlusP.BAM ~./CSAR/Shuffled_RNase_MinusP.BAM

## Output 

#Shuffled_RNase_PlusP.BAM ??
#Shuffled_RNase_MinusP.BAM ??

##### Make Shuffled Genome Coverage Files with Samtools

############### Make shuffled CSAR files
mkdir ~./CSAR/shuffled

make_CSAR_files.R ~./CSAR/shuffled/ Shuffled_RNase_PlusP.plus Forward
make_CSAR_files.R ~./CSAR/shuffled/ Shuffled_RNase_PlusP.minus Reverse

make_CSAR_files.R ~./CSAR/shuffled/ Shuffled_RNase_minusP.plus Forward
make_CSAR_files.R ~./CSAR/shuffled/ Shuffled_RNase_minusP.minus Reverse


#### Calculate FDR (5%) Threshold

/Data03/ians/scripts/run_CSAR_shuffled.R ~./CSAR/shuffled/Shuffled_RNase chr_len.txt ~./CSAR/shuffled/Shuffled_RNase.CSAR_PPS.bed ~./CSAR/shuffled/Shuffled_RNase.CSAR_PPS.threshold.txt 

############### Make CSAR files
mkdir ~./CSAR/run

make_CSAR_files.R ~./CSAR/run/ RNase_PlusP.plus Forward
make_CSAR_files.R ~./CSAR/run/ RNase_PlusP.minus Reverse

make_CSAR_files.R ~./CSAR/run/ RNase_minusP.plus Forward
make_CSAR_files.R ~./CSAR/run/ RNase_minusP.minus Reverse


run_CSAR_saturation.R ~./CSAR/run/RNase chr_len.txt  ~./CSAR/shuffled/Shuffled_RNase.CSAR_PPS.threshold.txt  ~./CSAR/run/RNase.CSAR_PPS.bed ~./CSAR/run/RNase.CSAR_PPS.threshold.txt 

/Data03/ians/data/HEK293T_pipseq/CSAR/shuffled/shuffled_HEK293T_rep1/shuffled_HEK293T_Form_DSase.CSAR_PPS.threshold.txt /Data03/ians/data/HEK293T_pipseq/CSAR/HEK293T_rep1/HEK293T_Form_DSase.CSAR_PPS.bed /Data03/ians/data/HEK293T_pipseq/CSAR/HEK293T_rep1/HEK293T_Form_DSase.CSAR_PPS.threshold.txt 

