%% import behavioral data
MWM_swimtime = readtable('analyzed_data/MWM_swimtime_corr.csv');
MWM_swimtime([10 11 12 13 14 15 16 17 18 19 26 27 28 29 30 31 32 33 34 35 39],:) = [];
MWM_swimdist = readtable('analyzed_data/MWM_swimdist_corr.csv');
MWM_swimdist([10 11 12 13 14 15 16 17 18 19 26 27 28 29 30 31 32 33 34 35 39],:) = [];
NOR_data = readtable('analyzed_data/NOR_analyzed.csv');
NOR_data([10 11 12 13 14 15 16 17 18 19 26 27 28 29 30 31 32 33 34 35 39],:) = [];

labels_MWMtime = {'swimtime_t1','swimtime_t2','swimtime_t3','swimtime_t5','swimtime_t6'};
labels_MWMdist = {'swimdist_t1','swimdist_t2','swimdist_t3','swimdist_t5','swimdist_t6'};
labels_NOR = {'LP','RI_T2','RI_T3'};

%% in vivo chassymetric data

% invivo_runnos = {'B05290','B05285','B05265','B05270','B05275', 'B05280','B05295','B05300','B05305','B05250','B05255','B05310','B05320','B05325','B05330','B05335','B05315','B05340','B05345','B05350','B05355','B05360','B05365','B05370','B05375','B05380','B05385','B05390','B05400','B05435','B05440','B05445','B05450','B05455','B05460','B05465','B05470','B05475','B05480','B05405','B05410','B05425','B05430'};
invivo_runnos = {'B05290','B05285','B05265','B05270','B05275', 'B05280','B05295','B05300','B05305','B05370','B05375','B05380','B05385','B05390','B05400','B05405','B05410','B05425'};

invivo_data = double.empty(0,0,0);

for j=1:numel(invivo_runnos) 
    % import values from netprop text files
    invivo_raw = importdata(['connectome_data/InVivoStats/' char(invivo_runnos{j}) '_chass_symmetric2_labels_in_native_space_stats.txt'],'');

    % values for individual roi's
    roi_vals_temp = double.empty(0,0);
    for k=7:334
       roi_split = split(invivo_raw{k});
       roi_vals_temp = [roi_vals_temp, roi_split(2:7)];
    end
    % convert split string arrays to double
    roi_vals_temp = str2double(roi_vals_temp);
    invivo_data(:,j,:) = roi_vals_temp;
    % invivo_data is organized as such: (measure,runno(in order),roi)
end

labels_invivo = {'voxels','volume','T2','T1','T2star','X'};

