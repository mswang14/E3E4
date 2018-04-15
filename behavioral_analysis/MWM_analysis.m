%% import raw behavioral data
% import all MWM data
timetbl = readtable('analyzed_data/MWM_swimtime_behav.csv');
disttbl = readtable('analyzed_data/MWM_swimdist_behav.csv');


%% prep for statistical analyses
% split into different tables
timeOlderMice = [timetbl(1:19, :); timetbl(30:end, :)];
timeC57Mice = [timetbl(1, :);timetbl(4:5, :);timetbl(13:14, :); timetbl(20:end, :)];
timeAPOEMice = [timetbl(2:3, :);timetbl(6:12, :);timetbl(15:19, :)];

distOlderMice = [disttbl(1:19, :); disttbl(30:end, :)];
distC57Mice = [disttbl(1, :);disttbl(4:5, :);disttbl(13:14, :); disttbl(20:end, :)];
distAPOEMice = [disttbl(2:3, :);disttbl(6:12, :);disttbl(15:19, :)];

%% summary statistics
% swim time
meantimeyoungC57 = nanmean(timeC57Mice{6:15,5:9})
stdtimeyoungC57 = nanstd(timeC57Mice{6:15,5:9})

meantimeoldC57 = nanmean([timeOlderMice{1,5:9}; timeOlderMice{4:5,5:9}; timeOlderMice{13:14,5:9}; timeOlderMice{20:end,5:9}])
stdtimeoldC57 = nanstd([timeOlderMice{1,5:9}; timeOlderMice{4:5,5:9}; timeOlderMice{13:14,5:9}; timeOlderMice{20:end,5:9}])

meantimeAPOE3 = nanmean([timeOlderMice{2:3,5:9}; timeOlderMice{12,5:9}; timeOlderMice{15:19,5:9}])
stdtimeAPOE3 = nanstd([timeOlderMice{2:3,5:9}; timeOlderMice{12,5:9}; timeOlderMice{15:19,5:9}])

meantimeAPOE4 = nanmean(timeOlderMice{6:11,5:9})
stdtimeAPOE4 = nanstd(timeOlderMice{6:11,5:9})

% swim distance
meandistyoungC57 = nanmean(distC57Mice{6:15,5:9})
stddistyoungC57 = nanstd(distC57Mice{6:15,5:9})

meandistoldC57 = nanmean([distOlderMice{1,5:9}; distOlderMice{4:5,5:9}; distOlderMice{13:14,5:9}; distOlderMice{20:end,5:9}])
stddistoldC57 = nanstd([distOlderMice{1,5:9}; distOlderMice{4:5,5:9}; distOlderMice{13:14,5:9}; distOlderMice{20:end,5:9}])

meandistAPOE3 = nanmean([distOlderMice{2:3,5:9}; distOlderMice{12,5:9}; distOlderMice{15:19,5:9}])
stddistAPOE3 = nanstd([distOlderMice{2:3,5:9}; distOlderMice{12,5:9}; distOlderMice{15:19,5:9}])

meandistAPOE4 = nanmean(distOlderMice{6:11,5:9})
stddistAPOE4 = nanstd(distOlderMice{6:11,5:9})

% target swim time
meantargettimeyoungC57 = nanmean(timeC57Mice{6:15,10:end})
stdtargettimeyoungC57 = nanstd(timeC57Mice{6:15,10:end})

meantargettimeoldC57 = nanmean([timeOlderMice{1,10:end}; timeOlderMice{4:5,10:end}; timeOlderMice{13:14,10:end}; timeOlderMice{20:end,10:end}])
stdtargettimeoldC57 = nanstd([timeOlderMice{1,10:end}; timeOlderMice{4:5,10:end}; timeOlderMice{13:14,10:end}; timeOlderMice{20:end,10:end}])

meantargettimeAPOE3 = nanmean([timeOlderMice{2:3,10:end}; timeOlderMice{12,10:end}; timeOlderMice{15:19,10:end}])
stdtargettimeAPOE3 = nanstd([timeOlderMice{2:3,10:end}; timeOlderMice{12,10:end}; timeOlderMice{15:19,10:end}])

meantargettimeAPOE4 = nanmean(timeOlderMice{6:11,10:end})
stdtargettimeAPOE4 = nanstd(timeOlderMice{6:11,10:end})

