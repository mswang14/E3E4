%% import raw behavioral data
% import all MWM data
timetbl = readtable('analyzed_data/MWM_swimtime_behav4paper.csv');
disttbl = readtable('analyzed_data/MWM_swimdist_behav4paper.csv');
memtimetbl = readtable('analyzed_data/MWM_swimtime_memoryidx.csv');
memdisttbl = readtable('analyzed_data/MWM_swimdist_memoryidx.csv');


%% prep for statistical analyses
% create new table with all of the time data and 4 group differences
[timetblV,timetblH] = size(timetbl);
% create group difference array
categorization = strings(timetblV,1);
categorization(strcmp(timetbl.genotype, 'C57') & strcmp(timetbl.age, 'older')) = 'C57old';
categorization(strcmp(timetbl.genotype, 'C57') & strcmp(timetbl.age, 'younger')) = 'C57young';
categorization(strcmp(timetbl.genotype, 'APOE3')) = 'APOE3';
categorization(strcmp(timetbl.genotype, 'APOE4')) = 'APOE4';
% replace NaN with 0
timeVals = table2array(timetbl(:,5:end));
timeVals(isnan(timeVals)) = 0;
% put categorizations and data into table
timeCategorized = [array2table(categorization,'VariableNames',{'group'}) table(timetbl.sex,'VariableNames',{'sex'}) array2table(timeVals,'VariableNames',{'T1','T2','T3','T4','T5','T1target','T2target','T3target','T4target','T5target','T6target','T7target'})];


% create new table with all of the distance data and 4 group differences
[disttblV,disttblH] = size(disttbl);
% create group difference array
categorization = strings(disttblV,1);
categorization(strcmp(disttbl.genotype, 'C57') & strcmp(disttbl.age, 'older')) = 'C57old';
categorization(strcmp(disttbl.genotype, 'C57') & strcmp(disttbl.age, 'younger')) = 'C57young';
categorization(strcmp(disttbl.genotype, 'APOE3')) = 'APOE3';
categorization(strcmp(disttbl.genotype, 'APOE4')) = 'APOE4';
% replace NaN with 0
distVals = table2array(disttbl(:,5:end));
distVals(isnan(distVals)) = 0;
% put categorizations and data into table
distCategorized = [array2table(categorization,'VariableNames',{'group'}) table(disttbl.sex,'VariableNames',{'sex'}) array2table(distVals,'VariableNames',{'T1','T2','T3','T4','T5','T1target','T2target','T3target','T4target','T5target','T6target','T7target'})];

% create new table with all of the calculated LTM time data and 4 group differences
[memtimetblV,memtimetblH] = size(memtimetbl);
% create group difference array
categorization = strings(memtimetblV,1);
categorization(strcmp(memtimetbl.genotype, 'C57') & strcmp(memtimetbl.age, 'older')) = 'C57old';
categorization(strcmp(memtimetbl.genotype, 'C57') & strcmp(memtimetbl.age, 'younger')) = 'C57young';
categorization(strcmp(memtimetbl.genotype, 'APOE3')) = 'APOE3';
categorization(strcmp(memtimetbl.genotype, 'APOE4')) = 'APOE4';
% replace NaN with 0
memtimeVals = table2array(memtimetbl(:,5:end));
memtimeVals(isnan(memtimeVals)) = 0;
% calculate values
memidx1 = memtimeVals(:,2) - memtimeVals(:,3);
memidx2 = memtimeVals(:,4) - memtimeVals(:,5);
memidx3 = memtimeVals(:,6) - memtimeVals(:,7);
memidx4 = memtimeVals(:,8) - memtimeVals(:,9);

memtimeVals = [memidx1 memidx2 memidx3 memidx4];
% put categorizations and data into table
memtimeCategorized = [array2table(categorization,'VariableNames',{'group'}) table(memtimetbl.sex,'VariableNames',{'sex'}) array2table(memtimeVals,'VariableNames',{'memidx1','memidx2','memidx3','memidx4'})];

% create new table with all of the calculated LTM distance data and 4 group differences
[memdisttblV,memdisttblH] = size(memdisttbl);
% create group difference array
categorization = strings(memdisttblV,1);
categorization(strcmp(memdisttbl.genotype, 'C57') & strcmp(memdisttbl.age, 'older')) = 'C57old';
categorization(strcmp(memdisttbl.genotype, 'C57') & strcmp(memdisttbl.age, 'younger')) = 'C57young';
categorization(strcmp(memdisttbl.genotype, 'APOE3')) = 'APOE3';
categorization(strcmp(memdisttbl.genotype, 'APOE4')) = 'APOE4';
% replace NaN with 0
memdistVals = table2array(memdisttbl(:,5:end));
memdistVals(isnan(memdistVals)) = 0;
% calculate values
memidx1 = memdistVals(:,2) - memdistVals(:,3);
memidx2 = memdistVals(:,4) - memdistVals(:,5);
memidx3 = memdistVals(:,6) - memdistVals(:,7);
memidx4 = memdistVals(:,8) - memdistVals(:,9);

memdistVals = [memidx1 memidx2 memidx3 memidx4];
% put categorizations and data into table
memdistCategorized = [array2table(categorization,'VariableNames',{'group'}) table(memdisttbl.sex,'VariableNames',{'sex'}) array2table(memdistVals,'VariableNames',{'memidx1','memidx2','memidx3','memidx4'})];

%% summary statistics
% swim time
meantimeyoungC57M = nanmean(timeCategorized{strcmp(timeCategorized.group, 'C57young')&strcmp(timeCategorized.sex, 'M'),3:7})
stdtimeyoungC57M = nanstd(timeCategorized{strcmp(timeCategorized.group, 'C57young')&strcmp(timeCategorized.sex, 'M'),3:7})
meantimeyoungC57F = nanmean(timeCategorized{strcmp(timeCategorized.group, 'C57young')&strcmp(timeCategorized.sex, 'F'),3:7})
stdtimeyoungC57F = nanstd(timeCategorized{strcmp(timeCategorized.group, 'C57young')&strcmp(timeCategorized.sex, 'F'),3:7})

meantimeoldC57M = nanmean(timeCategorized{strcmp(timeCategorized.group, 'C57old')&strcmp(timeCategorized.sex, 'M'),3:7})
stdtimeoldC57M = nanstd(timeCategorized{strcmp(timeCategorized.group, 'C57old')&strcmp(timeCategorized.sex, 'M'),3:7})
meantimeoldC57F = nanmean(timeCategorized{strcmp(timeCategorized.group, 'C57old')&strcmp(timeCategorized.sex, 'F'),3:7})
stdtimeoldC57F = nanstd(timeCategorized{strcmp(timeCategorized.group, 'C57old')&strcmp(timeCategorized.sex, 'F'),3:7})

meantimeAPOE3M = nanmean(timeCategorized{strcmp(timeCategorized.group, 'APOE3')&strcmp(timeCategorized.sex, 'M'),3:7})
stdtimeAPOE3M = nanstd(timeCategorized{strcmp(timeCategorized.group, 'APOE3')&strcmp(timeCategorized.sex, 'M'),3:7})
meantimeAPOE3F = nanmean(timeCategorized{strcmp(timeCategorized.group, 'APOE3')&strcmp(timeCategorized.sex, 'F'),3:7})
stdtimeAPOE3F = nanstd(timeCategorized{strcmp(timeCategorized.group, 'APOE3')&strcmp(timeCategorized.sex, 'F'),3:7})

