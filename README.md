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

#Shuffled_RNase_PlusP.BAM
#Shuffled_RNase_MinusP.BAM

###### Make Shuffled Genome Coverage Files with Bedtools
## Input
#Shuffled_RNase_PlusP.BAM
#Shuffled_RNase_MinusP.BAM

## Run bedtools Coverage

## Output
#chr*Shuffled_RNase_PlusP.plus.coverage.txt
#chr*Shuffled_RNase_PlusP.minus.coverage.txt
#chr*Shuffled_RNase_MinusP.plus.coverage.txt
#chr*Shuffled_RNase_MinusP.minus.coverage.txt

###### Make shuffled CSAR files
mkdir ~./CSAR/shuffled

## Input
#chr*Shuffled_RNase_PlusP.plus.coverage.txt
#chr*Shuffled_RNase_PlusP.minus.coverage.txt
#chr*Shuffled_RNase_MinusP.plus.coverage.txt
#chr*Shuffled_RNase_MinusP.minus.coverage.txt

###### Execution
make_CSAR_files.R ~./CSAR/shuffled/ Shuffled_RNase_PlusP.plus Forward
make_CSAR_files.R ~./CSAR/shuffled/ Shuffled_RNase_PlusP.minus Reverse

make_CSAR_files.R ~./CSAR/shuffled/ Shuffled_RNase_minusP.plus Forward
make_CSAR_files.R ~./CSAR/shuffled/ Shuffled_RNase_minusP.minus Reverse

## Output

#chr*Shuffled_RNase_PlusP.plus.CSARScore
#chr*Shuffled_RNase_PlusP.minus.CSARScore
#chr*Shuffled_RNase_MinusP.plus.CSARScore
#chr*Shuffled_RNase_MinusP.minus.CSARScore

#### Calculate FDR (5%) Threshold

## Input

#chr*Shuffled_RNase_PlusP.plus.CSARScore
#chr*Shuffled_RNase_PlusP.minus.CSARScore
#chr*Shuffled_RNase_MinusP.plus.CSARScore
#chr*Shuffled_RNase_MinusP.minus.CSARScore

## Execution
/Data03/ians/scripts/run_CSAR_shuffled.R ~./CSAR/shuffled/Shuffled_RNase chr_len.txt ~./CSAR/shuffled/Shuffled_RNase.CSAR_PPS.bed ~./CSAR/shuffled/Shuffled_RNase.CSAR_PPS.threshold.txt 

## Output
#~./CSAR/shuffled/Shuffled_RNase.CSAR_PPS.bed 
#~./CSAR/shuffled/Shuffled_RNase.CSAR_PPS.threshold.txt



###### RUN CSAR on real files

##Input
#RNase_PlusP.BAM 
#RNase_minusP.BAM

## Exection 
# Run bedtools Coverage

## Output
#chr*RNase_PlusP.plus.coverage.txt
#chr*RNase_PlusP.minus.coverage.txt
#chr*RNase_MinusP.plus.coverage.txt
#chr*RNase_MinusP.minus.coverage.txt

############### Make CSAR files

mkdir ~./CSAR/run

##Input

#chr*RNase_PlusP.plus.coverage.txt
#chr*RNase_PlusP.minus.coverage.txt
#chr*RNase_MinusP.plus.coverage.txt
#chr*RNase_MinusP.minus.coverage.txt

## Execution
make_CSAR_files.R ~./CSAR/run/ RNase_PlusP.plus Forward
make_CSAR_files.R ~./CSAR/run/ RNase_PlusP.minus Reverse

make_CSAR_files.R ~./CSAR/run/ RNase_minusP.plus Forward
make_CSAR_files.R ~./CSAR/run/ RNase_minusP.minus Reverse

## Output

#chr*Shuffled_RNase_PlusP.plus.CSARScore
#chr*Shuffled_RNase_PlusP.minus.CSARScore
#chr*Shuffled_RNase_MinusP.plus.CSARScore
#chr*Shuffled_RNase_MinusP.minus.CSARScore


###### Run CSAR

## Input
#chr*Shuffled_RNase_PlusP.plus.CSARScore
#chr*Shuffled_RNase_PlusP.minus.CSARScore
#chr*Shuffled_RNase_MinusP.plus.CSARScore
#chr*Shuffled_RNase_MinusP.minus.CSARScore

### Execution
run_CSAR_saturation.R ~./CSAR/run/RNase chr_len.txt  ~./CSAR/shuffled/Shuffled_RNase.CSAR_PPS.threshold.txt  ~./CSAR/run/RNase.CSAR_PPS.bed ~./CSAR/run/RNase.CSAR_PPS.threshold.txt 

### Output
#~./CSAR/run/RNase.CSAR_PPS.bed 
#~./CSAR/run/RNase.CSAR_PPS_FDR05.bed
#~./CSAR/run/RNase.CSAR_PPS.threshold.txt