% targetswim distance
meantargetdistyoungC57 = nanmean(distC57Mice{6:15,10:end})
stdtargetdistyoungC57 = nanstd(distC57Mice{6:15,10:end})

meantargetdistoldC57 = nanmean([distOlderMice{1,10:end}; distOlderMice{4:5,10:end}; distOlderMice{13:14,10:end}; distOlderMice{20:end,10:end}])
stdtargetdistoldC57 = nanstd([distOlderMice{1,10:end}; distOlderMice{4:5,10:end}; distOlderMice{13:14,10:end}; distOlderMice{20:end,10:end}])

meantargetdistAPOE3 = nanmean([distOlderMice{2:3,10:end}; distOlderMice{12,10:end}; distOlderMice{15:19,10:end}])
stdtargetdistAPOE3 = nanstd([distOlderMice{2:3,10:end}; distOlderMice{12,10:end}; distOlderMice{15:19,10:end}])

meantargetdistAPOE4 = nanmean(distOlderMice{6:11,10:end})
stdtargetdistAPOE4 = nanstd(distOlderMice{6:11,10:end})

%% ANOVA swimtime

time=[1 2 3 4 5]';

% test to make sure no sex differences
time_sex_rm=fitrm(timetbl,'T1-T5 ~ sex', 'WithinDesign',time, 'WithinModel','separatemeans')
time_sex_tab=ranova(time_sex_rm)
bl = multcompare(time_sex_rm,'sex', 'By', 'Time', 'ComparisonType', 'bonferroni')

time_sex_rm=fitrm(timetbl,'T1target-T6target ~ sex', 'WithinDesign',time, 'WithinModel','separatemeans')
time_sex_tab=ranova(time_sex_rm)
bl = multcompare(time_sex_rm,'sex', 'By', 'Time', 'ComparisonType', 'bonferroni')

% swimtime
time_oldgenotype_rm=fitrm(timeOlderMice,'T1-T5 ~ genotype', 'WithinDesign',time, 'WithinModel','separatemeans')
time_oldgenotype_tab=ranova(time_oldgenotype_rm)
bl = multcompare(time_oldgenotype_rm,'genotype', 'By', 'Time', 'ComparisonType', 'bonferroni')

time_APOEgenotype_rm=fitrm(timeAPOEMice,'T1-T5 ~ genotype', 'WithinDesign',time, 'WithinModel','separatemeans')
time_APOEgenotype_tab=ranova(time_APOEgenotype_rm)
bl = multcompare(time_APOEgenotype_rm,'genotype', 'By', 'Time', 'ComparisonType', 'bonferroni')

time_C57age_rm=fitrm(timeC57Mice,'T1-T5 ~ age', 'WithinDesign',time, 'WithinModel','separatemeans')
time_C57age_tab=ranova(time_C57age_rm)
bl = multcompare(time_C57age_rm,'age', 'By', 'Time', 'ComparisonType', 'bonferroni')

targettime_oldgenotype_rm=fitrm(timeOlderMice,'T1target-T6target ~ genotype', 'WithinDesign',time, 'WithinModel','separatemeans')
targettime_oldgenotype_tab=ranova(targettime_oldgenotype_rm)
bl = multcompare(targettime_oldgenotype_rm,'genotype', 'By', 'Time', 'ComparisonType', 'bonferroni')

targettime_APOEgenotype_rm=fitrm(timeAPOEMice,'T1target-T6target ~ genotype', 'WithinDesign',time, 'WithinModel','separatemeans')
targettime_APOEgenotype_tab=ranova(targettime_APOEgenotype_rm)
bl = multcompare(targettime_APOEgenotype_rm,'genotype', 'By', 'Time', 'ComparisonType', 'bonferroni')

targettime_C57age_rm=fitrm(timeC57Mice,'T1target-T6target ~ age', 'WithinDesign',time, 'WithinModel','separatemeans')
targettime_C57age_tab=ranova(targettime_C57age_rm)
bl = multcompare(targettime_C57age_rm,'age', 'By', 'Time', 'ComparisonType', 'bonferroni')

