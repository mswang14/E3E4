%% import behavioral data
MWM_swimtime = readtable('analyzed_data/MWM_swimtime_corr.csv');
MWM_swimdist = readtable('analyzed_data/MWM_swimdist_corr.csv');
NOR_data = readtable('analyzed_data/NOR_analyzed.csv');

labels_MWMtime = {'swimtime_t1','swimtime_t2','swimtime_t3','swimtime_t5','swimtime_t6'};
labels_MWMdist = {'swimdist_t1','swimdist_t2','swimdist_t3','swimdist_t5','swimdist_t6'};
labels_NOR = {'LP','RI_T2','RI_T3'};

%% compile table of working data for connectomics

runnos = {'N54759','N54760','N54761','N54762','N54763', 'N54764','N54765','N54766','N54770','N54771','N54772','N54798','N54801','N54802','N54803','N54804','N54807','N54825','N54826','N54837','N54838','N54843','N54844','N54856','N54858','N54859','N54860','N54861','N54873','N54874','N54875','N54876','N54877','N54879','N54880','N54891','N54892','N54898','N54899'};

netprop_runno_data = table(runnos','VariableNames',{'runno'});
netprop_roi_data = double.empty(0,0,0);
netprop_vals = double.empty(0,0);

for j=1:numel(runnos) 
    % import values from netprop text files
    netprops = importdata(['connectome_data/connectunthresh_1milSeed/' char(runnos{j}) 'network_measures.txt'],'');
    
    % individual netprop values
    netprop_vals_temp = double.empty(0,0);
    for i=1:19
        netprop_split = split(netprops{i});
        netprop_vals_temp = [netprop_vals_temp netprop_split(2)];
    end
    netprop_vals = vertcat(netprop_vals, netprop_vals_temp);
    % values for individual roi's
    roi_vals_temp = double.empty(0,0);
    for k=21:34
       roi_split = split(netprops{k});
       roi_vals_temp = [roi_vals_temp, roi_split(2:333)];
    end
    % convert split string arrays to double
    roi_vals_temp = str2double(roi_vals_temp);
    netprop_roi_data(:,j,:) = roi_vals_temp;
    % netprop_roi_data is organized as such: (roi,runno(in order),measure)
end
labels_netprop_runno = {'density','cluscoeff_avg_bin','cluscoeff_avg_weight','transitivity_bin','transitivity_weight','netcharpathlength_bin','netcharpathlength_weight','smallworld_bin','smallworld_weight','globaleff_bin','globaleff_weight','graphdiam_bin','graphdiam_weight','graphrad_bin','graphrad_weight','localeff_bin','localeff_weight','assortcoeff_bin','assortcoeff_weight'};
netprop_runno_data = [netprop_runno_data array2table(str2double(netprop_vals),'VariableNames',labels_netprop_runno)];

% hippocampus, entorhinal cortex, amygdala, temporal association cortex,
% fimbria, fornix, cingulate cortex
% values: 51, 42-46, 65, 34, 120, 122, 1-9, 149 (166)

labels_netprop_roi = {'degree_bin','strength_weight','clustercoeff_bin','clustercoeff_weight','localeff_bin','localeff_weight','betweencent_bin','betweencent_weight','eigenvectorcent_bin','eigenvectorcent_weight','pagerankcent_bin','pagerankcent_weight','eccent_bin','eccent_weight'};

netprops_hippocampusR = array2table(permute(netprop_roi_data(51,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos); 
netprops_entorhinalR_caudomedial = array2table(permute(netprop_roi_data(42,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos);
netprops_entorhinalR_dorsalintermediate = array2table(permute(netprop_roi_data(43,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos); 
netprops_entorhinalR_dorsolateral = array2table(permute(netprop_roi_data(44,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos);
netprops_entorhinalR_medial = array2table(permute(netprop_roi_data(45,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos); 
netprops_entorhinalR_ventralintermediate = array2table(permute(netprop_roi_data(46,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos);
netprops_amygdalaR = array2table(permute(netprop_roi_data(65,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos); 
netprops_temporalassnR = array2table(permute(netprop_roi_data(34,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos);
netprops_fimbriaR = array2table(permute(netprop_roi_data(120,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos); 
netprops_fornixR = array2table(permute(netprop_roi_data(122,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos);
netprops_cingulate_24aR = array2table(permute(netprop_roi_data(1,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos); 
netprops_cingulate_24apR = array2table(permute(netprop_roi_data(2,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos);
netprops_cingulate_24bR = array2table(permute(netprop_roi_data(3,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos); 
netprops_cingulate_24bpR = array2table(permute(netprop_roi_data(4,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos);
netprops_cingulate_29aR = array2table(permute(netprop_roi_data(5,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos); 
netprops_cingulate_29bR = array2table(permute(netprop_roi_data(6,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos);
netprops_cingulate_29cR = array2table(permute(netprop_roi_data(7,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos); 
netprops_cingulate_30R = array2table(permute(netprop_roi_data(8,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos);
netprops_cingulate_32R = array2table(permute(netprop_roi_data(9,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos); 
netprops_cingulate_25R = array2table(permute(netprop_roi_data(149,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos);

netprops_hippocampusL = array2table(permute(netprop_roi_data(217,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos); 
netprops_entorhinalL_caudomedial = array2table(permute(netprop_roi_data(208,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos);
netprops_entorhinalL_dorsalintermediate = array2table(permute(netprop_roi_data(209,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos); 
netprops_entorhinalL_dorsolateral = array2table(permute(netprop_roi_data(210,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos);
netprops_entorhinalL_medial = array2table(permute(netprop_roi_data(211,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos); 
netprops_entorhinalL_ventralintermediate = array2table(permute(netprop_roi_data(212,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos);
netprops_amygdalaL = array2table(permute(netprop_roi_data(231,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos); 
netprops_temporalassnL = array2table(permute(netprop_roi_data(200,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos);
netprops_fimbriaL = array2table(permute(netprop_roi_data(286,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos); 
netprops_fornixL = array2table(permute(netprop_roi_data(288,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos);
netprops_cingulate_24aL = array2table(permute(netprop_roi_data(167,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos); 
netprops_cingulate_24apL = array2table(permute(netprop_roi_data(168,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos);
netprops_cingulate_24bL = array2table(permute(netprop_roi_data(169,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos); 
netprops_cingulate_24bpL = array2table(permute(netprop_roi_data(170,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos);
netprops_cingulate_29aL = array2table(permute(netprop_roi_data(171,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos); 
netprops_cingulate_29bL = array2table(permute(netprop_roi_data(172,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos);
netprops_cingulate_29cL = array2table(permute(netprop_roi_data(173,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos); 
netprops_cingulate_30L = array2table(permute(netprop_roi_data(174,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos);
netprops_cingulate_32L = array2table(permute(netprop_roi_data(175,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos); 
netprops_cingulate_25L = array2table(permute(netprop_roi_data(315,:,:), [2 3 1]),'VariableNames',labels_netprop_roi,'RowNames',runnos);

%% explore correlations for DTI netprops

%MWM distance vs netprops
[rho.MWMdist_NetpropRunno,pval.MWMdist_NetpropRunno] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprop_runno_data(:,2:end)),'type','Spearman');
[rho.MWMdist_amygdalaL,pval.MWMdist_amygdalaL] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_amygdalaL),'type','Spearman');
[rho.MWMdist_amygdalaR,pval.MWMdist_amygdalaR] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_amygdalaR),'type','Spearman');
[rho.MWMdist_cingulate_25aL,pval.MWMdist_cingulate_25aL] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_cingulate_24aL),'type','Spearman');
[rho.MWMdist_cingulate_24apL,pval.MWMdist_cingulate_24apL] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_cingulate_24apL),'type','Spearman');
[rho.MWMdist_cingulate_24apR,pval.MWMdist_cingulate_24apR] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_cingulate_24apR),'type','Spearman');
[rho.MWMdist_cingulate_24aR,pval.MWMdist_cingulate_24aR] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_cingulate_24aR),'type','Spearman');
[rho.MWMdist_cingulate_24bL,pval.MWMdist_cingulate_24bL] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_cingulate_24bL),'type','Spearman');
[rho.MWMdist_cingulate_24bpL,pval.MWMdist_cingulate_24bpL] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_cingulate_24bpL),'type','Spearman');
[rho.MWMdist_cingulate_24bpR,pval.MWMdist_cingulate_24bpR] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_cingulate_24bpR),'type','Spearman');
[rho.MWMdist_cingulate_24bR,pval.MWMdist_cingulate_24bR] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_cingulate_24bR),'type','Spearman');
[rho.MWMdist_cingulate_25L,pval.MWMdist_cingulate_25L] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_cingulate_25L),'type','Spearman');
[rho.MWMdist_cingulate_25R,pval.MWMdist_cingulate_25R] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_cingulate_25R),'type','Spearman');
[rho.MWMdist_cingulate_29aL,pval.MWMdist_cingulate_29aL] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_cingulate_29aL),'type','Spearman');
[rho.MWMdist_cingulate_29aR,pval.MWMdist_cingulate_29aR] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_cingulate_29aR),'type','Spearman');
[rho.MWMdist_cingulate_29bL,pval.MWMdist_cingulate_29bL] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_cingulate_29bL),'type','Spearman');
[rho.MWMdist_cingulate_29bR,pval.MWMdist_cingulate_29bR] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_cingulate_29bR),'type','Spearman');
[rho.MWMdist_cingulate_29cL,pval.MWMdist_cingulate_29cL] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_cingulate_29cL),'type','Spearman');
[rho.MWMdist_cingulate_29cR,pval.MWMdist_cingulate_29cR] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_cingulate_29cR),'type','Spearman');
[rho.MWMdist_cingulate_30L,pval.MWMdist_cingulate_30L] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_cingulate_30L),'type','Spearman');
[rho.MWMdist_cingulate_30R,pval.MWMdist_cingulate_30R] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_cingulate_30R),'type','Spearman');
[rho.MWMdist_cingulate_32L,pval.MWMdist_cingulate_32L] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_cingulate_32L),'type','Spearman');
[rho.MWMdist_cingulate_32R,pval.MWMdist_cingulate_32R] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_cingulate_32R),'type','Spearman');
[rho.MWMdist_entorhinalL_caudomedial,pval.MWMdist_entorhinalL_caudomedial] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_entorhinalL_caudomedial),'type','Spearman');
[rho.MWMdist_entorhinalL_dorsalintermediate,pval.MWMdist_entorhinalL_dorsalintermediate] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_entorhinalL_dorsalintermediate),'type','Spearman');
[rho.MWMdist_entorhinalL_dorsolateral,pval.MWMdist_entorhinalL_dorsolateral] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_entorhinalL_dorsolateral),'type','Spearman');
[rho.MWMdist_entorhinalL_medial,pval.MWMdist_entorhinalL_medial] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_entorhinalL_medial),'type','Spearman');
[rho.MWMdist_entorhinalL_ventralintermediate,pval.MWMdist_entorhinalL_ventralintermediate] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_entorhinalL_ventralintermediate),'type','Spearman');
[rho.MWMdist_entorhinalR_caudomedial,pval.MWMdist_entorhinalR_caudomedial] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_entorhinalR_caudomedial),'type','Spearman');
[rho.MWMdist_entorhinalR_dorsalintermediate,pval.MWMdist_entorhinalR_dorsalintermediate] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_entorhinalR_dorsalintermediate),'type','Spearman');
[rho.MWMdist_entorhinalR_dorsolateral,pval.MWMdist_entorhinalR_dorsolateral] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_entorhinalR_dorsolateral),'type','Spearman');
[rho.MWMdist_entorhinalR_medial,pval.MWMdist_entorhinalR_medial] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_entorhinalR_medial),'type','Spearman');
[rho.MWMdist_entorhinalR_ventralintermediate,pval.MWMdist_entorhinalR_ventralintermediate] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_entorhinalR_ventralintermediate),'type','Spearman');
[rho.MWMdist_fimbriaL,pval.MWMdist_fimbriaL] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_fimbriaL),'type','Spearman');
[rho.MWMdist_fimbriaR,pval.MWMdist_fimbriaR] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_fimbriaR),'type','Spearman');
[rho.MWMdist_fornixL,pval.MWMdist_fornixL] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_fornixL),'type','Spearman');
[rho.MWMdist_fornixR,pval.MWMdist_fornixR] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_fornixR),'type','Spearman');
[rho.MWMdist_hippocampusL,pval.MWMdist_hippocampusL] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_hippocampusL),'type','Spearman');
[rho.MWMdist_hippocampusR,pval.MWMdist_hippocampusR] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_hippocampusR),'type','Spearman');
[rho.MWMdist_temporalassnL,pval.MWMdist_temporalassnL] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_temporalassnL),'type','Spearman');
[rho.MWMdist_temporalassnR,pval.MWMdist_temporalassnR] = corr(table2array(MWM_swimdist(:,5:end)),table2array(netprops_temporalassnR),'type','Spearman');