invivo_hippocampusR = array2table(permute(invivo_data(:,:,51), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos); 
invivo_entorhinalR_caudomedial = array2table(permute(invivo_data(:,:,42), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos);
invivo_entorhinalR_dorsalintermediate = array2table(permute(invivo_data(:,:,43), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos); 
invivo_entorhinalR_dorsolateral = array2table(permute(invivo_data(:,:,44), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos);
invivo_entorhinalR_medial = array2table(permute(invivo_data(:,:,45), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos); 
invivo_entorhinalR_ventralintermediate = array2table(permute(invivo_data(:,:,46), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos);
invivo_amygdalaR = array2table(permute(invivo_data(:,:,65), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos); 
invivo_temporalassnR = array2table(permute(invivo_data(:,:,34), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos);
invivo_fimbriaR = array2table(permute(invivo_data(:,:,120), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos); 
invivo_fornixR = array2table(permute(invivo_data(:,:,122), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos);
invivo_cingulate_24aR = array2table(permute(invivo_data(:,:,1), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos); 
invivo_cingulate_24apR = array2table(permute(invivo_data(:,:,2), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos);
invivo_cingulate_24bR = array2table(permute(invivo_data(:,:,3), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos); 
invivo_cingulate_24bpR = array2table(permute(invivo_data(:,:,4), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos);
invivo_cingulate_29aR = array2table(permute(invivo_data(:,:,5), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos); 
invivo_cingulate_29bR = array2table(permute(invivo_data(:,:,6), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos);
invivo_cingulate_29cR = array2table(permute(invivo_data(:,:,7), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos); 
invivo_cingulate_30R = array2table(permute(invivo_data(:,:,8), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos);
invivo_cingulate_32R = array2table(permute(invivo_data(:,:,9), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos); 
invivo_cingulate_25R = array2table(permute(invivo_data(:,:,149), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos);

invivo_hippocampusL = array2table(permute(invivo_data(:,:,217), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos); 
invivo_entorhinalL_caudomedial = array2table(permute(invivo_data(:,:,208), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos);
invivo_entorhinalL_dorsalintermediate = array2table(permute(invivo_data(:,:,209), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos); 
invivo_entorhinalL_dorsolateral = array2table(permute(invivo_data(:,:,210), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos);
invivo_entorhinalL_medial = array2table(permute(invivo_data(:,:,211), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos); 
invivo_entorhinalL_ventralintermediate = array2table(permute(invivo_data(:,:,212), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos);
invivo_amygdalaL = array2table(permute(invivo_data(:,:,231), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos); 
invivo_temporalassnL = array2table(permute(invivo_data(:,:,200), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos);
invivo_fimbriaL = array2table(permute(invivo_data(:,:,286), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos); 
invivo_fornixL = array2table(permute(invivo_data(:,:,288), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos);
invivo_cingulate_24aL = array2table(permute(invivo_data(:,:,167), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos); 
invivo_cingulate_24apL = array2table(permute(invivo_data(:,:,168), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos);
invivo_cingulate_24bL = array2table(permute(invivo_data(:,:,169), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos); 
invivo_cingulate_24bpL = array2table(permute(invivo_data(:,:,170), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos);
invivo_cingulate_29aL = array2table(permute(invivo_data(:,:,171), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos); 
invivo_cingulate_29bL = array2table(permute(invivo_data(:,:,172), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos);
invivo_cingulate_29cL = array2table(permute(invivo_data(:,:,173), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos); 
invivo_cingulate_30L = array2table(permute(invivo_data(:,:,174), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos);
invivo_cingulate_32L = array2table(permute(invivo_data(:,:,175), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos); 
invivo_cingulate_25L = array2table(permute(invivo_data(:,:,315), [2 1 3]),'VariableNames',labels_invivo,'RowNames',invivo_runnos);

%% explore correlations for invivo

%MWM distance vs invivo
[rho.MWMdist_amygdalaL,pval.MWMdist_amygdalaL] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_amygdalaL),'type','Spearman');
[rho.MWMdist_amygdalaR,pval.MWMdist_amygdalaR] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_amygdalaR),'type','Spearman');
[rho.MWMdist_cingulate_25aL,pval.MWMdist_cingulate_25aL] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_cingulate_24aL),'type','Spearman');
[rho.MWMdist_cingulate_24apL,pval.MWMdist_cingulate_24apL] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_cingulate_24apL),'type','Spearman');
[rho.MWMdist_cingulate_24apR,pval.MWMdist_cingulate_24apR] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_cingulate_24apR),'type','Spearman');
[rho.MWMdist_cingulate_24aR,pval.MWMdist_cingulate_24aR] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_cingulate_24aR),'type','Spearman');
[rho.MWMdist_cingulate_24bL,pval.MWMdist_cingulate_24bL] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_cingulate_24bL),'type','Spearman');
[rho.MWMdist_cingulate_24bpL,pval.MWMdist_cingulate_24bpL] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_cingulate_24bpL),'type','Spearman');
[rho.MWMdist_cingulate_24bpR,pval.MWMdist_cingulate_24bpR] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_cingulate_24bpR),'type','Spearman');
[rho.MWMdist_cingulate_24bR,pval.MWMdist_cingulate_24bR] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_cingulate_24bR),'type','Spearman');
[rho.MWMdist_cingulate_25L,pval.MWMdist_cingulate_25L] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_cingulate_25L),'type','Spearman');
[rho.MWMdist_cingulate_25R,pval.MWMdist_cingulate_25R] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_cingulate_25R),'type','Spearman');
[rho.MWMdist_cingulate_29aL,pval.MWMdist_cingulate_29aL] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_cingulate_29aL),'type','Spearman');
[rho.MWMdist_cingulate_29aR,pval.MWMdist_cingulate_29aR] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_cingulate_29aR),'type','Spearman');
[rho.MWMdist_cingulate_29bL,pval.MWMdist_cingulate_29bL] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_cingulate_29bL),'type','Spearman');
[rho.MWMdist_cingulate_29bR,pval.MWMdist_cingulate_29bR] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_cingulate_29bR),'type','Spearman');
[rho.MWMdist_cingulate_29cL,pval.MWMdist_cingulate_29cL] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_cingulate_29cL),'type','Spearman');
[rho.MWMdist_cingulate_29cR,pval.MWMdist_cingulate_29cR] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_cingulate_29cR),'type','Spearman');
[rho.MWMdist_cingulate_30L,pval.MWMdist_cingulate_30L] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_cingulate_30L),'type','Spearman');
[rho.MWMdist_cingulate_30R,pval.MWMdist_cingulate_30R] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_cingulate_30R),'type','Spearman');
[rho.MWMdist_cingulate_32L,pval.MWMdist_cingulate_32L] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_cingulate_32L),'type','Spearman');
[rho.MWMdist_cingulate_32R,pval.MWMdist_cingulate_32R] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_cingulate_32R),'type','Spearman');
[rho.MWMdist_entorhinalL_caudomedial,pval.MWMdist_entorhinalL_caudomedial] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_entorhinalL_caudomedial),'type','Spearman');
[rho.MWMdist_entorhinalL_dorsalintermediate,pval.MWMdist_entorhinalL_dorsalintermediate] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_entorhinalL_dorsalintermediate),'type','Spearman');
[rho.MWMdist_entorhinalL_dorsolateral,pval.MWMdist_entorhinalL_dorsolateral] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_entorhinalL_dorsolateral),'type','Spearman');
[rho.MWMdist_entorhinalL_medial,pval.MWMdist_entorhinalL_medial] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_entorhinalL_medial),'type','Spearman');
[rho.MWMdist_entorhinalL_ventralintermediate,pval.MWMdist_entorhinalL_ventralintermediate] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_entorhinalL_ventralintermediate),'type','Spearman');
[rho.MWMdist_entorhinalR_caudomedial,pval.MWMdist_entorhinalR_caudomedial] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_entorhinalR_caudomedial),'type','Spearman');
[rho.MWMdist_entorhinalR_dorsalintermediate,pval.MWMdist_entorhinalR_dorsalintermediate] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_entorhinalR_dorsalintermediate),'type','Spearman');
[rho.MWMdist_entorhinalR_dorsolateral,pval.MWMdist_entorhinalR_dorsolateral] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_entorhinalR_dorsolateral),'type','Spearman');
[rho.MWMdist_entorhinalR_medial,pval.MWMdist_entorhinalR_medial] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_entorhinalR_medial),'type','Spearman');
[rho.MWMdist_entorhinalR_ventralintermediate,pval.MWMdist_entorhinalR_ventralintermediate] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_entorhinalR_ventralintermediate),'type','Spearman');
[rho.MWMdist_fimbriaL,pval.MWMdist_fimbriaL] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_fimbriaL),'type','Spearman');
[rho.MWMdist_fimbriaR,pval.MWMdist_fimbriaR] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_fimbriaR),'type','Spearman');
[rho.MWMdist_fornixL,pval.MWMdist_fornixL] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_fornixL),'type','Spearman');
[rho.MWMdist_fornixR,pval.MWMdist_fornixR] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_fornixR),'type','Spearman');
[rho.MWMdist_hippocampusL,pval.MWMdist_hippocampusL] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_hippocampusL),'type','Spearman');
[rho.MWMdist_hippocampusR,pval.MWMdist_hippocampusR] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_hippocampusR),'type','Spearman');
[rho.MWMdist_temporalassnL,pval.MWMdist_temporalassnL] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_temporalassnL),'type','Spearman');
[rho.MWMdist_temporalassnR,pval.MWMdist_temporalassnR] = corr(table2array(MWM_swimdist(:,5:end)),table2array(invivo_temporalassnR),'type','Spearman');