meantimeAPOE4M = nanmean(timeCategorized{strcmp(timeCategorized.group, 'APOE4')&strcmp(timeCategorized.sex, 'M'),3:7})
stdtimeAPOE4M = nanstd(timeCategorized{strcmp(timeCategorized.group, 'APOE4')&strcmp(timeCategorized.sex, 'M'),3:7})
meantimeAPOE4F = nanmean(timeCategorized{strcmp(timeCategorized.group, 'APOE4')&strcmp(timeCategorized.sex, 'F'),3:7})
stdtimeAPOE4F = nanstd(timeCategorized{strcmp(timeCategorized.group, 'APOE4')&strcmp(timeCategorized.sex, 'F'),3:7})

% swim distance
meandistyoungC57M = nanmean(distCategorized{strcmp(distCategorized.group, 'C57young')&strcmp(distCategorized.sex, 'M'),3:7})
stddistyoungC57M = nanstd(distCategorized{strcmp(distCategorized.group, 'C57young')&strcmp(distCategorized.sex, 'M'),3:7})
meandistyoungC57F = nanmean(distCategorized{strcmp(distCategorized.group, 'C57young')&strcmp(distCategorized.sex, 'F'),3:7})
stddistyoungC57F = nanstd(distCategorized{strcmp(distCategorized.group, 'C57young')&strcmp(distCategorized.sex, 'F'),3:7})

meandistoldC57M = nanmean(distCategorized{strcmp(distCategorized.group, 'C57old')&strcmp(distCategorized.sex, 'M'),3:7})
stddistoldC57M = nanstd(distCategorized{strcmp(distCategorized.group, 'C57old')&strcmp(distCategorized.sex, 'M'),3:7})
meandistoldC57F = nanmean(distCategorized{strcmp(distCategorized.group, 'C57old')&strcmp(distCategorized.sex, 'F'),3:7})
stddistoldC57F = nanstd(distCategorized{strcmp(distCategorized.group, 'C57old')&strcmp(distCategorized.sex, 'F'),3:7})

meandistAPOE3M = nanmean(distCategorized{strcmp(distCategorized.group, 'APOE3')&strcmp(distCategorized.sex, 'M'),3:7})
stddistAPOE3M = nanstd(distCategorized{strcmp(distCategorized.group, 'APOE3')&strcmp(distCategorized.sex, 'M'),3:7})
meandistAPOE3F = nanmean(distCategorized{strcmp(distCategorized.group, 'APOE3')&strcmp(distCategorized.sex, 'F'),3:7})
stddistAPOE3F = nanstd(distCategorized{strcmp(distCategorized.group, 'APOE3')&strcmp(distCategorized.sex, 'F'),3:7})

meandistAPOE4M = nanmean(distCategorized{strcmp(distCategorized.group, 'APOE4')&strcmp(distCategorized.sex, 'M'),3:7})
stddistAPOE4M = nanstd(distCategorized{strcmp(distCategorized.group, 'APOE4')&strcmp(distCategorized.sex, 'M'),3:7})
meandistAPOE4F = nanmean(distCategorized{strcmp(distCategorized.group, 'APOE4')&strcmp(distCategorized.sex, 'F'),3:7})
stddistAPOE4F = nanstd(distCategorized{strcmp(distCategorized.group, 'APOE4')&strcmp(distCategorized.sex, 'F'),3:7})

% target swim time
meantargettimeyoungC57M = nanmean(timeCategorized{strcmp(timeCategorized.group, 'C57young')&strcmp(timeCategorized.sex, 'M'),8:end})
stdtargettimeyoungC57M = nanstd(timeCategorized{strcmp(timeCategorized.group, 'C57young')&strcmp(timeCategorized.sex, 'M'),8:end})
meantargettimeyoungC57F = nanmean(timeCategorized{strcmp(timeCategorized.group, 'C57young')&strcmp(timeCategorized.sex, 'F'),8:end})
stdtargettimeyoungC57F = nanstd(timeCategorized{strcmp(timeCategorized.group, 'C57young')&strcmp(timeCategorized.sex, 'F'),8:end})

meantargettimeoldC57M = nanmean(timeCategorized{strcmp(timeCategorized.group, 'C57old')&strcmp(timeCategorized.sex, 'M'),8:end})
stdtargettimeoldC57M = nanstd(timeCategorized{strcmp(timeCategorized.group, 'C57old')&strcmp(timeCategorized.sex, 'M'),8:end})
meantargettimeoldC57F = nanmean(timeCategorized{strcmp(timeCategorized.group, 'C57old')&strcmp(timeCategorized.sex, 'F'),8:end})
stdtargettimeoldC57F = nanstd(timeCategorized{strcmp(timeCategorized.group, 'C57old')&strcmp(timeCategorized.sex, 'F'),8:end})

meantargettimeAPOE3M = nanmean(timeCategorized{strcmp(timeCategorized.group, 'APOE3')&strcmp(timeCategorized.sex, 'M'),8:end})
stdtargettimeAPOE3M = nanstd(timeCategorized{strcmp(timeCategorized.group, 'APOE3')&strcmp(timeCategorized.sex, 'M'),8:end})
meantargettimeAPOE3F = nanmean(timeCategorized{strcmp(timeCategorized.group, 'APOE3')&strcmp(timeCategorized.sex, 'F'),8:end})
stdtargettimeAPOE3F = nanstd(timeCategorized{strcmp(timeCategorized.group, 'APOE3')&strcmp(timeCategorized.sex, 'F'),8:end})

meantargettimeAPOE4M = nanmean(timeCategorized{strcmp(timeCategorized.group, 'APOE4')&strcmp(timeCategorized.sex, 'M'),8:end})
stdtargettimeAPOE4M = nanstd(timeCategorized{strcmp(timeCategorized.group, 'APOE4')&strcmp(timeCategorized.sex, 'M'),8:end})
meantargettimeAPOE4F = nanmean(timeCategorized{strcmp(timeCategorized.group, 'APOE4')&strcmp(timeCategorized.sex, 'F'),8:end})
stdtargettimeAPOE4F = nanstd(timeCategorized{strcmp(timeCategorized.group, 'APOE4')&strcmp(timeCategorized.sex, 'F'),8:end})

% targetswim distance
meantargetdistyoungC57M = nanmean(distCategorized{strcmp(distCategorized.group, 'C57young')&strcmp(distCategorized.sex, 'M'),8:end})
stdtargetdistyoungC57M = nanstd(distCategorized{strcmp(distCategorized.group, 'C57young')&strcmp(distCategorized.sex, 'M'),8:end})
meantargetdistyoungC57F = nanmean(distCategorized{strcmp(distCategorized.group, 'C57young')&strcmp(distCategorized.sex, 'F'),8:end})
stdtargetdistyoungC57F = nanstd(distCategorized{strcmp(distCategorized.group, 'C57young')&strcmp(distCategorized.sex, 'F'),8:end})

meantargetdistoldC57M = nanmean(distCategorized{strcmp(distCategorized.group, 'C57old')&strcmp(distCategorized.sex, 'M'),8:end})
stdtargetdistoldC57M = nanstd(distCategorized{strcmp(distCategorized.group, 'C57old')&strcmp(distCategorized.sex, 'M'),8:end})
meantargetdistoldC57F = nanmean(distCategorized{strcmp(distCategorized.group, 'C57old')&strcmp(distCategorized.sex, 'F'),8:end})
stdtargetdistoldC57F = nanstd(distCategorized{strcmp(distCategorized.group, 'C57old')&strcmp(distCategorized.sex, 'F'),8:end})