%MWMtime vs netprops
[rho.MWMtime_NetpropRunno,pval.MWMtime_NetpropRunno] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprop_runno_data(:,2:end)),'type','Spearman');
[rho.MWMtime_amygdalaL,pval.MWMtime_amygdalaL] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_amygdalaL),'type','Spearman');
[rho.MWMtime_amygdalaR,pval.MWMtime_amygdalaR] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_amygdalaR),'type','Spearman');
[rho.MWMtime_cingulate_24aL,pval.MWMtime_cingulate_24aL] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_cingulate_24aL),'type','Spearman');
[rho.MWMtime_cingulate_24apL,pval.MWMtime_cingulate_24apL] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_cingulate_24apL),'type','Spearman');
[rho.MWMtime_cingulate_24apR,pval.MWMtime_cingulate_24apR] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_cingulate_24apR),'type','Spearman');
[rho.MWMtime_cingulate_24aR,pval.MWMtime_cingulate_24aR] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_cingulate_24aR),'type','Spearman');
[rho.MWMtime_cingulate_24bL,pval.MWMtime_cingulate_24bL] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_cingulate_24bL),'type','Spearman');
[rho.MWMtime_cingulate_24bpL,pval.MWMtime_cingulate_24bpL] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_cingulate_24bpL),'type','Spearman');
[rho.MWMtime_cingulate_24bpR,pval.MWMtime_cingulate_24bpR] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_cingulate_24bpR),'type','Spearman');
[rho.MWMtime_cingulate_24bR,pval.MWMtime_cingulate_24bR] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_cingulate_24bR),'type','Spearman');
[rho.MWMtime_cingulate_25L,pval.MWMtime_cingulate_25L] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_cingulate_25L),'type','Spearman');
[rho.MWMtime_cingulate_25R,pval.MWMtime_cingulate_25R] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_cingulate_25R),'type','Spearman');
[rho.MWMtime_cingulate_29aL,pval.MWMtime_cingulate_29aL] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_cingulate_29aL),'type','Spearman');
[rho.MWMtime_cingulate_29aR,pval.MWMtime_cingulate_29aR] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_cingulate_29aR),'type','Spearman');
[rho.MWMtime_cingulate_29bL,pval.MWMtime_cingulate_29bL] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_cingulate_29bL),'type','Spearman');
[rho.MWMtime_cingulate_29bR,pval.MWMtime_cingulate_29bR] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_cingulate_29bR),'type','Spearman');
[rho.MWMtime_cingulate_29cL,pval.MWMtime_cingulate_29cL] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_cingulate_29cL),'type','Spearman');
[rho.MWMtime_cingulate_29cR,pval.MWMtime_cingulate_29cR] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_cingulate_29cR),'type','Spearman');
[rho.MWMtime_cingulate_30L,pval.MWMtime_cingulate_30L] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_cingulate_30L),'type','Spearman');
[rho.MWMtime_cingulate_30R,pval.MWMtime_cingulate_30R] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_cingulate_30R),'type','Spearman');
[rho.MWMtime_cingulate_32L,pval.MWMtime_cingulate_32L] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_cingulate_32L),'type','Spearman');
[rho.MWMtime_cingulate_32R,pval.MWMtime_cingulate_32R] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_cingulate_32R),'type','Spearman');
[rho.MWMtime_entorhinalL_caudomedial,pval.MWMtime_entorhinalL_caudomedial] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_entorhinalL_caudomedial),'type','Spearman');
[rho.MWMtime_entorhinalL_dorsalintermediate,pval.MWMtime_entorhinalL_dorsalintermediate] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_entorhinalL_dorsalintermediate),'type','Spearman');
[rho.MWMtime_entorhinalL_dorsolateral,pval.MWMtime_entorhinalL_dorsolateral] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_entorhinalL_dorsolateral),'type','Spearman');
[rho.MWMtime_entorhinalL_medial,pval.MWMtime_entorhinalL_medial] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_entorhinalL_medial),'type','Spearman');
[rho.MWMtime_entorhinalL_ventralintermediate,pval.MWMtime_entorhinalL_ventralintermediate] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_entorhinalL_ventralintermediate),'type','Spearman');
[rho.MWMtime_entorhinalR_caudomedial,pval.MWMtime_entorhinalR_caudomedial] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_entorhinalR_caudomedial),'type','Spearman');
[rho.MWMtime_entorhinalR_dorsalintermediate,pval.MWMtime_entorhinalR_dorsalintermediate] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_entorhinalR_dorsalintermediate),'type','Spearman');
[rho.MWMtime_entorhinalR_dorsolateral,pval.MWMtime_entorhinalR_dorsolateral] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_entorhinalR_dorsolateral),'type','Spearman');
[rho.MWMtime_entorhinalR_medial,pval.MWMtime_entorhinalR_medial] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_entorhinalR_medial),'type','Spearman');
[rho.MWMtime_entorhinalR_ventralintermediate,pval.MWMtime_entorhinalR_ventralintermediate] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_entorhinalR_ventralintermediate),'type','Spearman');
[rho.MWMtime_fimbriaL,pval.MWMtime_fimbriaL] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_fimbriaL),'type','Spearman');
[rho.MWMtime_fimbriaR,pval.MWMtime_fimbriaR] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_fimbriaR),'type','Spearman');
[rho.MWMtime_fornixL,pval.MWMtime_fornixL] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_fornixL),'type','Spearman');
[rho.MWMtime_fornixR,pval.MWMtime_fornixR] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_fornixR),'type','Spearman');
[rho.MWMtime_hippocampusL,pval.MWMtime_hippocampusL] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_hippocampusL),'type','Spearman');
[rho.MWMtime_hippocampusR,pval.MWMtime_hippocampusR] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_hippocampusR),'type','Spearman');
[rho.MWMtime_temporalassnL,pval.MWMtime_temporalassnL] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_temporalassnL),'type','Spearman');
[rho.MWMtime_temporalassnR,pval.MWMtime_temporalassnR] = corr(table2array(MWM_swimtime(:,5:end)),table2array(netprops_temporalassnR),'type','Spearman');

