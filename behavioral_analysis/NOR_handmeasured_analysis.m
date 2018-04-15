%% read in the concatenated dataset as a table
NOR = readtable('analyzed_data/NOR_analyzed.csv');

% %% calculate location preference (T1) & recognition index (RI)
% func = @(x,y) x/(x+y);
% 
% T1result = rowfun(func,NOR,'OutputVariableNames', 'T1', 'InputVariables', {'Trial1_obj1_time','Trial1_obj2_time'});
% NOR = [NOR T1result];
% 
% T2RIresult = rowfun(func,NOR,'OutputVariableNames', 'T2', 'InputVariables', {'Trial2_novel_time','Trial2_familiar_time'});
% NOR = [NOR T2RIresult];
% 
% T3RIresult = rowfun(func,NOR,'OutputVariableNames', 'T3', 'InputVariables', {'Trial3_novel_time','Trial3_familiar_time'});
% NOR = [NOR T3RIresult];

% %% prepping data for analysis
% 
% data = NOR(:,{'Genotype', 'Sex','AgeGroup','T1', 'T2','T3'});
% datarows = (data.T1>0.4 & data.T2<0.6);
% data = data(datarows,{'Genotype', 'Sex','AgeGroup','T1', 'T2','T3'});
% 
% vars = {'T1', 'T2', 'T3'};
% 
% E4rows = strcmp(NOR.Genotype, 'APOE4');
% myE4 = NOR(E4rows,vars);
% 
% E3rows = strcmp(NOR.Genotype, 'APOE3');
% myE3 = NOR(E3rows,vars);
% 
% C57youngrows = (strcmp(NOR.Genotype, 'C57') & (strcmp(NOR.AgeGroup, 'Younger')));
% myC57_young = NOR(C57youngrows,vars);
% 
% C57oldrows = (strcmp(NOR.Genotype, 'C57') & (strcmp(NOR.AgeGroup, 'Older')));
% myC57_old = NOR(C57oldrows,vars);
% 
% %% normal mice
% 
% vars = {'T1', 'T2', 'T3'};
% 
% E4rows = (strcmp(NOR.Genotype, 'APOE4')&(NOR.T1>0.4 & NOR.T1<0.6));
% normalE4 = NOR(E4rows,vars);
% 
% E3rows = strcmp(NOR.Genotype, 'APOE3')&(NOR.T1>0.4 & NOR.T1<0.6);
% normalE3 = NOR(E3rows,vars);
% 
% C57youngrows = (strcmp(NOR.Genotype, 'C57') & (strcmp(NOR.AgeGroup, 'Younger')) &(NOR.T1>0.4 & NOR.T1<0.6));
% normalC57_young = NOR(C57youngrows,vars);
% 
% C57oldrows = (strcmp(NOR.Genotype, 'C57') & (strcmp(NOR.AgeGroup, 'Older'))&(NOR.T1>0.4 & NOR.T1<0.6));
% normalC57_old = NOR(C57oldrows,vars);
% %% t-tests
% [h,p,ci,stats] = ttest2(normalC57_old.RI_T3, normalC57_young.RI_T3) %p=0.0239
% [h,p,ci,stats] = ttest2(normalE4.RI_T3, normalE3.RI_T3) %trend 0.1079
% [h,p,ci,stats] = ttest2(normalC57_old.RI_T2, normalE4.RI_T2)
% [h,p,ci,stats] = ttest2(normalC57_old.RI_T3, normalE4.RI_T3)
% [h,p,ci,stats] = ttest2(normalE3.RI_T2, normalE4.RI_T2)
% [h,p,ci,stats] = ttest2(normalE3.RI_T3, normalE4.RI_T3)
% 
% %normalC57_old
% [h,p,ci,stats] = ttest2(normalC57_old.T1, normalC57_old.RI_T2)%p=0.0173
% [h,p,ci,stats] = ttest2(normalC57_old.T1, normalC57_old.RI_T3)%p=0.0011
% 
% %normalC57_young
% [h,p,ci,stats] = ttest2(normalC57_young.T1, normalC57_young.RI_T2)%p=0.4018
% [h,p,ci,stats] = ttest2(normalC57_young.T1, normalC57_young.RI_T3)%p=6.6487e-08
% 
% %normalE3
% [h,p,ci,stats] = ttest2(normalE3.T1, normalE3.RI_T2)%p=0.1040
% [h,p,ci,stats] = ttest2(normalE3.T1, normalE3.RI_T3)%p=0.0021
% 
% %normalE4
% [h,p,ci,stats] = ttest2(normalE4.T1, normalE4.RI_T2)%p=0.0460
% [h,p,ci,stats] = ttest2(normalE4.T1, normalE4.RI_T3)%p=0.5088
%% plot
     