meantargetdistAPOE3M = nanmean(distCategorized{strcmp(distCategorized.group, 'APOE3')&strcmp(distCategorized.sex, 'M'),8:end})
stdtargetdistAPOE3M = nanstd(distCategorized{strcmp(distCategorized.group, 'APOE3')&strcmp(distCategorized.sex, 'M'),8:end})
meantargetdistAPOE3F = nanmean(distCategorized{strcmp(distCategorized.group, 'APOE3')&strcmp(distCategorized.sex, 'F'),8:end})
stdtargetdistAPOE3F = nanstd(distCategorized{strcmp(distCategorized.group, 'APOE3')&strcmp(distCategorized.sex, 'F'),8:end})

meantargetdistAPOE4M = nanmean(distCategorized{strcmp(distCategorized.group, 'APOE4')&strcmp(distCategorized.sex, 'M'),8:end})
stdtargetdistAPOE4M = nanstd(distCategorized{strcmp(distCategorized.group, 'APOE4')&strcmp(distCategorized.sex, 'M'),8:end})
meantargetdistAPOE4F = nanmean(distCategorized{strcmp(distCategorized.group, 'APOE4')&strcmp(distCategorized.sex, 'F'),8:end})
stdtargetdistAPOE4F = nanstd(distCategorized{strcmp(distCategorized.group, 'APOE4')&strcmp(distCategorized.sex, 'F'),8:end})

% swim time memory index
meanmemtimeyoungC57M = nanmean(memtimeCategorized{strcmp(memtimeCategorized.group, 'C57young')&strcmp(memtimeCategorized.sex, 'M'),3:end})
stdmemtimeyoungC57M = nanstd(memtimeCategorized{strcmp(memtimeCategorized.group, 'C57young')&strcmp(memtimeCategorized.sex, 'M'),3:end})
meanmemtimeyoungC57F = nanmean(memtimeCategorized{strcmp(memtimeCategorized.group, 'C57young')&strcmp(memtimeCategorized.sex, 'F'),3:end})
stdmemtimeyoungC57F = nanstd(memtimeCategorized{strcmp(memtimeCategorized.group, 'C57young')&strcmp(memtimeCategorized.sex, 'F'),3:end})

meanmemtimeoldC57M = nanmean(memtimeCategorized{strcmp(memtimeCategorized.group, 'C57old')&strcmp(memtimeCategorized.sex, 'M'),3:end})
stdmemtimeoldC57M = nanstd(memtimeCategorized{strcmp(memtimeCategorized.group, 'C57old')&strcmp(memtimeCategorized.sex, 'M'),3:end})
meanmemtimeoldC57F = nanmean(memtimeCategorized{strcmp(memtimeCategorized.group, 'C57old')&strcmp(memtimeCategorized.sex, 'F'),3:end})
stdmemtimeoldC57F = nanstd(memtimeCategorized{strcmp(memtimeCategorized.group, 'C57old')&strcmp(memtimeCategorized.sex, 'F'),3:end})

meanmemtimeAPOE3M = nanmean(memtimeCategorized{strcmp(memtimeCategorized.group, 'APOE3')&strcmp(memtimeCategorized.sex, 'M'),3:end})
stdmemtimeAPOE3M = nanstd(memtimeCategorized{strcmp(memtimeCategorized.group, 'APOE3')&strcmp(memtimeCategorized.sex, 'M'),3:end})
meanmemtimeAPOE3F = nanmean(memtimeCategorized{strcmp(memtimeCategorized.group, 'APOE3')&strcmp(memtimeCategorized.sex, 'F'),3:end})
stdmemtimeAPOE3F = nanstd(memtimeCategorized{strcmp(memtimeCategorized.group, 'APOE3')&strcmp(memtimeCategorized.sex, 'F'),3:end})

meanmemtimeAPOE4M = nanmean(memtimeCategorized{strcmp(memtimeCategorized.group, 'APOE4')&strcmp(memtimeCategorized.sex, 'M'),3:end})
stdmemtimeAPOE4M = nanstd(memtimeCategorized{strcmp(memtimeCategorized.group, 'APOE4')&strcmp(memtimeCategorized.sex, 'M'),3:end})
meanmemtimeAPOE4F = nanmean(memtimeCategorized{strcmp(memtimeCategorized.group, 'APOE4')&strcmp(memtimeCategorized.sex, 'F'),3:end})
stdmemtimeAPOE4F = nanstd(memtimeCategorized{strcmp(memtimeCategorized.group, 'APOE4')&strcmp(memtimeCategorized.sex, 'F'),3:end})

% swim dist memory index
meanmemdistyoungC57M = nanmean(memdistCategorized{strcmp(memdistCategorized.group, 'C57young')&strcmp(memdistCategorized.sex, 'M'),3:end})
stdmemdistyoungC57M = nanstd(memdistCategorized{strcmp(memdistCategorized.group, 'C57young')&strcmp(memdistCategorized.sex, 'M'),3:end})
meanmemdistyoungC57F = nanmean(memdistCategorized{strcmp(memdistCategorized.group, 'C57young')&strcmp(memdistCategorized.sex, 'F'),3:end})
stdmemdistyoungC57F = nanstd(memdistCategorized{strcmp(memdistCategorized.group, 'C57young')&strcmp(memdistCategorized.sex, 'F'),3:end})

meanmemdistoldC57M = nanmean(memdistCategorized{strcmp(memdistCategorized.group, 'C57old')&strcmp(memdistCategorized.sex, 'M'),3:end})
stdmemdistoldC57M = nanstd(memdistCategorized{strcmp(memdistCategorized.group, 'C57old')&strcmp(memdistCategorized.sex, 'M'),3:end})
meanmemdistoldC57F = nanmean(memdistCategorized{strcmp(memdistCategorized.group, 'C57old')&strcmp(memdistCategorized.sex, 'F'),3:end})
stdmemdistoldC57F = nanstd(memdistCategorized{strcmp(memdistCategorized.group, 'C57old')&strcmp(memdistCategorized.sex, 'F'),3:end})

meanmemdistAPOE3M = nanmean(memdistCategorized{strcmp(memdistCategorized.group, 'APOE3')&strcmp(memdistCategorized.sex, 'M'),3:end})
stdmemdistAPOE3M = nanstd(memdistCategorized{strcmp(memdistCategorized.group, 'APOE3')&strcmp(memdistCategorized.sex, 'M'),3:end})
meanmemdistAPOE3F = nanmean(memdistCategorized{strcmp(memdistCategorized.group, 'APOE3')&strcmp(memdistCategorized.sex, 'F'),3:end})
stdmemdistAPOE3F = nanstd(memdistCategorized{strcmp(memdistCategorized.group, 'APOE3')&strcmp(memdistCategorized.sex, 'F'),3:end})

meanmemdistAPOE4M = nanmean(memdistCategorized{strcmp(memdistCategorized.group, 'APOE4')&strcmp(memdistCategorized.sex, 'M'),3:end})
stdmemdistAPOE4M = nanstd(memdistCategorized{strcmp(memdistCategorized.group, 'APOE4')&strcmp(memdistCategorized.sex, 'M'),3:end})
meanmemdistAPOE4F = nanmean(memdistCategorized{strcmp(memdistCategorized.group, 'APOE4')&strcmp(memdistCategorized.sex, 'F'),3:end})
stdmemdistAPOE4F = nanstd(memdistCategorized{strcmp(memdistCategorized.group, 'APOE4')&strcmp(memdistCategorized.sex, 'F'),3:end})