% NOR vs netprops
[rho.NOR_NetpropRunno,pval.NOR_NetpropRunno] = corr(table2array(NOR_data(:,5:end)),table2array(netprop_runno_data(:,2:end)),'type','Spearman');
[rho.NOR_amygdalaL,pval.NOR_amygdalaL] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_amygdalaL),'type','Spearman');
[rho.NOR_amygdalaR,pval.NOR_amygdalaR] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_amygdalaR),'type','Spearman');
[rho.NOR_cingulate_24aL,pval.NOR_cingulate_24aL] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_cingulate_24aL),'type','Spearman');
[rho.NOR_cingulate_24apL,pval.NOR_cingulate_24apL] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_cingulate_24apL),'type','Spearman');
[rho.NOR_cingulate_24apR,pval.NOR_cingulate_24apR] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_cingulate_24apR),'type','Spearman');
[rho.NOR_cingulate_24aR,pval.NOR_cingulate_24aR] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_cingulate_24aR),'type','Spearman');
[rho.NOR_cingulate_24bL,pval.NOR_cingulate_24bL] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_cingulate_24bL),'type','Spearman');
[rho.NOR_cingulate_24bpL,pval.NOR_cingulate_24bpL] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_cingulate_24bpL),'type','Spearman');
[rho.NOR_cingulate_24bpR,pval.NOR_cingulate_24bpR] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_cingulate_24bpR),'type','Spearman');
[rho.NOR_cingulate_24bR,pval.NOR_cingulate_24bR] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_cingulate_24bR),'type','Spearman');
[rho.NOR_cingulate_25L,pval.NOR_cingulate_25L] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_cingulate_25L),'type','Spearman');
[rho.NOR_cingulate_25R,pval.NOR_cingulate_25R] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_cingulate_25R),'type','Spearman');
[rho.NOR_cingulate_29aL,pval.NOR_cingulate_29aL] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_cingulate_29aL),'type','Spearman');
[rho.NOR_cingulate_29aR,pval.NOR_cingulate_29aR] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_cingulate_29aR),'type','Spearman');
[rho.NOR_cingulate_29bL,pval.NOR_cingulate_29bL] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_cingulate_29bL),'type','Spearman');
[rho.NOR_cingulate_29bR,pval.NOR_cingulate_29bR] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_cingulate_29bR),'type','Spearman');
[rho.NOR_cingulate_29cL,pval.NOR_cingulate_29cL] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_cingulate_29cL),'type','Spearman');
[rho.NOR_cingulate_29cR,pval.NOR_cingulate_29cR] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_cingulate_29cR),'type','Spearman');
[rho.NOR_cingulate_30L,pval.NOR_cingulate_30L] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_cingulate_30L),'type','Spearman');
[rho.NOR_cingulate_30R,pval.NOR_cingulate_30R] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_cingulate_30R),'type','Spearman');
[rho.NOR_cingulate_32L,pval.NOR_cingulate_32L] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_cingulate_32L),'type','Spearman');
[rho.NOR_cingulate_32R,pval.NOR_cingulate_32R] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_cingulate_32R),'type','Spearman');
[rho.NOR_entorhinalL_caudomedial,pval.NOR_entorhinalL_caudomedial] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_entorhinalL_caudomedial),'type','Spearman');
[rho.NOR_entorhinalL_dorsalintermediate,pval.NOR_entorhinalL_dorsalintermediate] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_entorhinalL_dorsalintermediate),'type','Spearman');
[rho.NOR_entorhinalL_dorsolateral,pval.NOR_entorhinalL_dorsolateral] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_entorhinalL_dorsolateral),'type','Spearman');
[rho.NOR_entorhinalL_medial,pval.NOR_entorhinalL_medial] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_entorhinalL_medial),'type','Spearman');
[rho.NOR_entorhinalL_ventralintermediate,pval.NOR_entorhinalL_ventralintermediate] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_entorhinalL_ventralintermediate),'type','Spearman');
[rho.NOR_entorhinalR_caudomedial,pval.NOR_entorhinalR_caudomedial] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_entorhinalR_caudomedial),'type','Spearman');
[rho.NOR_entorhinalR_dorsalintermediate,pval.NOR_entorhinalR_dorsalintermediate] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_entorhinalR_dorsalintermediate),'type','Spearman');
[rho.NOR_entorhinalR_dorsolateral,pval.NOR_entorhinalR_dorsolateral] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_entorhinalR_dorsolateral),'type','Spearman');
[rho.NOR_entorhinalR_medial,pval.NOR_entorhinalR_medial] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_entorhinalR_medial),'type','Spearman');
[rho.NOR_entorhinalR_ventralintermediate,pval.NOR_entorhinalR_ventralintermediate] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_entorhinalR_ventralintermediate),'type','Spearman');
[rho.NOR_fimbriaL,pval.NOR_fimbriaL] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_fimbriaL),'type','Spearman');
[rho.NOR_fimbriaR,pval.NOR_fimbriaR] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_fimbriaR),'type','Spearman');
[rho.NOR_fornixL,pval.NOR_fornixL] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_fornixL),'type','Spearman');
[rho.NOR_fornixR,pval.NOR_fornixR] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_fornixR),'type','Spearman');
[rho.NOR_hippocampusL,pval.NOR_hippocampusL] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_hippocampusL),'type','Spearman');
[rho.NOR_hippocampusR,pval.NOR_hippocampusR] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_hippocampusR),'type','Spearman');
[rho.NOR_temporalassnL,pval.NOR_temporalassnL] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_temporalassnL),'type','Spearman');
[rho.NOR_temporalassnR,pval.NOR_temporalassnR] = corr(table2array(NOR_data(:,5:end)),table2array(netprops_temporalassnR),'type','Spearman');