% swimdist
dist_oldgenotype_rm=fitrm(distOlderMice,'T1-T5 ~ genotype', 'WithinDesign',time, 'WithinModel','separatemeans')
dist_oldgenotype_tab=ranova(dist_oldgenotype_rm)
bl = multcompare(dist_oldgenotype_rm,'genotype', 'By', 'Time', 'ComparisonType', 'bonferroni')

dist_APOEgenotype_rm=fitrm(distAPOEMice,'T1-T5 ~ genotype', 'WithinDesign',time, 'WithinModel','separatemeans')
dist_APOEgenotype_tab=ranova(dist_APOEgenotype_rm)
bl = multcompare(dist_APOEgenotype_rm,'genotype', 'By', 'Time', 'ComparisonType', 'bonferroni')

dist_C57age_rm=fitrm(distC57Mice,'T1-T5 ~ age', 'WithinDesign',time, 'WithinModel','separatemeans')
dist_C57age_tab=ranova(dist_C57age_rm)
bl = multcompare(dist_C57age_rm,'age', 'By', 'Time', 'ComparisonType', 'bonferroni')

targetdist_oldgenotype_rm=fitrm(distOlderMice,'T1target-T6target ~ genotype', 'WithinDesign',time, 'WithinModel','separatemeans')
targetdist_oldgenotype_tab=ranova(targetdist_oldgenotype_rm)
bl = multcompare(targetdist_oldgenotype_rm,'genotype', 'Bys', 'Time', 'ComparisonType', 'bonferroni')

targetdist_APOEgenotype_rm=fitrm(distAPOEMice,'T1target-T6target ~ genotype', 'WithinDesign',time, 'WithinModel','separatemeans')
targetdist_APOEgenotype_tab=ranova(targetdist_APOEgenotype_rm)
bl = multcompare(targetdist_APOEgenotype_rm,'genotype', 'By', 'Time', 'ComparisonType', 'bonferroni')

targetdist_C57age_rm=fitrm(distC57Mice,'T1target-T6target ~ age', 'WithinDesign',time, 'WithinModel','separatemeans')
targetdist_C57age_tab=ranova(targetdist_C57age_rm)
bl = multcompare(targetdist_C57age_rm,'age', 'By', 'Time', 'ComparisonType', 'bonferroni')

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

%% boxplots!

gTypePlots = table2array(timetbl(:,2));
NumericalMWMswimtimeData = table2array(timetbl(:,10:end));

APOE3Indices = strcmp(gTypePlots, 'APOE3');
C57Indices = strcmp(gTypePlots, 'C57');
APOE4Indices = strcmp(gTypePlots, 'APOE4');
APOE4X = repmat((1:5), sum(APOE4Indices), 1);
APOE3X = repmat((1:5), sum(APOE3Indices), 1);
C57X = repmat((1:5), sum(C57Indices), 1);

APOE4Y = NumericalMWMswimtimeData(APOE4Indices,:);
APOE3Y = NumericalMWMswimtimeData(APOE3Indices,:);
C57Y = NumericalMWMswimtimeData(C57Indices,:);


% [p4, S4]= polyfit(APOE4X(:), APOE4Y(:), 1);
% [p3, S3]= polyfit(APOE3X(:), APOE3Y(:), 1);
% [p1, S1]= polyfit(C57X(:), C57Y(:), 1);

APOE4Groups = cellstr([repmat('APOE4 Trial #', numel(APOE4X), 1) num2str(APOE4X(:))]);
APOE3Groups = cellstr([repmat('APOE3 Trial #', numel(APOE3X), 1) num2str(APOE3X(:))]);
C57Groups = cellstr([repmat('C57 Trial #', numel(C57X), 1) num2str(C57X(:))]);

CombinedSwimtimeMat = [APOE4Y(:); APOE3Y(:); C57Y(:)];
CombinedSwimtimeMatGroupings = [APOE4Groups(:); APOE3Groups(:); C57Groups(:)];

figNum = 1;
figure(figNum)
clf(figNum)
figNum = figNum+1;
hold on

plot(NaN, NaN, 'rs', 'MarkerFaceColor', 'r');
plot(NaN, NaN, 'gs','MarkerFaceColor', 'g');
plot(NaN, NaN, 'bs', 'MarkerFaceColor', 'b');

colorGroup = [1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3];
boxplot(CombinedSwimtimeMat, CombinedSwimtimeMatGroupings, ...
    'ColorGroup', colorGroup);