%MWMtime vs invivo
[rho.MWMtime_amygdalaL,pval.MWMtime_amygdalaL] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_amygdalaL),'type','Spearman');
[rho.MWMtime_amygdalaR,pval.MWMtime_amygdalaR] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_amygdalaR),'type','Spearman');
[rho.MWMtime_cingulate_24aL,pval.MWMtime_cingulate_24aL] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_cingulate_24aL),'type','Spearman');
[rho.MWMtime_cingulate_24apL,pval.MWMtime_cingulate_24apL] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_cingulate_24apL),'type','Spearman');
[rho.MWMtime_cingulate_24apR,pval.MWMtime_cingulate_24apR] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_cingulate_24apR),'type','Spearman');
[rho.MWMtime_cingulate_24aR,pval.MWMtime_cingulate_24aR] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_cingulate_24aR),'type','Spearman');
[rho.MWMtime_cingulate_24bL,pval.MWMtime_cingulate_24bL] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_cingulate_24bL),'type','Spearman');
[rho.MWMtime_cingulate_24bpL,pval.MWMtime_cingulate_24bpL] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_cingulate_24bpL),'type','Spearman');
[rho.MWMtime_cingulate_24bpR,pval.MWMtime_cingulate_24bpR] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_cingulate_24bpR),'type','Spearman');
[rho.MWMtime_cingulate_24bR,pval.MWMtime_cingulate_24bR] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_cingulate_24bR),'type','Spearman');
[rho.MWMtime_cingulate_25L,pval.MWMtime_cingulate_25L] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_cingulate_25L),'type','Spearman');
[rho.MWMtime_cingulate_25R,pval.MWMtime_cingulate_25R] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_cingulate_25R),'type','Spearman');
[rho.MWMtime_cingulate_29aL,pval.MWMtime_cingulate_29aL] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_cingulate_29aL),'type','Spearman');
[rho.MWMtime_cingulate_29aR,pval.MWMtime_cingulate_29aR] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_cingulate_29aR),'type','Spearman');
[rho.MWMtime_cingulate_29bL,pval.MWMtime_cingulate_29bL] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_cingulate_29bL),'type','Spearman');
[rho.MWMtime_cingulate_29bR,pval.MWMtime_cingulate_29bR] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_cingulate_29bR),'type','Spearman');
[rho.MWMtime_cingulate_29cL,pval.MWMtime_cingulate_29cL] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_cingulate_29cL),'type','Spearman');
[rho.MWMtime_cingulate_29cR,pval.MWMtime_cingulate_29cR] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_cingulate_29cR),'type','Spearman');
[rho.MWMtime_cingulate_30L,pval.MWMtime_cingulate_30L] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_cingulate_30L),'type','Spearman');
[rho.MWMtime_cingulate_30R,pval.MWMtime_cingulate_30R] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_cingulate_30R),'type','Spearman');
[rho.MWMtime_cingulate_32L,pval.MWMtime_cingulate_32L] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_cingulate_32L),'type','Spearman');
[rho.MWMtime_cingulate_32R,pval.MWMtime_cingulate_32R] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_cingulate_32R),'type','Spearman');
[rho.MWMtime_entorhinalL_caudomedial,pval.MWMtime_entorhinalL_caudomedial] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_entorhinalL_caudomedial),'type','Spearman');
[rho.MWMtime_entorhinalL_dorsalintermediate,pval.MWMtime_entorhinalL_dorsalintermediate] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_entorhinalL_dorsalintermediate),'type','Spearman');
[rho.MWMtime_entorhinalL_dorsolateral,pval.MWMtime_entorhinalL_dorsolateral] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_entorhinalL_dorsolateral),'type','Spearman');
[rho.MWMtime_entorhinalL_medial,pval.MWMtime_entorhinalL_medial] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_entorhinalL_medial),'type','Spearman');
[rho.MWMtime_entorhinalL_ventralintermediate,pval.MWMtime_entorhinalL_ventralintermediate] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_entorhinalL_ventralintermediate),'type','Spearman');
[rho.MWMtime_entorhinalR_caudomedial,pval.MWMtime_entorhinalR_caudomedial] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_entorhinalR_caudomedial),'type','Spearman');
[rho.MWMtime_entorhinalR_dorsalintermediate,pval.MWMtime_entorhinalR_dorsalintermediate] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_entorhinalR_dorsalintermediate),'type','Spearman');
[rho.MWMtime_entorhinalR_dorsolateral,pval.MWMtime_entorhinalR_dorsolateral] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_entorhinalR_dorsolateral),'type','Spearman');
[rho.MWMtime_entorhinalR_medial,pval.MWMtime_entorhinalR_medial] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_entorhinalR_medial),'type','Spearman');
[rho.MWMtime_entorhinalR_ventralintermediate,pval.MWMtime_entorhinalR_ventralintermediate] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_entorhinalR_ventralintermediate),'type','Spearman');
[rho.MWMtime_fimbriaL,pval.MWMtime_fimbriaL] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_fimbriaL),'type','Spearman');
[rho.MWMtime_fimbriaR,pval.MWMtime_fimbriaR] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_fimbriaR),'type','Spearman');
[rho.MWMtime_fornixL,pval.MWMtime_fornixL] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_fornixL),'type','Spearman');
[rho.MWMtime_fornixR,pval.MWMtime_fornixR] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_fornixR),'type','Spearman');
[rho.MWMtime_hippocampusL,pval.MWMtime_hippocampusL] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_hippocampusL),'type','Spearman');
[rho.MWMtime_hippocampusR,pval.MWMtime_hippocampusR] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_hippocampusR),'type','Spearman');
[rho.MWMtime_temporalassnL,pval.MWMtime_temporalassnL] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_temporalassnL),'type','Spearman');
[rho.MWMtime_temporalassnR,pval.MWMtime_temporalassnR] = corr(table2array(MWM_swimtime(:,5:end)),table2array(invivo_temporalassnR),'type','Spearman');