fieldname = fieldnames(rho);
sig_comp = table;

for i=1:numel(fieldname)
    % matrix mask for significant p-values
    sig = pval.(fieldname{i}) < 0.05;
    [row_mat,column_mat] = find(sig);
    % replace rows and columns with variable numbers
    row_var = strings(numel(row_mat),1);
    column_var = strings(numel(column_mat),1);
    for j=1:numel(row_mat)
        if contains(fieldname(i),'MWMdist')
            row_var(j) = labels_MWMdist(row_mat(j));
        elseif contains(fieldname(i),'MWMtime')
            row_var(j) = labels_MWMtime(row_mat(j));
        elseif contains(fieldname(i),'MWMspd')
            row_var(j) = labels_MWMspd(row_mat(j));
        elseif contains(fieldname(i),'NOR')
            row_var(j) = labels_NOR(row_mat(j));
        end
        
        if contains(fieldname{i},'NetpropRunno')
            column_var(j) = labels_netprop_runno(column_mat(j));
        else
            column_var(j) = labels_netprop_roi(column_mat(j));
        end
    end
    rho_mat = rho.(fieldname{i})(sig);
    pval_mat = pval.(fieldname{i})(sig);
    name_mat = repelem(fieldname(i),numel(rho_mat))';
    sig_comp = vertcat(sig_comp,table(name_mat,row_var,column_var,rho_mat,pval_mat,'VariableNames',{'comparison','behav_var','image_var','rho','p'}));
