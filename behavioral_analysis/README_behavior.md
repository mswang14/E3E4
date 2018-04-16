#generate_workable_datasets.m
  puts raw data into datasets that are workable for analysis
  includes run number, sex, genotype, age for comparative work done in the following scripts

#MWM_analysis.m
  analyzes morris water maze data for swim time, swim distance, target swim time, target swim distance
  generates summary statistics (mean and standard deviation)
  does ANOVA testing as well as individual group comparison testing
  creates boxplots of the data split into 4 groups: C57 young, C57 old, APOE3, and APOE4

#NOR_handmeasured_analysis.m
  analyzes handmeasures novel object recognition test data for location preference and recognition index
  generates summary statistics (mean and standard deviation)
  does ANOVA testing as well as individual group comparison testing
  creates boxplots of the data split into 4 groups: C57 young, C57 old, APOE3, and APOE4
  
#connectomic_correlation_calculation.m
  does correlations between connectomic data and behavioral data
  Spearman type correlations
  does regressions for correlations that survive Benjamini-Hochberg test for false discovery rate
  creates boxplots for each network property of all regions of interest
  
#invivo_correlation_calculation.m
  does correlations between in vivo imaging data and behavioral data
  Spearman type correlations
  does regressions for correlations that survive Benjamini-Hochberg test for false discovery rate
  
#MASTER16January2018.xlsx
  excel file that contains all of the animal information as well as all of the raw behavioral data

corresponding_runnos.xlsx
  excel file that contains all of the animal ID's and each animal's corresponding run numbers for imaging

corresponding_runnos_boxplots.xlsx
  excel file that contains all of the corresponding animal ID's, genotypes, and run numbers