%% prep for ANOVA
% for the 8-way comparison
categorization(strcmp(timeCategorized.group, 'C57old') & strcmp(timeCategorized.sex, 'M')) = 'C57oldM';
categorization(strcmp(timeCategorized.group, 'C57old') & strcmp(timeCategorized.sex, 'F')) = 'C57oldF';
categorization(strcmp(timeCategorized.group, 'C57young') & strcmp(timeCategorized.sex, 'M')) = 'C57youngM';
categorization(strcmp(timeCategorized.group, 'C57young') & strcmp(timeCategorized.sex, 'F')) = 'C57youngF';
categorization(strcmp(timeCategorized.group, 'APOE3') & strcmp(timeCategorized.sex, 'M')) = 'APOE3M';
categorization(strcmp(timeCategorized.group, 'APOE3') & strcmp(timeCategorized.sex, 'F')) = 'APOE3F';
categorization(strcmp(timetbl.genotype, 'APOE4') & strcmp(timeCategorized.sex, 'M')) = 'APOE4M';
categorization(strcmp(timetbl.genotype, 'APOE4') & strcmp(timeCategorized.sex, 'F')) = 'APOE4F';

% swimtime
timeC57young = timeCategorized(strcmp(timeCategorized.group, 'C57young'),: );
timeC57old = timeCategorized(strcmp(timeCategorized.group, 'C57old'),: );
timeE3 = timeCategorized(strcmp(timeCategorized.group, 'APOE3'),:);
timeE4 = timeCategorized(strcmp(timeCategorized.group, 'APOE4'),:);

timeC57 = [timeC57old; timeC57young];
timeE3E4 = [timeE3; timeE4];
timeC57E4 = [timeC57old; timeE4];
timeC57E3 = [timeC57old; timeE3];

timeCategorized_sex = [table(categorization, 'VariableNames', {'group'}) timeCategorized(:,3:end)]
timeE3E4_sex = timeCategorized_sex(contains(timeCategorized_sex{:,1}, 'APOE'),:);
timeC57E4_sex = [timeCategorized_sex(contains(timeCategorized_sex{:,1}, 'APOE4'),:); timeCategorized_sex(contains(timeCategorized_sex{:,1}, 'C57old'),:)];

% swimdist
distC57young = distCategorized(strcmp(distCategorized.group, 'C57young'),: );
distC57old = distCategorized(strcmp(distCategorized.group, 'C57old'),: );
distE3 = distCategorized(strcmp(distCategorized.group, 'APOE3'),:);
distE4 = distCategorized(strcmp(distCategorized.group, 'APOE4'),:);

distC57 = [distC57old; distC57young];
distE3E4 = [distE3; distE4];
distC57E4 = [distC57old; distE4];
distC57E3 = [distC57old; distE3];

distCategorized_sex = [table(categorization, 'VariableNames', {'group'}) distCategorized(:,3:end)]
distE3E4_sex = distCategorized_sex(contains(distCategorized_sex{:,1}, 'APOE'),:);
distC57E4_sex = [distCategorized_sex(contains(distCategorized_sex{:,1}, 'APOE4'),:); distCategorized_sex(contains(distCategorized_sex{:,1}, 'C57old'),:)];


%% ANOVA swimtime

time=[1 2 3 4 5]';
time_withprobe=[1 2 3 3.5 4 5 5.5];
time_memidx = [1 2 3 4];

% swimtime
time_rm=fitrm(timeE3E4,'T1-T5 ~ group*sex', 'WithinDesign',time, 'WithinModel','separatemeans');
time_tab=ranova(time_rm);
bl_time = multcompare(time_rm,'group', 'By', 'Time', 'ComparisonType', 'bonferroni');
writetable(time_tab,'behavior_stats/MWMswimtimeE3E4_ANOVA.xlsx','WriteRowNames',true);
writetable(bl_time,'behavior_stats/MWMswimtimeE3E4_posthoc.xlsx');

time_rm=fitrm(timeC57,'T1-T5 ~ group*sex', 'WithinDesign',time, 'WithinModel','separatemeans');
time_tab=ranova(time_rm);
bl_time = multcompare(time_rm,'group', 'By', 'Time', 'ComparisonType', 'bonferroni');
writetable(time_tab,'behavior_stats/MWMswimtimeC57_ANOVA.xlsx','WriteRowNames',true);
writetable(bl_time,'behavior_stats/MWMswimtimeC57_posthoc.xlsx');

time_rm=fitrm(timeC57E3,'T1-T5 ~ group*sex', 'WithinDesign',time, 'WithinModel','separatemeans');
time_tab=ranova(time_rm);
bl_time = multcompare(time_rm,'group', 'By', 'Time', 'ComparisonType', 'bonferroni');
writetable(time_tab,'behavior_stats/MWMswimtimeC57E3_ANOVA.xlsx','WriteRowNames',true);
writetable(bl_time,'behavior_stats/MWMswimtimeC57E3_posthoc.xlsx');

time_rm=fitrm(timeC57E4,'T1-T5 ~ group*sex', 'WithinDesign',time, 'WithinModel','separatemeans');
time_tab=ranova(time_rm);
bl_time = multcompare(time_rm,'group', 'By', 'Time', 'ComparisonType', 'bonferroni');
writetable(time_tab,'behavior_stats/MWMswimtimeC57E4_ANOVA.xlsx','WriteRowNames',true);
writetable(bl_time,'behavior_stats/MWMswimtimeC57E4_posthoc.xlsx');

time_rm=fitrm(timeCategorized_sex,'T1-T5 ~ group', 'WithinDesign',time, 'WithinModel','separatemeans');
time_tab=ranova(time_rm);
bl_time = multcompare(time_rm,'group', 'By', 'Time', 'ComparisonType', 'bonferroni');
writetable(time_tab,'behavior_stats/MWMswimtimeAll_ANOVA.xlsx','WriteRowNames',true);
writetable(bl_time,'behavior_stats/MWMswimtimeAll_posthoc.xlsx');

time_rm=fitrm(timeE3E4_sex,'T1-T5 ~ group', 'WithinDesign',time, 'WithinModel','separatemeans');
time_tab=ranova(time_rm);
bl_time = multcompare(time_rm,'group', 'By', 'Time', 'ComparisonType', 'bonferroni');
writetable(time_tab,'behavior_stats/MWMswimtimeE3E4sex_ANOVA.xlsx','WriteRowNames',true);
writetable(bl_time,'behavior_stats/MWMswimtimeE3E4sex_posthoc.xlsx');

time_rm=fitrm(timeC57E4_sex,'T1-T5 ~ group', 'WithinDesign',time, 'WithinModel','separatemeans');
time_tab=ranova(time_rm);
bl_time = multcompare(time_rm,'group', 'By', 'Time', 'ComparisonType', 'bonferroni');
writetable(time_tab,'behavior_stats/MWMswimtimeC57E4sex_ANOVA.xlsx','WriteRowNames',true);
writetable(bl_time,'behavior_stats/MWMswimtimeC57E4sex_posthoc.xlsx');

% target swimtime
targettime_rm=fitrm(timeE3E4,'T1target-T7target~group*sex', 'WithinDesign',time_withprobe, 'WithinModel','separatemeans');
targettime_tab=ranova(targettime_rm);
bl_targettime = multcompare(targettime_rm,'group', 'By', 'Time', 'ComparisonType', 'bonferroni');
writetable(targettime_tab,'behavior_stats/MWMtargetswimtimeE3E4_ANOVA.xlsx','WriteRowNames',true);
writetable(bl_targettime,'behavior_stats/MWMtargetswimtimeE3E4_posthoc.xlsx');