end

writetable(sig_comp,'analyzed_data/exvivoSignificance.csv');

hsigs = zeros;

for i=1:numel(fieldname)
    [h, crit_p, adj_ci_cvrg, adj_p]=fdr_bh(pval.(fieldname{i}));
    fieldname{i}
    h
end



%false discovery
% focus is entorhinal, amygdala, cingulate, hippocampus, temporal assn

% 2 group ttest between E3vsE4 for significant values
    % look at hippocampus

% 1mil seeds
% MWMtime_temporalassnL (2,1)

%% plots and stuff

gTypePlots = table2array(MWM_swimtime(:,2));
NumericalMWMswimtimeData = table2array(MWM_swimtime(:,5:9));

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
title('Morris Water Maze Swim Time by Genotype')
xlabel('Trial Number')
ylabel('Swim Time (s)')
set(gca, 'XTickLabel', {'1', '2', '3', '5', '6', '1', '2', '3', '5',...
    '6', '1', '2', '3', '5', '6'})


%% Swim Distance
gTypePlots = table2array(MWM_swimdist(:,2));
NumericalMWMswimdistData = table2array(MWM_swimdist(:,5:9));

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
title('Morris Water Maze Swim Distance by Genotype')
xlabel('Trial Number')
ylabel('Swim Distance (cm)')
set(gca, 'XTickLabel', {'1', '2', '3', '5', '6', '1', '2', '3', '5',...
    '6', '1', '2', '3', '5', '6'})