% plot(APOE4X, APOE4Y, 'r.');
% plot(APOE3X, APOE3Y, 'g.');
% plot(C57X, C57Y, 'b.');
% 
% 
% plot([0.5 5.5], polyval(p4, [0.5 5.5]), 'r');
% plot([0.5 5.5], polyval(p3, [0.5 5.5]), 'g');
% plot([0.5 5.5], polyval(p1, [0.5 5.5]), 'b');

hold off
grid on
legend({'APOE4', 'APOE3', 'C57'})
title('Morris Water Maze Target Swim Time by Genotype')
xlabel('Trial Number')
ylabel('Percentage')
set(gca, 'XTickLabel', {'1', '2', '3', '5', '6', '1', '2', '3', '5',...
    '6', '1', '2', '3', '5', '6'})


%% Swim Distance
gTypePlots = table2array(disttbl(:,2));
NumericalMWMswimdistData = table2array(disttbl(:,10:end));

APOE3Indices = strcmp(gTypePlots, 'APOE3');
C57Indices = strcmp(gTypePlots, 'C57');
APOE4Indices = strcmp(gTypePlots, 'APOE4');
APOE4X = repmat((1:5), sum(APOE4Indices), 1);
APOE3X = repmat((1:5), sum(APOE3Indices), 1);
C57X = repmat((1:5), sum(C57Indices), 1);

APOE4Y = NumericalMWMswimdistData(APOE4Indices,:);
APOE3Y = NumericalMWMswimdistData(APOE3Indices,:);
C57Y = NumericalMWMswimdistData(C57Indices,:);


APOE4Groups = cellstr([repmat('APOE4 Trial #', numel(APOE4X), 1) num2str(APOE4X(:))]);
APOE3Groups = cellstr([repmat('APOE3 Trial #', numel(APOE3X), 1) num2str(APOE3X(:))]);
C57Groups = cellstr([repmat('C57 Trial #', numel(C57X), 1) num2str(C57X(:))]);

CombinedSwimDistanceMat = [APOE4Y(:); APOE3Y(:); C57Y(:)];
CombinedSwimDistanceMatGroupings = [APOE4Groups(:); APOE3Groups(:); C57Groups(:)];


figure(figNum)
clf(figNum)
figNum = figNum+1;
hold on

plot(NaN, NaN, 'rs', 'MarkerFaceColor', 'r');
plot(NaN, NaN, 'gs', 'MarkerFaceColor', 'g');
plot(NaN, NaN, 'bs', 'MarkerFaceColor', 'b');

colorGroup = [1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3];
boxplot(CombinedSwimtimeMat, CombinedSwimtimeMatGroupings, ...
    'ColorGroup', colorGroup);


% plot(APOE4X, APOE4Y, 'r.');
% plot(APOE3X, APOE3Y, 'g.');
% plot(C57X, C57Y, 'b.');
% 
% 
% plot([0.5 5.5], polyval(p4, [0.5 5.5]), 'r');
% plot([0.5 5.5], polyval(p3, [0.5 5.5]), 'g');
% plot([0.5 5.5], polyval(p1, [0.5 5.5]), 'b');

hold off
grid on
legend({'APOE4', 'APOE3', 'C57'})
title('Morris Water Maze Target Swim Distance by Genotype')
xlabel('Trial Number')
ylabel('Percentage')
set(gca, 'XTickLabel', {'1', '2', '3', '5', '6', '1', '2', '3', '5',...
    '6', '1', '2', '3', '5', '6'})

%% new traditional boxplots for all trials

gTypePlots = table2array(timeOlderMice(:,2));
NumericalMWMswimtimeData = table2array(timeOlderMice(:,5:9));

APOE3Indices = strcmp(gTypePlots, 'APOE3');
C57Indices = strcmp(gTypePlots, 'C57');
APOE4Indices = strcmp(gTypePlots, 'APOE4');

APOE4Y = NumericalMWMswimtimeData(APOE4Indices,:);
APOE3Y = NumericalMWMswimtimeData(APOE3Indices,:);
C57oldY = NumericalMWMswimtimeData(C57Indices,:);
C57youngY = table2array(timeC57Mice(6:15,5:9));

CombinedSwimtimeMat = {C57youngY; C57oldY; APOE3Y; APOE4Y};