% NOR vs invivo
[rho.NOR_amygdalaL,pval.NOR_amygdalaL] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_amygdalaL),'type','Spearman');
[rho.NOR_amygdalaR,pval.NOR_amygdalaR] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_amygdalaR),'type','Spearman');
[rho.NOR_cingulate_24aL,pval.NOR_cingulate_24aL] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_cingulate_24aL),'type','Spearman');
[rho.NOR_cingulate_24apL,pval.NOR_cingulate_24apL] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_cingulate_24apL),'type','Spearman');
[rho.NOR_cingulate_24apR,pval.NOR_cingulate_24apR] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_cingulate_24apR),'type','Spearman');
[rho.NOR_cingulate_24aR,pval.NOR_cingulate_24aR] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_cingulate_24aR),'type','Spearman');
[rho.NOR_cingulate_24bL,pval.NOR_cingulate_24bL] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_cingulate_24bL),'type','Spearman');
[rho.NOR_cingulate_24bpL,pval.NOR_cingulate_24bpL] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_cingulate_24bpL),'type','Spearman');
[rho.NOR_cingulate_24bpR,pval.NOR_cingulate_24bpR] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_cingulate_24bpR),'type','Spearman');
[rho.NOR_cingulate_24bR,pval.NOR_cingulate_24bR] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_cingulate_24bR),'type','Spearman');
[rho.NOR_cingulate_25L,pval.NOR_cingulate_25L] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_cingulate_25L),'type','Spearman');
[rho.NOR_cingulate_25R,pval.NOR_cingulate_25R] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_cingulate_25R),'type','Spearman');
[rho.NOR_cingulate_29aL,pval.NOR_cingulate_29aL] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_cingulate_29aL),'type','Spearman');
[rho.NOR_cingulate_29aR,pval.NOR_cingulate_29aR] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_cingulate_29aR),'type','Spearman');
[rho.NOR_cingulate_29bL,pval.NOR_cingulate_29bL] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_cingulate_29bL),'type','Spearman');
[rho.NOR_cingulate_29bR,pval.NOR_cingulate_29bR] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_cingulate_29bR),'type','Spearman');
[rho.NOR_cingulate_29cL,pval.NOR_cingulate_29cL] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_cingulate_29cL),'type','Spearman');
[rho.NOR_cingulate_29cR,pval.NOR_cingulate_29cR] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_cingulate_29cR),'type','Spearman');
[rho.NOR_cingulate_30L,pval.NOR_cingulate_30L] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_cingulate_30L),'type','Spearman');
[rho.NOR_cingulate_30R,pval.NOR_cingulate_30R] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_cingulate_30R),'type','Spearman');
[rho.NOR_cingulate_32L,pval.NOR_cingulate_32L] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_cingulate_32L),'type','Spearman');
[rho.NOR_cingulate_32R,pval.NOR_cingulate_32R] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_cingulate_32R),'type','Spearman');
[rho.NOR_entorhinalL_caudomedial,pval.NOR_entorhinalL_caudomedial] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_entorhinalL_caudomedial),'type','Spearman');
[rho.NOR_entorhinalL_dorsalintermediate,pval.NOR_entorhinalL_dorsalintermediate] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_entorhinalL_dorsalintermediate),'type','Spearman');
[rho.NOR_entorhinalL_dorsolateral,pval.NOR_entorhinalL_dorsolateral] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_entorhinalL_dorsolateral),'type','Spearman');
[rho.NOR_entorhinalL_medial,pval.NOR_entorhinalL_medial] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_entorhinalL_medial),'type','Spearman');
[rho.NOR_entorhinalL_ventralintermediate,pval.NOR_entorhinalL_ventralintermediate] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_entorhinalL_ventralintermediate),'type','Spearman');
[rho.NOR_entorhinalR_caudomedial,pval.NOR_entorhinalR_caudomedial] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_entorhinalR_caudomedial),'type','Spearman');
[rho.NOR_entorhinalR_dorsalintermediate,pval.NOR_entorhinalR_dorsalintermediate] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_entorhinalR_dorsalintermediate),'type','Spearman');
[rho.NOR_entorhinalR_dorsolateral,pval.NOR_entorhinalR_dorsolateral] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_entorhinalR_dorsolateral),'type','Spearman');
[rho.NOR_entorhinalR_medial,pval.NOR_entorhinalR_medial] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_entorhinalR_medial),'type','Spearman');
[rho.NOR_entorhinalR_ventralintermediate,pval.NOR_entorhinalR_ventralintermediate] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_entorhinalR_ventralintermediate),'type','Spearman');
[rho.NOR_fimbriaL,pval.NOR_fimbriaL] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_fimbriaL),'type','Spearman');
[rho.NOR_fimbriaR,pval.NOR_fimbriaR] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_fimbriaR),'type','Spearman');
[rho.NOR_fornixL,pval.NOR_fornixL] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_fornixL),'type','Spearman');
[rho.NOR_fornixR,pval.NOR_fornixR] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_fornixR),'type','Spearman');
[rho.NOR_hippocampusL,pval.NOR_hippocampusL] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_hippocampusL),'type','Spearman');
[rho.NOR_hippocampusR,pval.NOR_hippocampusR] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_hippocampusR),'type','Spearman');
[rho.NOR_temporalassnL,pval.NOR_temporalassnL] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_temporalassnL),'type','Spearman');
[rho.NOR_temporalassnR,pval.NOR_temporalassnR] = corr(table2array(NOR_data(:,5:end)),table2array(invivo_temporalassnR),'type','Spearman');

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
        
            column_var(j) = labels_invivo(column_mat(j));
    end
    rho_mat = rho.(fieldname{i})(sig);
    pval_mat = pval.(fieldname{i})(sig);
    name_mat = repelem(fieldname(i),numel(rho_mat))';
    sig_comp = vertcat(sig_comp,table(name_mat,row_var,column_var,rho_mat,pval_mat,'VariableNames',{'comparison','behav_var','image_var','rho','p'}));