%% NOR

gTypePlots = table2array(NOR_data(:,2));
NumericalNORData = table2array(NOR_data(:,5:end));

APOE3Indices = strcmp(gTypePlots, 'APOE3');
C57Indices = strcmp(gTypePlots, 'C57');
APOE4Indices = strcmp(gTypePlots, 'APOE4');
APOE4X = repmat((1:3), sum(APOE4Indices), 1);
APOE3X = repmat((1:3), sum(APOE3Indices), 1);
C57X = repmat((1:3), sum(C57Indices), 1);

APOE4Y = NumericalNORData(APOE4Indices,:);
APOE3Y = NumericalNORData(APOE3Indices,:);
C57Y = NumericalNORData(C57Indices,:);

APOE4Groups = cellstr([repmat('APOE4 Trial #', numel(APOE4X), 1) num2str(APOE4X(:))]);
APOE3Groups = cellstr([repmat('APOE3 Trial #', numel(APOE3X), 1) num2str(APOE3X(:))]);
C57Groups = cellstr([repmat('C57 Trial #', numel(C57X), 1) num2str(C57X(:))]);

% APOE4Groups = APOE4X(:);
% APOE3Groups = APOE3X(:);
% C57Groups = C57X(:);

CombinedNORMat = [APOE4Y(:); APOE3Y(:); C57Y(:)];
CombinedNORMatGroupings = [APOE4Groups(:); APOE3Groups(:); C57Groups(:)];