% matrixE4 = table2array(normalE4);
% matrixE3 = table2array(normalE3);
% matrixC57_old = table2array(normalC57_old);
% matrixC57_young = table2array(normalC57_young);
% GenAgeGroup = strcat(NOR.Genotype, NOR.AgeGroup);
% 
% boxplot(NOR.RI_T3, GenAgeGroup)
% 
% 
% h1=figure('Name','Apoe3')
% boxplot(matrixE3, 'Labels', {'T1','RI_T2','RI_T3'})
%     xlabel('Measure')
%     ylabel('Object Preference')
%     title('Measures for APOE3 Mice')
%     h1.CurrentAxes.YLim=[0 1]
%     
% h2=figure('Name','Apoe4')
% boxplot(matrixE4, 'Labels', {'T1','RI_T2','RI_T3'})
%     xlabel('Measure')
%     ylabel('Object Preference')
%     title('Measures for APOE4 Mice')
%     h2.CurrentAxes.YLim=[0 1]
%     
% h3=figure('Name','C57_old')
% boxplot(matrixC57_old, 'Labels', {'T1','RI_T2','RI_T3'})
%     xlabel('Measure')
%     ylabel('Object Preference')
%     title('Measures for old C57 Mice')
%     h3.CurrentAxes.YLim=[0 1]
% 
% h4=figure('Name','C57_young')
% boxplot(matrixC57_young, 'Labels', {'T1','RI_T2','RI_T3'})
%     xlabel('Measure')
%     ylabel('Object Preference')
%     title('Measures for young C57 Mice')
%     h4.CurrentAxes.YLim=[0 1]
    
%% prep for statistical analyses
% split into different tables
OlderMice = [NOR(1:25, :); NOR(36:end, :)];
C57Mice = [NOR(1:2, :);NOR(7, :); NOR(20:end, :)];
APOEMice = [NOR(3:6, :);NOR(8:19,:)];

time = [1 2 3]';

%% summary statistics
meanyoungC57 = nanmean(C57Mice{6:15,5:end})
stdyoungC57 = nanstd(C57Mice{6:15,5:end})

meanoldC57 = nanmean([OlderMice{1,5:end}; OlderMice{4:5,5:end}; OlderMice{13:14,5:end}; OlderMice{20:end,5:end}])
stdoldC57 = nanstd([OlderMice{1,5:end}; OlderMice{4:5,5:end}; OlderMice{13:14,5:end}; OlderMice{20:end,5:end}])

meanAPOE3 = nanmean([OlderMice{2:3,5:end}; OlderMice{12,5:end}; OlderMice{15:19,5:end}])
stdAPOE3 = nanstd([OlderMice{2:3,5:end}; OlderMice{12,5:end}; OlderMice{15:19,5:end}])

meanAPOE4 = nanmean(OlderMice{6:11,5:end})
stdAPOE4 = nanstd(OlderMice{6:11,5:end})
%% statistical analyses

sex_rm=fitrm(NOR,'LP-RI_T3 ~ sex', 'WithinDesign',time, 'WithinModel','separatemeans')
sex_tab=ranova(sex_rm)
bl = multcompare(sex_rm,'sex', 'By', 'Time', 'ComparisonType', 'bonferroni')

% RI vs Genotype

genotype_rm=fitrm(OlderMice,'LP-RI_T3 ~ genotype', 'WithinDesign',time, 'WithinModel','separatemeans')
genotype_tab=ranova(genotype_rm)
bl = multcompare(genotype_rm,'genotype', 'By', 'Time', 'ComparisonType', 'bonferroni')

% RI vs Age

age_rm=fitrm(C57Mice,'LP-RI_T3 ~ agegroup', 'WithinDesign',time, 'WithinModel','separatemeans')
age_tab=ranova(age_rm)
bl = multcompare(age_rm,'agegroup', 'By', 'Time', 'ComparisonType', 'bonferroni')

%trying statistics for only E3&E4

APOEgenotype_rm=fitrm(APOEMice,'LP-RI_T3 ~ genotype', 'WithinDesign',time, 'WithinModel','separatemeans')
APOEgenotype_tab=ranova(APOEgenotype_rm)

%% boxplot

gTypePlots = table2array(OlderMice(:,2));
NumericalNOR = table2array(OlderMice(:,5:end));

APOE3Indices = strcmp(gTypePlots, 'APOE3');
C57Indices = strcmp(gTypePlots, 'C57');
APOE4Indices = strcmp(gTypePlots, 'APOE4');

APOE4Y = NumericalNOR(APOE4Indices,:);
APOE3Y = NumericalNOR(APOE3Indices,:);
C57oldY = NumericalNOR(C57Indices,:);
C57youngY = table2array(C57Mice(10:19,5:end));

CombinedNORMat = {C57youngY; C57oldY; APOE3Y; APOE4Y};

figNum = 1;
figure(figNum)
clf(figNum)
figNum = figNum+1;
hold on

aboxplot(CombinedNORMat,'labels',[1 2 3])

hold off
grid on
legend({'C57 young', 'C57 old', 'APOE3', 'APOE4'})
title('Novel Object Recognition Index by Genotype')
xlabel('Trial Number')
ylabel('Recognition Index')
set(gca, 'XTickLabel', {'1', '2', '3'})
bl = multcompare(APOEgenotype_rm,'genotype', 'By', 'Time', 'ComparisonType', 'bonferroni')