end

writetable(sig_comp,'analyzed_data/invivoSignificance.csv');

hsigs = zeros;

for i=1:numel(fieldname)
    [h, crit_p, adj_ci_cvrg, adj_p]=fdr_bh(pval.(fieldname{i}));
    fieldname{i}
    h
end

% false discovery
% MWMtime_temporalassnR (1,1)(1,2)
% NOR_cingulate_29cR (2,1)(2,2)

%% MWMtime_temporalassnR (1,1) (1)
MWMswimTimeCol1 = table2array(MWM_swimtime(:,5));
temporalassnRCol1 = table2array(invivo_temporalassnR(:,1));


[p, S] = polyfit(temporalassnRCol1(:), MWMswimTimeCol1(:), 1);
xfit = 990:10:1810;
[Y, Delta] = polyconf(p, xfit, S);

figNum = 1;
figure(figNum)
clf(figNum)
figNum = figNum+1;
hold on


plot(temporalassnRCol1, MWMswimTimeCol1, 'kx', 'MarkerSize', 3);
alpha(0.4)
plot(xfit, polyval(p, xfit), 'r-')

fill([xfit, xfit(end:-1:1)], [Y+Delta, Y(end:-1:1)-Delta(end:-1:1)], [0.2 0.25 0.25], ...
    'EdgeColor', 'none', 'FaceAlpha', 0.1)