figure(figNum)
clf(figNum)
figNum = figNum+1;
hold on

plot(NaN, NaN, 'rs', 'MarkerFaceColor', 'r');
plot(NaN, NaN, 'gs', 'MarkerFaceColor', 'g');
plot(NaN, NaN, 'bs', 'MarkerFaceColor', 'b');

groupOrder = {'APOE4 Trial #1'; 'APOE3 Trial #1'; 'C57 Trial #1';
    'APOE4 Trial #2'; 'APOE3 Trial #2'; 'C57 Trial #2';
    'APOE4 Trial #3'; 'APOE3 Trial #3'; 'C57 Trial #3'};
colorGroup = [1, 1, 1, 2, 2, 2, 3, 3, 3];
boxplot(CombinedNORMat, CombinedNORMatGroupings, 'GroupOrder', groupOrder, ...
    'ColorGroup', colorGroup);


hold off
grid on
legend({'APOE4', 'APOE3', 'C57'})
title('Novel Object Recognition by Genotype')
xlabel('Trial Number')
ylabel('Recognition Index')
set(gca, 'XTickLabel', {'1', '1', '1', '2', '2', '2', '3', '3', '3', })

% MWMtime_temporalassnL (2,1)
%% corrplot stuff
a = [MWM_swimtime(:,5:end) netprops_temporalassnL];

figure(figNum)
clf(figNum)
figNum = figNum+1;
corrplot(a,'type','Spearman','testR','on')


%% Correlation

MWMswimTimeCol2 = table2array(MWM_swimtime(:,6));
temporalassnLCol1 = table2array(netprops_temporalassnL(:,1));


[p, S] = polyfit(temporalassnLCol1(:), MWMswimTimeCol2(:), 1);
xfit = 40:5:360;
[Y, Delta] = polyconf(p, xfit, S);

figure(figNum)
clf(figNum)
figNum = figNum+1;
hold on


plot(temporalassnLCol1, MWMswimTimeCol2, 'kx', 'MarkerSize', 3);
alpha(0.4)
plot(xfit, polyval(p, xfit), 'r-')