targettime_rm=fitrm(timeC57,'T1target-T7target~group*sex', 'WithinDesign',time_withprobe, 'WithinModel','separatemeans');
targettime_tab=ranova(targettime_rm);
bl_targettime = multcompare(targettime_rm,'group', 'By', 'Time', 'ComparisonType', 'bonferroni');
writetable(targettime_tab,'behavior_stats/MWMtargetswimtimeC57_ANOVA.xlsx','WriteRowNames',true);
writetable(bl_targettime,'behavior_stats/MWMtargetswimtimeC57_posthoc.xlsx');

targettime_rm=fitrm(timeC57E3,'T1target-T7target~group*sex', 'WithinDesign',time_withprobe, 'WithinModel','separatemeans');
targettime_tab=ranova(targettime_rm);
bl_targettime = multcompare(targettime_rm,'group', 'By', 'Time', 'ComparisonType', 'bonferroni');
writetable(targettime_tab,'behavior_stats/MWMtargetswimtimeC57E3_ANOVA.xlsx','WriteRowNames',true);
writetable(bl_targettime,'behavior_stats/MWMtargetswimtimeC57E3_posthoc.xlsx');

targettime_rm=fitrm(timeC57E4,'T1target-T7target~group*sex', 'WithinDesign',time_withprobe, 'WithinModel','separatemeans');
targettime_tab=ranova(targettime_rm);
bl_targettime = multcompare(targettime_rm,'group', 'By', 'Time', 'ComparisonType', 'bonferroni');
writetable(targettime_tab,'behavior_stats/MWMtargetswimtimeC57E4_ANOVA.xlsx','WriteRowNames',true);
writetable(bl_targettime,'behavior_stats/MWMtargetswimtimeC57E4_posthoc.xlsx');


% swimdist
dist_rm=fitrm(distCategorized,'T1-T5 ~ group', 'WithinDesign',time, 'WithinModel','separatemeans');
dist_tab=ranova(dist_rm);
bl_dist = multcompare(dist_rm,'group', 'By', 'Time', 'ComparisonType', 'bonferroni');

% target swimdist
targetdist_rm=fitrm(distCategorized,'T1target-T7target ~ group', 'WithinDesign',time_withprobe, 'WithinModel','separatemeans')
targetdist_tab=ranova(targetdist_rm)
bl_targetdist = multcompare(targetdist_rm,'group', 'By', 'Time', 'ComparisonType', 'bonferroni')

% memtime
memtime_rm=fitrm(memtimeCategorized,'memidx1-memidx4 ~ group', 'WithinDesign',time_memidx, 'WithinModel','separatemeans')
memtime_tab=ranova(memtime_rm)
bl_memtime = multcompare(memtime_rm,'group', 'By', 'Time', 'ComparisonType', 'bonferroni')

% memdist
memdist_rm=fitrm(memdistCategorized,'memidx1-memidx4 ~ group', 'WithinDesign',time_memidx, 'WithinModel','separatemeans')
memdist_tab=ranova(memdist_rm)
bl_memdist = multcompare(memdist_rm,'group', 'By', 'Time', 'ComparisonType', 'bonferroni')



%% separate out probe trials and calculate percent of time in platform area
% trial 4, 7
probetbl = readtable('analyzed_data/MWM_probetime.csv');

probeC57y = probetbl(20:29, :);
probeC57o = [probetbl(1, :);probetbl(4:5, :);probetbl(13:14, :);probetbl(30:end, :)];
probeE3 = [probetbl(2:3, :);probetbl(12, :);probetbl(15:19, :)];
probeE4 = probetbl(6:11, :);

[h,p,ci,stats] = ttest2(probeE3.T4target,probeE4.T4target)
[h,p,ci,stats] = ttest2(probeE3.T7target,probeE4.T7target)

[h,p,ci,stats] = ttest2(probeC57o.T4target,probeC57y.T4target)
[h,p,ci,stats] = ttest2(probeC57o.T7target,probeC57y.T7target)

%% plots!

% simple line plot for target percentages

trialtargetsAPOE3 = [timetbl(2:3,10:14);timetbl(12,10:14);timetbl(15:19,10:14)];
trialtargetsAPOE4 = timetbl(6:11,10:14);
trialtargetsC57o = [timetbl(1,10:14);timetbl(4:5,10:14);timetbl(13:14,10:14);timetbl(30:end,10:14)];
trialtargetsC57y = timetbl(20:29,10:14);

trialtargetsMeanAPOE3 = mean(table2array(trialtargetsAPOE3));
trialtargetsMeanAPOE4 = mean(table2array(trialtargetsAPOE4));
trialtargetsMeanC57o = mean(table2array(trialtargetsC57o));
trialtargetsMeanC57y = mean(table2array(trialtargetsC57y));

trialtargetsStdAPOE3 = std(table2array(trialtargetsAPOE3));
trialtargetsStdAPOE4 = std(table2array(trialtargetsAPOE4));
trialtargetsStdC57o = std(table2array(trialtargetsC57o));
trialtargetsStdC57y = std(table2array(trialtargetsC57y));

trialNumbers = [1 2 3 5 6];

fignum = 1;
figure(fignum)
fignum = fignum + 1;

hold on

errorbar(trialNumbers, trialtargetsMeanAPOE4,trialtargetsStdAPOE4, 'r')
errorbar(trialNumbers, trialtargetsMeanAPOE3,trialtargetsStdAPOE3, 'g')
errorbar(trialNumbers, trialtargetsMeanC57o,trialtargetsStdC57o, 'b')
errorbar(trialNumbers, trialtargetsMeanC57y,trialtargetsStdC57y, 'k')

hold off
grid on
legend({'APOE4', 'APOE3', 'C57old', 'C57young'});
title('Proportion of Time Spent in Target Quadrant')
xlabel('Trial Number')
ylabel('Percentage')
xlim([0.5 6.5])
set(gca, 'XTick', [1 2 3 5 6])


% simple line plot for probe target percentages
probetargetsAPOE3 = [probetbl(2:3,7:8);probetbl(12,7:8);probetbl(15:19,7:8)];
probetargetsAPOE4 = probetbl(6:11,7:8);
probetargetsC57o = [probetbl(1,7:8);probetbl(4:5,7:8);probetbl(13:14,7:8);probetbl(30:end,7:8)];
probetargetsC57y = probetbl(20:29,7:8);

probetargetsMeanAPOE3 = mean(table2array(probetargetsAPOE3));
probetargetsMeanAPOE4 = mean(table2array(probetargetsAPOE4));
probetargetsMeanC57o = mean(table2array(probetargetsC57o));
probetargetsMeanC57y = mean(table2array(probetargetsC57y));

probetargetsStdAPOE3 = std(table2array(probetargetsAPOE3));
probetargetsStdAPOE4 = std(table2array(probetargetsAPOE4));
probetargetsStdC57o = std(table2array(probetargetsC57o));
probetargetsStdC57y = std(table2array(probetargetsC57y));

probetrialNumbers = [4 7];

figure(fignum)
fignum = fignum + 1;

hold on

errorbar(probetrialNumbers, probetargetsMeanAPOE4,probetargetsStdAPOE4, 'r')
errorbar(probetrialNumbers, probetargetsMeanAPOE3,probetargetsStdAPOE3, 'g')
errorbar(probetrialNumbers, probetargetsMeanC57o,probetargetsStdC57o, 'b')
errorbar(probetrialNumbers, probetargetsMeanC57y,probetargetsStdC57y, 'k')

hold off
grid on
legend({'APOE4', 'APOE3', 'C57old', 'C57young'});
title('Proportion of Time Spent in Platform Zone During Probe Trial')
xlabel('Trial Number')
ylabel('Percentage')
xlim([2.5 7.5])
set(gca, 'XTick', [4 7])