hold off
grid on
title('Swim Time (T1) vs Right Temporal Association Cortex Voxels (95% Confidence Interval)')
xlabel('Voxels')
ylabel('Time (s)')
xlim([1000 1800])

Rsq1 = 1 - sum((MWMswimTimeCol1 - polyval(p, temporalassnRCol1)).^2)./ ...
    sum((MWMswimTimeCol1 - mean(MWMswimTimeCol1)).^2)

rsqText = strcat('R^2 = ', num2str(Rsq1));
text(1600, 25, rsqText);

%% MWMtime_temporalassnR (1,2) (2)
MWMswimTimeCol1 = table2array(MWM_swimtime(:,5));
temporalassnRCol2 = table2array(invivo_temporalassnR(:,2));


[p, S] = polyfit(temporalassnRCol2(:), MWMswimTimeCol1(:), 1);
xfit = 0:0.1:2;
[Y, Delta] = polyconf(p, xfit, S);

figure(figNum)
clf(figNum)
figNum = figNum+1;
hold on


plot(temporalassnRCol2, MWMswimTimeCol1, 'kx', 'MarkerSize', 3);
alpha(0.4)
plot(xfit, polyval(p, xfit), 'r-')

fill([xfit, xfit(end:-1:1)], [Y+Delta, Y(end:-1:1)-Delta(end:-1:1)], [0.2 0.25 0.25], ...
    'EdgeColor', 'none', 'FaceAlpha', 0.1)

