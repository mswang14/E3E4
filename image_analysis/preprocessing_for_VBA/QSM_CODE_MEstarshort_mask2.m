%QSM code for Multiple Echos - 7/14/17

%1. generate mGRE using RussReconADMask_ME

%2. mask mGRE 
%2a - use autogenerated mask, get saved in their workdir
%2b - or feed in our masks from skull stripped RARE mapped to GRE
%2c - or from mapping atlas mask onto individual brains

% run QSM using QSM_star

addpath(genpath('/Users/omega/alex/qsmpack/'));
work_path='/Users/omega/alex/E3E4_GRE_work/';

RARE_runno={'B05215','B05220','B05225','B05230','B05235','B05240','B05250','B05255','B05265','B05270','B05275','B05280','B05285','B05290','B05295','B05300','B05305','B05310','B05315','B05320','B05325','B05330','B05335','B05340','B05346','B05350','B05355','B05360','B05365','B05370','B05375','B05380','B05385','B05390','B05395','B05400','B05405','B05410','B05415','B05420','B05425','B05430','B05435','B05440','B05445','B05450','B05455','B05460','B05465','B05470','B05475','B05480'}
GRE_runno={'B05216','B05221','B05226','B05231','B05236','B05241','B05251','B05256','B05266','B05271','B05276','B05281','B05286','B05291','B05296','B05301','B05306','B05311','B05316','B05321','B05326','B05331','B05336','B05341','B05347','B05351','B05356','B05361','B05366','B05371','B05376','B05381','B05386','B05391','B05396','B05401','B05406','B05411','B05416','B05421','B05426','B05431','B05436','B05441','B05446','B05451','B05456','B05461','B05466','B05471','B05476','B05481', 'B05342'}

runno=GRE_runno;

flag_mask=2;
%mask = open_nii('B05216_masked.nii');
%manmask.img = mask;

 for i=1:numel(GRE_runno)
     runno=GRE_runno{i};

mypath=[work_path char(runno) '.work'];
cd(mypath)

myimg=RussReconADMask_ME('bruker','fermi','center','save');

myGREnii=make_nii(myimg,[0.1,0.1,0.1],[0, 0 ,0],16);
save_nii(myGREnii, [char(runno) 'mGRE.nii.gz']);


%%run QSM

FreqC=open_nii('FreqC.nii.gz');
load('B0dir.mat');
B0 = 7.0;
load TE
load meanSNR

Xidx = 1:6;
phimask1=open_nii('maskME.nii.gz');
T2 = T2mapMaskedWeighted(myimg(:,:,:,Xidx),TE(Xidx),phimask1,meanSNR(Xidx));

Freq = open_nii('Freq.nii.gz');
star = zeros(size(Freq));
voxelsize=[.1 .1 .1]; 

mask2=open_nii(['/Users/omega/alex/E3E4_RAREmasks_rolled/' runno 'GREmask.nii.gz']);
mask=squeeze(mask2(:,:,:,1));

for cpt = 1:6 % only used thre first 6 of 8 echoes
star(:,:,:,cpt) = QSM_star(2*pi*Freq(:,:,:,cpt)*TE(1,cpt),single(mask), 'H',[1 0 0], 'voxelsize' ,voxelsize,'padsize',[12 12 12],'TE',TE(1,cpt)*1000,'B0',7);
end
star(star == 0) = NaN;
qsm = (nanmean(star(:,:,:,2:4),4));
[W,qsm2] = nanMEW(TE,.025,star);
save_nii(make_nii(qsm,voxelsize,[0 0 0]), [char(runno) '_QSM_masked.nii.gz']);

%show3(XCFreqC);
%show3(T2); 
%

%make T2star maps


T22=T2; %abs(T2);
myT2nii=make_nii(T22,[0.1,0.1,0.1],[0, 0 ,0],16);
save_nii(myT2nii, [char(runno) 'T2.nii.gz']);



myimg2=abs(myimg(:,:,:,1));
myGRE = make_nii(myimg2,[0.1,0.1,0.1],[0, 0 ,0],16);
save_nii(myGRE, [char(runno) '_FE.nii.gz']);



end %end runno