%% everything in one

targetsAPOE3 = [timetbl(2:3,10:end);timetbl(12,10:end);timetbl(15:19,10:end)];
targetsAPOE4 = timetbl(6:11,10:end);
targetsC57o = [timetbl(1,10:end);timetbl(4:5,10:end);timetbl(13:14,10:end);timetbl(30:end,10:end)];
targetsC57y = timetbl(20:29,10:end);

targetsMeanAPOE3 = nanmean(table2array(targetsAPOE3));
targetsMeanAPOE4 = nanmean(table2array(targetsAPOE4));
targetsMeanC57o = nanmean(table2array(targetsC57o));
targetsMeanC57y = nanmean(table2array(targetsC57y));

targetsStdAPOE3 = nanstd(table2array(targetsAPOE3));
targetsStdAPOE4 = nanstd(table2array(targetsAPOE4));
targetsStdC57o = nanstd(table2array(targetsC57o));
targetsStdC57y = nanstd(table2array(targetsC57y));

trialNumbers = [1 2 3 4 5 6 7];

figure(fignum)
fignum = fignum + 1;

hold on

errorbar(trialNumbers, targetsMeanAPOE4,targetsStdAPOE4, 'r')
errorbar(trialNumbers, targetsMeanAPOE3,targetsStdAPOE3, 'g')
errorbar(trialNumbers, targetsMeanC57o,targetsStdC57o, 'b')
errorbar(trialNumbers, targetsMeanC57y,targetsStdC57y, 'k')

hold off
grid on
legend({'APOE4', 'APOE3', 'C57old', 'C57young'});
title('Proportion of Time Spent in Target Zone')
xlabel('Trial Number')
ylabel('Percentage')
xlim([0.5 7.5])
set(gca, 'XTick', [1 2 3 4 5 6 7])

% %% boxplots!
% 
% gTypePlots = table2array(timetbl(:,2));
% NumericalMWMswimtimeData = table2array(timetbl(:,10:end));
% 
% APOE3Indices = strcmp(gTypePlots, 'APOE3');
% C57Indices = strcmp(gTypePlots, 'C57');
% APOE4Indices = strcmp(gTypePlots, 'APOE4');
% APOE4X = repmat((1:5), sum(APOE4Indices), 1);
% APOE3X = repmat((1:5), sum(APOE3Indices), 1);
% C57X = repmat((1:5), sum(C57Indices), 1);
% 
% APOE4Y = NumericalMWMswimtimeData(APOE4Indices,:);
% APOE3Y = NumericalMWMswimtimeData(APOE3Indices,:);
% C57Y = NumericalMWMswimtimeData(C57Indices,:);
% 
% 
% % [p4, S4]= polyfit(APOE4X(:), APOE4Y(:), 1);
% % [p3, S3]= polyfit(APOE3X(:), APOE3Y(:), 1);
% % [p1, S1]= polyfit(C57X(:), C57Y(:), 1);
% 
% APOE4Groups = cellstr([repmat('APOE4 Trial #', numel(APOE4X), 1) num2str(APOE4X(:))]);
% APOE3Groups = cellstr([repmat('APOE3 Trial #', numel(APOE3X), 1) num2str(APOE3X(:))]);
% C57Groups = cellstr([repmat('C57 Trial #', numel(C57X), 1) num2str(C57X(:))]);
% 
% CombinedSwimtimeMat = [APOE4Y(:); APOE3Y(:); C57Y(:)];
% CombinedSwimtimeMatGroupings = [APOE4Groups(:); APOE3Groups(:); C57Groups(:)];
% 
% figNum = 1;
% figure(figNum)
% clf(figNum)
% figNum = figNum+1;
% hold on
% 
% plot(NaN, NaN, 'rs', 'MarkerFaceColor', 'r');
% plot(NaN, NaN, 'gs','MarkerFaceColor', 'g');
% plot(NaN, NaN, 'bs', 'MarkerFaceColor', 'b');
% 
% colorGroup = [1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3];
% boxplot(CombinedSwimtimeMat, CombinedSwimtimeMatGroupings, ...
%     'ColorGroup', colorGroup);
% 
% % plot(APOE4X, APOE4Y, 'r.');
% % plot(APOE3X, APOE3Y, 'g.');
% % plot(C57X, C57Y, 'b.');
% % 
% % 
% % plot([0.5 5.5], polyval(p4, [0.5 5.5]), 'r');
% % plot([0.5 5.5], polyval(p3, [0.5 5.5]), 'g');
% % plot([0.5 5.5], polyval(p1, [0.5 5.5]), 'b');
% 
% hold off
% grid on
% legend({'APOE4', 'APOE3', 'C57'})
% title('Morris Water Maze Target Swim Time by Genotype')
% xlabel('Trial Number')
% ylabel('Percentage')
% set(gca, 'XTickLabel', {'1', '2', '3', '5', '6', '1', '2', '3', '5',...
%     '6', '1', '2', '3', '5', '6'})
% 
% 
% %% Swim Distance
% gTypePlots = table2array(disttbl(:,2));
% NumericalMWMswimdistData = table2array(disttbl(:,10:end));
% 
% APOE3Indices = strcmp(gTypePlots, 'APOE3');
% C57Indices = strcmp(gTypePlots, 'C57');
% APOE4Indices = strcmp(gTypePlots, 'APOE4');
% APOE4X = repmat((1:5), sum(APOE4Indices), 1);
% APOE3X = repmat((1:5), sum(APOE3Indices), 1);
% C57X = repmat((1:5), sum(C57Indices), 1);
% 
% APOE4Y = NumericalMWMswimdistData(APOE4Indices,:);
% APOE3Y = NumericalMWMswimdistData(APOE3Indices,:);
% C57Y = NumericalMWMswimdistData(C57Indices,:);
% 
% 
% APOE4Groups = cellstr([repmat('APOE4 Trial #', numel(APOE4X), 1) num2str(APOE4X(:))]);
% APOE3Groups = cellstr([repmat('APOE3 Trial #', numel(APOE3X), 1) num2str(APOE3X(:))]);
% C57Groups = cellstr([repmat('C57 Trial #', numel(C57X), 1) num2str(C57X(:))]);
% 
% CombinedSwimDistanceMat = [APOE4Y(:); APOE3Y(:); C57Y(:)];
% CombinedSwimDistanceMatGroupings = [APOE4Groups(:); APOE3Groups(:); C57Groups(:)];
% 
% 
% figure(figNum)
% clf(figNum)
% figNum = figNum+1;
% hold on
% 
% plot(NaN, NaN, 'rs', 'MarkerFaceColor', 'r');
% plot(NaN, NaN, 'gs', 'MarkerFaceColor', 'g');
% plot(NaN, NaN, 'bs', 'MarkerFaceColor', 'b');
% 
% colorGroup = [1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3];
% boxplot(CombinedSwimtimeMat, CombinedSwimtimeMatGroupings, ...
%     'ColorGroup', colorGroup);
% 
% 
% % plot(APOE4X, APOE4Y, 'r.');
% % plot(APOE3X, APOE3Y, 'g.');
% % plot(C57X, C57Y, 'b.');
% % 
% % 
% % plot([0.5 5.5], polyval(p4, [0.5 5.5]), 'r');
% % plot([0.5 5.5], polyval(p3, [0.5 5.5]), 'g');
% % plot([0.5 5.5], polyval(p1, [0.5 5.5]), 'b');
% 
% hold off
% grid on
% legend({'APOE4', 'APOE3', 'C57'})
% title('Morris Water Maze Target Swim Distance by Genotype')
% xlabel('Trial Number')
% ylabel('Percentage')
% set(gca, 'XTickLabel', {'1', '2', '3', '5', '6', '1', '2', '3', '5',...
%     '6', '1', '2', '3', '5', '6'})

