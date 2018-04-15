%% import raw behavioral data
% import all MWM data
MWM_master_data = readtable('MWM/mwm_master_012318.xlsx');
MWM_master_data = MWM_master_data(9:55,:);
MWM_master_data([4 14 17 22 24 40 44 45],:) = [];

% import all NOR data
NOR_master_data = readtable('NOR/Raw Data/Hand-measured NOR times.xlsx');
NOR_master_data = NOR_master_data(6:end,:);

%% compile table of working data for MWM swim time
% trial 1, 2, 3, 5, 6
label_MWM4behav = {'animal','genotype','sex','age','T1','T2','T3','T4','T5','T1target','T2target','T3target','T5target','T6target'};
label_MWM4corr = {'animal','genotype','sex','age','T1','T2','T3','T4','T5'};
label_MWMprobe = {'animal','genotype','sex','age','T4','T7','T4target','T7target'};

arrayMWM = table2array(MWM_master_data(:,5:end));

t1time = (nanmean(arrayMWM(:,1:4)'))';
t2time = (nanmean(arrayMWM(:,5:8)'))';
t3time = (nanmean(arrayMWM(:,9:12)'))';
t4time = arrayMWM(:,13);
t5time = (nanmean(arrayMWM(:,14:17)'))';
t6time = (nanmean(arrayMWM(:,18:21)'))';
t7time = arrayMWM(:,22);

SWt1time = (nanmean(arrayMWM(:,265:268)'))';
SWt2time = (nanmean(arrayMWM(:,269:272)'))';
SWt3time = (nanmean(arrayMWM(:,273:276)'))';
SWt4time = (nanmean(arrayMWM(:,277)'))';
SWt5time = (nanmean(arrayMWM(:,278:281)'))';
SWt6time = (nanmean(arrayMWM(:,282:285)'))';
SWt7time = (nanmean(arrayMWM(:,286)'))';

platformt4time = arrayMWM(:,431);
platformt7time = arrayMWM(:,440);

% convert genotype number to string
MWM_genotype_num = MWM_master_data.genotype;
MWM_genotype_txt = repmat({'C57'},size(MWM_genotype_num));
for i=1:size(MWM_genotype_num)
    if MWM_genotype_num{i,1}=='3'
        MWM_genotype_txt(i,1) = {'APOE3'};
    end
    if MWM_genotype_num{i,1}=='4'
        MWM_genotype_txt(i,1) = {'APOE4'};  
    end
end

% convert sex number to string
MWM_sex_num = MWM_master_data.sex;
MWM_sex_num = num2str(MWM_sex_num);
MWM_sex_txt = repmat({'M'}, size(MWM_sex_num));
for i=1:size(MWM_sex_num)
    if MWM_sex_num(i,1)=='1'
        MWM_sex_txt(i,1) = {'F'};
    end
end

% group ages
MWM_age = MWM_master_data.age;
MWM_age_group = repmat({'older'}, size(MWM_age));
for i=1:size(MWM_age)
    if MWM_age(i,1)<200
        MWM_age_group(i,1) = {'younger'};
    end
end

MWMtime4corr = table(MWM_master_data.Animal, MWM_genotype_txt, MWM_sex_txt, MWM_age_group,t1time,t2time,t3time,t5time,t6time,'VariableNames',label_MWM4corr);


MWMtime4behav = table(MWM_master_data.Animal, MWM_genotype_txt, MWM_sex_txt, MWM_age_group,t1time,t2time,t3time,t5time,t6time,...
    (SWt1time./t1time),(SWt2time./t2time),(SWt3time./t3time),(SWt5time./t5time),(SWt6time./t6time),'VariableNames',label_MWM4behav);

MWMtimeprobe = table(MWM_master_data.Animal, MWM_genotype_txt, MWM_sex_txt, MWM_age_group,t4time,t7time,...
    (platformt4time./t4time),(platformt7time./t7time),'VariableNames',label_MWMprobe);


% writetable(MWMtimeprobe,'analyzed_data/MWM_probetime.csv');
% writetable(MWMtime4corr,'analyzed_data/MWM_swimtime_corr.csv');
writetable(MWMtime4behav,'analyzed_data/MWM_swimtime_behav.csv');

%% compile table of working data for MWM swim distance

t1dist = (nanmean(arrayMWM(:,23:26)'))';
t2dist = (nanmean(arrayMWM(:,27:30)'))';
t3dist = (nanmean(arrayMWM(:,31:34)'))';
t5dist = (nanmean(arrayMWM(:,36:39)'))';
t6dist = (nanmean(arrayMWM(:,40:43)'))';

SWt1dist = (nanmean(arrayMWM(:,287:290)'))';
SWt2dist = (nanmean(arrayMWM(:,291:294)'))';
SWt3dist = (nanmean(arrayMWM(:,295:298)'))';
SWt5dist = (nanmean(arrayMWM(:,300:303)'))';
SWt6dist = (nanmean(arrayMWM(:,304:307)'))';

MWMdist4corr = table(MWM_master_data.Animal, MWM_genotype_txt, MWM_sex_txt, MWM_age_group,t1dist,t2dist,t3dist,t5dist,t6dist,'VariableNames',label_MWM4corr);

MWMdist4behav = table(MWM_master_data.Animal, MWM_genotype_txt, MWM_sex_txt, MWM_age_group,t1dist,t2dist,t3dist,t5dist,t6dist,...
    (SWt1dist./t1dist),(SWt2dist./t2dist),(SWt3dist./t3dist),(SWt5dist./t5dist),(SWt6dist./t6dist),'VariableNames',label_MWM4behav);

% writetable(MWMdist4corr,'analyzed_data/MWM_swimdist_corr.csv');
writetable(MWMdist4behav,'analyzed_data/MWM_swimdist_behav.csv');

%% compile table of working data for NOR

labels_NOR = {'LP','RI_T2','RI_T3'};

% create table for workable data
NOR_data = table(NOR_master_data.AnimalID,NOR_master_data.Genotype,NOR_master_data.Sex,NOR_master_data.AgeGroup,'VariableNames',{'animal','genotype','sex','agegroup'});

% quick equation for calculating Location Preference and Recognition Index
func = @(x,y) x/(x+y);

% calculate values and append to NOR_data
LPresult = rowfun(func,NOR_master_data,'OutputVariableNames', 'LP', 'InputVariables', {'Trial1_obj1_time','Trial1_obj2_time'});
NOR_data = [NOR_data LPresult];

T2RIresult = rowfun(func,NOR_master_data,'OutputVariableNames', 'RI_T2', 'InputVariables', {'Trial2_novel_time','Trial2_familiar_time'});
NOR_data = [NOR_data T2RIresult];

T3RIresult = rowfun(func,NOR_master_data,'OutputVariableNames', 'RI_T3', 'InputVariables', {'Trial3_novel_time','Trial3_familiar_time'});
NOR_data = [NOR_data T3RIresult];

[missx,missy] = find(ismissing(NOR_data));
NOR_data{missx,missy} = 0;

datarows = (NOR_data.LP>0.4 & NOR_data.LP<0.6);
NOR_data = NOR_data(datarows,{'animal','genotype', 'sex','agegroup','LP', 'RI_T2','RI_T3'});

% writetable(NOR_data,'analyzed_data/NOR_analyzed.csv');