fill([xfit, xfit(end:-1:1)], [Y+Delta, Y(end:-1:1)-Delta(end:-1:1)], [0.2 0.25 0.25], ...
    'EdgeColor', 'none', 'FaceAlpha', 0.1)

hold off
grid on
%legend({'APOE4', 'APOE3', 'C57'})
title('Swim Time (T2) vs Left Temporal Association Cortex Degree(Binary) (95% Confidence Interval)')
xlabel('Degree(Binary)')
ylabel('Time (s)')
xlim([50 350])

Rsq1 = 1 - sum((MWMswimTimeCol2 - polyval(p, temporalassnLCol1)).^2)./ ...
    sum((MWMswimTimeCol2 - mean(MWMswimTimeCol2)).^2);

rsqText = strcat('R^2 = ', num2str(Rsq1));
text(225, 3, rsqText);

%% Correlation without outlier

MWMswimTimeCol2 = table2array(MWM_swimtime(:,6));
temporalassnLCol1 = table2array(netprops_temporalassnL(:,1));

MWMswimTimeCol2(8) =  [];
temporalassnLCol1(8) =  [];

[p, S] = polyfit(temporalassnLCol1(:), MWMswimTimeCol2(:), 1);
xfit = 40:5:360;
[Y, Delta] = polyconf(p, xfit, S);

figure(figNum)
clf(figNum)
figNum = figNum+1;
hold on


plot(temporalassnLCol1, MWMswimTimeCol2, 'kx', 'MarkerSize', 3);
alpha(0.4)
plot(xfit, polyval(p, xfit), 'r-')

fill([xfit, xfit(end:-1:1)], [Y+Delta, Y(end:-1:1)-Delta(end:-1:1)], [0.2 0.25 0.25], ...
    'EdgeColor', 'none', 'FaceAlpha', 0.1)

hold off
grid on
%legend({'APOE4', 'APOE3', 'C57'})
title('Swim Time (T2) vs Left Temporal Association Cortex Degree(Binary) (95% Confidence Interval)')
xlabel('Degree(Binary)')
ylabel('Time (s)')
xlim([275 350])

Rsq1 = 1 - sum((MWMswimTimeCol2 - polyval(p, temporalassnLCol1)).^2)./ ...
    sum((MWMswimTimeCol2 - mean(MWMswimTimeCol2)).^2);

rsqText = strcat('R^2 = ', num2str(Rsq1));
text(325, 3, rsqText);


%% new appendix v boxplots

% import the legend
roi_legend = readtable('connectome_data/CHASSSYMMETRIC2Legends09072017.xlsx');
genotype_correspond = readtable('corresponding_runnos_boxplots.xlsx');

%create indices for specific groupings
genotypes = table2array(genotype_correspond(:,5));
C57youngIndices = strcmp(genotypes, 'C57young');
C57oldIndices = strcmp(genotypes, 'C57old');
APOE3Indices = strcmp(genotypes, 'APOE3');
APOE4Indices = strcmp(genotypes, 'APOE4');

figNum = 1;

% netprop_roi_data is organized as such: (roi,runno(in order),measure)
% for roi=1:332
for roi=70:332
    % pull out roi data
    plotROI = permute(netprop_roi_data(roi,:,:), [2 3 1]);
    % pull out roi name
    ROIname = [strrep(char(roi_legend{roi,1}), '_', ' ') ' (' char(roi_legend{roi,3}) ')'];
    for measure=1:14
        % pull out measure name
        measureName = strrep(char(labels_netprop_roi(measure)), '_', ' ');
        % pull out measure data
        measureData = plotROI(:,measure);
        % organize measure data by group
        C57youngY = measureData(C57youngIndices,:);
        C57oldY = measureData(C57oldIndices,:);
        APOE3Y = measureData(APOE3Indices,:);
        APOE4Y = measureData(APOE4Indices,:);
        
        CombinedData = {C57youngY; C57oldY; APOE3Y; APOE4Y};

        % plot data
        h=figure(figNum)
        clf(figNum)
%         figNum = figNum+1;
        set (h, 'Visible', 'off')
        hold on

        aboxplot(CombinedData);

        hold off
        grid on
        legend({'C57 young', 'C57 old', 'APOE3', 'APOE4'})
        xlabel(ROIname)
        ylabel(measureName)
        set(gca, 'XTickLabel', {' '})
        
        saveas(h,['figures/' ROIname '_' measureName '.png'])
        
    end
end