hold off
grid on
title('Swim Time (T1) vs Right Temporal Association Cortex Volume (95% Confidence Interval)')
xlabel('Volume (mm^2)')
ylabel('Time (s)')
xlim([1 2])

Rsq2 = 1 - sum((MWMswimTimeCol1 - polyval(p, temporalassnRCol2)).^2)./ ...
    sum((MWMswimTimeCol1 - mean(MWMswimTimeCol1)).^2);

rsqText = strcat('R^2 = ', num2str(Rsq2));
text(1.7, 30, rsqText);

%% NOR_cingulate_29cR (2,1) (3)
NORCol2 = table2array(NOR_data(:,6));
cingulate_29cRCol1 = table2array(invivo_cingulate_29cR(:,1));


[p, S] = polyfit(cingulate_29cRCol1(:), NORCol2(:), 1);
xfit = 200:10:800;
[Y, Delta] = polyconf(p, xfit, S);

figure(figNum)
clf(figNum)
figNum = figNum+1;
hold on


plot(cingulate_29cRCol1, NORCol2, 'kx', 'MarkerSize', 3);
alpha(0.4)
plot(xfit, polyval(p, xfit), 'r-')

fill([xfit, xfit(end:-1:1)], [Y+Delta, Y(end:-1:1)-Delta(end:-1:1)], [0.2 0.25 0.25], ...
    'EdgeColor', 'none', 'FaceAlpha', 0.1)

hold off
grid on
title('NOR RI\_T2 vs Cingulate 29 cR Voxels (95% Confidence Interval)')
xlabel('Voxels')
ylabel('RI\_T2')
xlim([200 800])

Rsq3 = 1 - sum((NORCol2 - polyval(p, cingulate_29cRCol1)).^2)./ ...
    sum((NORCol2 - mean(NORCol2)).^2);

rsqText = strcat('R^2 = ', num2str(Rsq3));
text(600, 0.35, rsqText);


%% % NOR_cingulate_29cR (2,2) (4)
NORCol2 = table2array(NOR_data(:,6));
cingulate_29cRCol2 = table2array(invivo_cingulate_29cR(:,2));


[p, S] = polyfit(cingulate_29cRCol2(:), NORCol2(:), 1);
xfit = 0:0.05:1;
[Y, Delta] = polyconf(p, xfit, S);

figure(figNum)
clf(figNum)
figNum = figNum+1;
hold on


plot(cingulate_29cRCol2, NORCol2, 'kx', 'MarkerSize', 3);
alpha(0.4)
plot(xfit, polyval(p, xfit), 'r-')

fill([xfit, xfit(end:-1:1)], [Y+Delta, Y(end:-1:1)-Delta(end:-1:1)], [0.2 0.25 0.25], ...
    'EdgeColor', 'none', 'FaceAlpha', 0.1)

hold off
grid on
title('NOR RI\_T2 vs Cingulate 29 cR Volume (95% Confidence Interval)')
xlabel('Volume (mm^2)')
ylabel('RI\_T2')
xlim([0 1])

Rsq4 = 1 - sum((NORCol2 - polyval(p, cingulate_29cRCol2)).^2)./ ...
    sum((NORCol2 - mean(NORCol2)).^2);

rsqText = strcat('R^2 = ', num2str(Rsq4));
text(0.65, 0.35, rsqText);