%% new traditional boxplots for all trials

gTypePlots = table2array(timeCategorized(:,1));
NumericalMWMswimtimeData = table2array(timeCategorized(:,3:7));

C57youngIndices = strcmp(gTypePlots, 'C57young');
C57oldIndices = strcmp(gTypePlots, 'C57old');
APOE3Indices = strcmp(gTypePlots, 'APOE3');
APOE4Indices = strcmp(gTypePlots, 'APOE4');

C57youngX = repmat((1:5), sum(C57youngIndices), 1);
C57oldX = repmat((1:5), sum(C57oldIndices), 1);
APOE4X = repmat((1:5), sum(APOE4Indices), 1);
APOE3X = repmat((1:5), sum(APOE3Indices), 1);

C57youngY = NumericalMWMswimtimeData(C57youngIndices,:);
C57oldY = NumericalMWMswimtimeData(C57oldIndices,:);
APOE3Y = NumericalMWMswimtimeData(APOE3Indices,:);
APOE4Y = NumericalMWMswimtimeData(APOE4Indices,:);

CombinedSwimtimeMat = {C57youngY; C57oldY; APOE3Y; APOE4Y};

[p4, S4]= polyfit(APOE4X, APOE4Y, 1);
[p3, S3]= polyfit(APOE3X, APOE3Y, 1);
[p1o, S1o]= polyfit(C57oldX, C57oldY, 1);
[p1y, S1y]= polyfit(C57youngX, C57youngY, 1);

figNum = 1;
figure(figNum)
clf(figNum)
figNum = figNum+1;

hold on

aboxplot(CombinedSwimtimeMat,'labels',[1 2 3 5 6])

hold on
plot([0.5 6.5], polyval(p1y, [0.5 6.5]), 'g', 'LineWidth', 2);
plot([0.5 6.5], polyval(p1o, [0.5 6.5]), 'b', 'LineWidth', 2);
plot([0.5 6.5], polyval(p3, [0.5 6.5]), 'm', 'LineWidth', 2);
plot([0.5 6.5], polyval(p4, [0.5 6.5]), 'r', 'LineWidth', 2);

hold off
grid on
legend({'C57 young','C57 old', 'APOE3/HN', 'APOE4/HN','C57 young','C57 old', 'APOE3/HN', 'APOE4/HN'})
title('Morris Water Maze Swim Time by Genotype')
xlabel('Day')
ylabel('Swim Time (s)')
set(gca, 'XTickLabel', {'1', '2', '3', '4', '5'})
set(gca, 'YLim', [0 70])


%% Swim Distance
gTypePlots = table2array(distCategorized(:,1));
NumericalMWMswimtimeData = table2array(distCategorized(:,3:7));

C57youngIndices = strcmp(gTypePlots, 'C57young');
C57oldIndices = strcmp(gTypePlots, 'C57old');
APOE3Indices = strcmp(gTypePlots, 'APOE3');
APOE4Indices = strcmp(gTypePlots, 'APOE4');

C57youngX = repmat((1:5), sum(C57youngIndices), 1);
C57oldX = repmat((1:5), sum(C57oldIndices), 1);
APOE4X = repmat((1:5), sum(APOE4Indices), 1);
APOE3X = repmat((1:5), sum(APOE3Indices), 1);

C57youngY = NumericalMWMswimtimeData(C57youngIndices,:);
C57oldY = NumericalMWMswimtimeData(C57oldIndices,:);
APOE3Y = NumericalMWMswimtimeData(APOE3Indices,:);
APOE4Y = NumericalMWMswimtimeData(APOE4Indices,:);

CombinedSwimDistanceMat = {C57youngY; C57oldY; APOE3Y; APOE4Y};


figure(figNum)
clf(figNum)
figNum = figNum+1;
hold on

aboxplot(CombinedSwimDistanceMat, 'labels', [1 2 3 4 5]);

hold on
plot([0.5 6.5], polyval(p1y, [0.5 6.5]), 'g', 'LineWidth', 2);
plot([0.5 6.5], polyval(p1o, [0.5 6.5]), 'b', 'LineWidth', 2);
plot([0.5 6.5], polyval(p3, [0.5 6.5]), 'm', 'LineWidth', 2);
plot([0.5 6.5], polyval(p4, [0.5 6.5]), 'r', 'LineWidth', 2);

hold off
grid on
legend({'C57 young','C57 old', 'APOE3/HN', 'APOE4/HN','C57 young','C57 old', 'APOE3/HN', 'APOE4/HN'})
title('Morris Water Maze Swim Distance by Genotype')
xlabel('Day')
ylabel('Swim Distance (cm)')
set(gca, 'XTickLabel', {'1', '2', '3', '4', '5'})

%% Target Swim Time

gTypePlots = table2array(timeCategorized(:,1));
NumericalMWMswimtimeData = table2array(timeCategorized(:,8:end));

C57youngIndices = strcmp(gTypePlots, 'C57young');
C57oldIndices = strcmp(gTypePlots, 'C57old');
APOE3Indices = strcmp(gTypePlots, 'APOE3');
APOE4Indices = strcmp(gTypePlots, 'APOE4');

C57youngX = repmat((1:7), sum(C57youngIndices), 1);
C57oldX = repmat((1:7), sum(C57oldIndices), 1);
APOE4X = repmat((1:7), sum(APOE4Indices), 1);
APOE3X = repmat((1:7), sum(APOE3Indices), 1);

C57youngY = NumericalMWMswimtimeData(C57youngIndices,:);
C57oldY = NumericalMWMswimtimeData(C57oldIndices,:);
APOE3Y = NumericalMWMswimtimeData(APOE3Indices,:);
APOE4Y = NumericalMWMswimtimeData(APOE4Indices,:);

CombinedSwimtimeMat = {C57youngY; C57oldY; APOE3Y; APOE4Y};

[p4, S4]= polyfit(APOE4X, APOE4Y, 1);
[p3, S3]= polyfit(APOE3X, APOE3Y, 1);
[p1o, S1o]= polyfit(C57oldX, C57oldY, 1);
[p1y, S1y]= polyfit(C57youngX, C57youngY, 1);

figNum = 1;
figure(figNum)
clf(figNum)
figNum = figNum+1;

hold on

aboxplot(CombinedSwimtimeMat,'labels',[1 2 3 4 5 6 7])

hold on
plot([0.5 7.5], polyval(p1y, [0.5 7.5]), 'g', 'LineWidth', 2);
plot([0.5 7.5], polyval(p1o, [0.5 7.5]), 'b', 'LineWidth', 2);
plot([0.5 7.5], polyval(p3, [0.5 7.5]), 'm', 'LineWidth', 2);
plot([0.5 7.5], polyval(p4, [0.5 7.5]), 'r', 'LineWidth', 2);

hold off
grid on
legend({'C57 young','C57 old', 'APOE3/HN', 'APOE4/HN','C57 young','C57 old', 'APOE3/HN', 'APOE4/HN'})
title('Morris Water Maze Target Swim Time by Genotype')
xlabel('Day')
ylabel('Percentage')
set(gca, 'XTickLabel', {'1', '2', '3', '3 (Probe)', '4', '5', '5 (Probe)'})