figNum = 1;
figure(figNum)
clf(figNum)
figNum = figNum+1;

hold on

aboxplot(CombinedSwimtimeMat,'labels',[1 2 3 5 6])

hold off
grid on
legend({'C57 young','C57 old', 'APOE3', 'APOE4'})
title('Morris Water Maze Swim Time by Genotype')
xlabel('Trial Number')
ylabel('Swim Time (s)')
set(gca, 'XTickLabel', {'1', '2', '3', '5', '6'})
set(gca, 'YLim', [0 70])


%% Swim Distance
gTypePlots = table2array(distOlderMice(:,2));
NumericalMWMswimdistData = table2array(distOlderMice(:,5:9));

APOE3Indices = strcmp(gTypePlots, 'APOE3');
C57Indices = strcmp(gTypePlots, 'C57');
APOE4Indices = strcmp(gTypePlots, 'APOE4');

APOE4Y = NumericalMWMswimdistData(APOE4Indices,:);
APOE3Y = NumericalMWMswimdistData(APOE3Indices,:);
C57oldY = NumericalMWMswimdistData(C57Indices,:);
C57youngY = table2array(distC57Mice(6:15,5:9));

CombinedSwimDistanceMat = {C57youngY; C57oldY; APOE3Y; APOE4Y};


figure(figNum)
clf(figNum)
figNum = figNum+1;
hold on

aboxplot(CombinedSwimDistanceMat, 'labels', [1 2 3 5 6]);

hold off
grid on
legend({'C57 young', 'C57 old', 'APOE3', 'APOE4'})
title('Morris Water Maze Swim Distance by Genotype')
xlabel('Trial Number')
ylabel('Swim Distance (cm)')
set(gca, 'XTickLabel', {'1', '2', '3', '5', '6'})

%% Target Swim Time

gTypePlots = table2array(timeOlderMice(:,2));
NumericalMWMswimtimeData = table2array(timeOlderMice(:,10:end));

APOE3Indices = strcmp(gTypePlots, 'APOE3');
C57Indices = strcmp(gTypePlots, 'C57');
APOE4Indices = strcmp(gTypePlots, 'APOE4');

APOE4Y = NumericalMWMswimtimeData(APOE4Indices,:);
APOE3Y = NumericalMWMswimtimeData(APOE3Indices,:);
C57oldY = NumericalMWMswimtimeData(C57Indices,:);
C57youngY = table2array(timeC57Mice(6:15,10:end));

CombinedTargetSwimtimeMat = {C57youngY; C57oldY; APOE3Y; APOE4Y};

figNum = 1;
figure(figNum)
clf(figNum)
figNum = figNum+1;
hold on

aboxplot(CombinedTargetSwimtimeMat,'labels',[1 2 3 5 6])

hold off
grid on
legend({'C57 young', 'C57 old' 'APOE3', 'APOE4'})
title('Morris Water Maze Target Swim Time by Genotype')
xlabel('Trial Number')
ylabel('Percentage')
set(gca, 'XTickLabel', {'1', '2', '3', '5', '6'})


%% Target Swim Distance
gTypePlots = table2array(distOlderMice(:,2));
NumericalMWMswimdistData = table2array(distOlderMice(:,10:end));

APOE3Indices = strcmp(gTypePlots, 'APOE3');
C57Indices = strcmp(gTypePlots, 'C57');
APOE4Indices = strcmp(gTypePlots, 'APOE4');

APOE4Y = NumericalMWMswimdistData(APOE4Indices,:);
APOE3Y = NumericalMWMswimdistData(APOE3Indices,:);
C57oldY = NumericalMWMswimdistData(C57Indices,:);
C57youngY = table2array(distC57Mice(6:15,10:end));

CombinedTargetSwimDistanceMat = {C57youngY; C57oldY; APOE3Y; APOE4Y};


figure(figNum)
clf(figNum)
figNum = figNum+1;
hold on

aboxplot(CombinedTargetSwimDistanceMat, 'labels', [1 2 3 5 6]);

hold off
grid on
legend({'C57 young', 'C57 old', 'APOE3', 'APOE4'})
title('Morris Water Maze Target Swim Distance by Genotype')
xlabel('Trial Number')
ylabel('Swim Distance (cm)')
set(gca, 'XTickLabel', {'1', '2', '3', '5', '6'})