%% Target Swim Distance
gTypePlots = table2array(distCategorized(:,1));
NumericalMWMswimtimeData = table2array(distCategorized(:,8:end));

C57youngIndices = strcmp(gTypePlots, 'C57young');
C57oldIndices = strcmp(gTypePlots, 'C57old');
APOE3Indices = strcmp(gTypePlots, 'APOE3');
APOE4Indices = strcmp(gTypePlots, 'APOE4');

C57youngX = repmat((1:7), sum(C57youngIndices), 1);
C57oldX = repmat((1:7), sum(C57oldIndices), 1);
APOE4X = repmat((1:7), sum(APOE4Indices), 1);
APOE3X = repmat((1:7), sum(APOE3Indices), 1);

C57youngY = NumericalMWMswimtimeData(C57youngIndices,:);
C57oldY = NumericalMWMswimtimeData(C57oldIndices,:);
APOE3Y = NumericalMWMswimtimeData(APOE3Indices,:);
APOE4Y = NumericalMWMswimtimeData(APOE4Indices,:);

CombinedSwimtimeMat = {C57youngY; C57oldY; APOE3Y; APOE4Y};

[p4, S4]= polyfit(APOE4X, APOE4Y, 1);
[p3, S3]= polyfit(APOE3X, APOE3Y, 1);
[p1o, S1o]= polyfit(C57oldX, C57oldY, 1);
[p1y, S1y]= polyfit(C57youngX, C57youngY, 1);

figNum = 1;
figure(figNum)
clf(figNum)
figNum = figNum+1;

hold on

aboxplot(CombinedSwimtimeMat,'labels',[1 2 3 4 5 6 7])

hold on
plot([0.5 7.5], polyval(p1y, [0.5 7.5]), 'g', 'LineWidth', 2);
plot([0.5 7.5], polyval(p1o, [0.5 7.5]), 'b', 'LineWidth', 2);
plot([0.5 7.5], polyval(p3, [0.5 7.5]), 'm', 'LineWidth', 2);
plot([0.5 7.5], polyval(p4, [0.5 7.5]), 'r', 'LineWidth', 2);

hold off
grid on
legend({'C57 young','C57 old', 'APOE3/HN', 'APOE4/HN','C57 young','C57 old', 'APOE3/HN', 'APOE4/HN'})
title('Morris Water Maze Target Swim Distance by Genotype')
xlabel('Day')
ylabel('Percentage')
set(gca, 'XTickLabel', {'1', '2', '3', '3 (Probe)', '4', '5', '5 (Probe)'})

%% swim time memory index boxplot
gTypePlots = table2array(memtimeCategorized(:,1));
NumericalMWMswimtimeData = table2array(memtimeCategorized(:,3:end));

C57youngIndices = strcmp(gTypePlots, 'C57young');
C57oldIndices = strcmp(gTypePlots, 'C57old');
APOE3Indices = strcmp(gTypePlots, 'APOE3');
APOE4Indices = strcmp(gTypePlots, 'APOE4');

C57youngX = repmat((1:4), sum(C57youngIndices), 1);
C57oldX = repmat((1:4), sum(C57oldIndices), 1);
APOE4X = repmat((1:4), sum(APOE4Indices), 1);
APOE3X = repmat((1:4), sum(APOE3Indices), 1);

C57youngY = NumericalMWMswimtimeData(C57youngIndices,:);
C57oldY = NumericalMWMswimtimeData(C57oldIndices,:);
APOE3Y = NumericalMWMswimtimeData(APOE3Indices,:);
APOE4Y = NumericalMWMswimtimeData(APOE4Indices,:);

CombinedSwimtimeMat = {C57youngY; C57oldY; APOE3Y; APOE4Y};

[p4, S4]= polyfit(APOE4X, APOE4Y, 1);
[p3, S3]= polyfit(APOE3X, APOE3Y, 1);
[p1o, S1o]= polyfit(C57oldX, C57oldY, 1);
[p1y, S1y]= polyfit(C57youngX, C57youngY, 1);

figNum = 1;
figure(figNum)
clf(figNum)
figNum = figNum+1;

hold on

aboxplot(CombinedSwimtimeMat,'labels',[1 2 3 4 5 6 7])

hold on
plot([0.5 4.5], polyval(p1y, [0.5 4.5]), 'g', 'LineWidth', 2);
plot([0.5 4.5], polyval(p1o, [0.5 4.5]), 'b', 'LineWidth', 2);
plot([0.5 4.5], polyval(p3, [0.5 4.5]), 'm', 'LineWidth', 2);
plot([0.5 4.5], polyval(p4, [0.5 4.5]), 'r', 'LineWidth', 2);

hold off
grid on
legend({'C57 young','C57 old', 'APOE3/HN', 'APOE4/HN','C57 young','C57 old', 'APOE3/HN', 'APOE4/HN'})
title('Morris Water Maze Swim Time Memory Index by Genotype')
xlabel('Index Number')
ylabel('Time Difference (s)')
% set(gca, 'XTickLabel', {'1', '2', '3', '3 (Probe)', '4', '5', '5 (Probe)'})

%% swim distance memory index boxplot
gTypePlots = table2array(memdistCategorized(:,1));
NumericalMWMswimtimeData = table2array(memdistCategorized(:,3:end));

C57youngIndices = strcmp(gTypePlots, 'C57young');
C57oldIndices = strcmp(gTypePlots, 'C57old');
APOE3Indices = strcmp(gTypePlots, 'APOE3');
APOE4Indices = strcmp(gTypePlots, 'APOE4');

C57youngX = repmat((1:4), sum(C57youngIndices), 1);
C57oldX = repmat((1:4), sum(C57oldIndices), 1);
APOE4X = repmat((1:4), sum(APOE4Indices), 1);
APOE3X = repmat((1:4), sum(APOE3Indices), 1);

C57youngY = NumericalMWMswimtimeData(C57youngIndices,:);
C57oldY = NumericalMWMswimtimeData(C57oldIndices,:);
APOE3Y = NumericalMWMswimtimeData(APOE3Indices,:);
APOE4Y = NumericalMWMswimtimeData(APOE4Indices,:);

CombinedSwimtimeMat = {C57youngY; C57oldY; APOE3Y; APOE4Y};

[p4, S4]= polyfit(APOE4X, APOE4Y, 1);
[p3, S3]= polyfit(APOE3X, APOE3Y, 1);
[p1o, S1o]= polyfit(C57oldX, C57oldY, 1);
[p1y, S1y]= polyfit(C57youngX, C57youngY, 1);

figNum = 1;
figure(figNum)
clf(figNum)
figNum = figNum+1;

hold on

aboxplot(CombinedSwimtimeMat,'labels',[1 2 3 4 5 6 7])

hold on
plot([0.5 4.5], polyval(p1y, [0.5 4.5]), 'g', 'LineWidth', 2);
plot([0.5 4.5], polyval(p1o, [0.5 4.5]), 'b', 'LineWidth', 2);
plot([0.5 4.5], polyval(p3, [0.5 4.5]), 'm', 'LineWidth', 2);
plot([0.5 4.5], polyval(p4, [0.5 4.5]), 'r', 'LineWidth', 2);

hold off
grid on
legend({'C57 young','C57 old', 'APOE3/HN', 'APOE4/HN','C57 young','C57 old', 'APOE3/HN', 'APOE4/HN'})
title('Morris Water Maze Swim Distance Memory Index by Genotype')
xlabel('Index Number')
ylabel('Distance Difference (cm)')
% set(gca, 'XTickLabel', {'1', '2', '3', '3 (Probe)', '4', '5', '5 (Probe)'})