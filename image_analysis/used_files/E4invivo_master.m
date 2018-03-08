% Step 1: manually roll RARE images
RAREroll = 1 % 0 to skip
% Step 2: register GRE and RARE
registration = 1 % 0 to skip
mask2roll = 1 % 0 to skip
% Step 3: generate QSM, T2, and FE
QSMgenerator = 1 % 0 to skip
T2generator = 1 % 0 to skip
FEgenerator = 1 % 0 to skip
% Step 4: create pipeline inputs
makepipelineinputs = 1 % 0 to skip

mypath = '/Users/omega/alex/';
rollerpath='/Users/omega/alex/E3E4_RARE_rolled/';
work_path='/Users/omega/alex/E3E4_GRE_work/';
antspath='/Volumes/workstation_home/ants_20160816_darwin_11.4/antsbin/bin/';

RARE_runnos={'B05215','B05220','B05225','B05230','B05235','B05240','B05250','B05255','B05265','B05270','B05275','B05280','B05285','B05290','B05295','B05300','B05305','B05310','B05315','B05320','B05325','B05330','B05335','B05340','B05346','B05350','B05355','B05360','B05365','B05370','B05375','B05380','B05385','B05390','B05395','B05400','B05405','B05410','B05415','B05420','B05425','B05430','B05435','B05440','B05445','B05450','B05455','B05460','B05465','B05470','B05475','B05480'}
GRE_runnos={'B05216','B05221','B05226','B05231','B05236','B05241','B05251','B05256','B05266','B05271','B05276','B05281','B05286','B05291','B05296','B05301','B05306','B05311','B05316','B05321','B05326','B05331','B05336','B05341','B05347','B05351','B05356','B05361','B05366','B05371','B05376','B05381','B05386','B05391','B05396','B05401','B05406','B05411','B05416','B05421','B05426','B05431','B05436','B05441','B05446','B05451','B05456','B05461','B05466','B05471','B05476','B05481'}




%% rolls the RARE images manually
 
% use RARE_runnos
% RARE_runnos = {'B05225','B05250','B05255','B05265','B05270','B05275','B05280','B05285','B05290','B05295','B05300','B05305','B05310','B05315','B05335','B05340','B05355','B05360','B05365','B05370','B05375','B05385','B05405','B05410','B05425','B05430','B05435','B05440','B05445','B05455','B05465'};
% allz = {12,59,61,49,78,74,19,55,78,62,55,89,71,80,26,31,24,23,25,87,96,31,35,20,10,40,47,34,15,29,22}
% RARE_runnos = {'B05215','B05220','B05230','B05235','B05240','B05320','B05325','B05330','B05346','B05350','B05380','B05390','B05395','B05400','B05415','B05420','B05460','B05470','B05475','B05480'};
% allz = {100,100,100,100,100, 100,100,100,100,100,100,100,100,100,100,100,100,100};
if RAREroll==1
    allz = {100,100,12,100,100,100,59,61,49,78,74,19,55,78,62,55,89,71,80,100,100,100,26,31,100,12,24,23,25,87,96,100,31,100,100,100,35,20,100,100,10,40,47,34,15,100,29,100,22,100,100,100}

    for i=1:numel(RARE_runnos)
        runno=RARE_runnos{i}
        myz=allz{i};

        mynii=load_untouch_nii( [rollerpath runno '.nii.gz']);
        myoutfile=[rollerpath runno '_rolled.nii.gz']

        myimg=mynii.img;
        mynewim=myimg*0;
        mysize=size(myimg);
        myendz=mysize(3);

        mynewim=circshift(myimg, myendz-myz, 3);

        mynii.img=mynewim;
        save_untouch_nii(mynii,myoutfile);
    end
end

%% register the GRE and RARE images
% create a GRE mask using the RARE mask
% put the RARE image into the same space as the GRE image
% create a masked RARE image
% crate a masked GRE image
% put the masked RARE image into the same space as the masked GRE image

if registration==1
    for i=1:numel(GRE_runnos)
        RARE_runno = RARE_runnos{i};
        GRE_runno=GRE_runnos{i};
    
        RARE = [mypath 'E3E4_RARE_rolled/' RARE_runno '_rolled.nii.gz'];
        GRE = [mypath 'E3E4_GRE_work/' GRE_runno '.work/' GRE_runno '_FE.nii.gz'];
        mask = [mypath 'E3E4_RAREmasks/' RARE_runno '_mask.nii']; % original RARE mask
        mymask= [mypath 'E3E4_RAREmasks/' RARE_runno '_mask2.nii']; % mask2 - hase RARE image header
        myshiftedmask = [mypath 'E3E4_RAREmasks/' RARE_runno '_mask2_rolled.nii']; % rolled mask
        outputTransformPrefix= [mypath 'E3E4_RAREmasks/' GRE_runno 'transf'];
        outputTransformPrefixm= [mypath 'E3E4_RAREmasks/' GRE_runno 'transfm'];
        myAffine= [mypath 'E3E4_RAREmasks/' GRE_runno 'transf0GenericAffine.mat'];
        myAffinem= [mypath 'E3E4_RAREmasks/' GRE_runno 'transfm0GenericAffine.mat'];
        outputWarpedImage= [mypath 'E3E4_RAREmasks/' RARE_runno 'Warped2RARE.nii.gz'];
        outputInverseWarpedImage= [mypath 'E3E4_RAREmasks/' GRE_runno 'bInvWarped.nii.gz'];
        GREmask= [mypath 'E3E4_RAREmasks/' GRE_runno 'GREmask.nii.gz']; % mask for GRE
        GREmasked= [mypath 'E3E4_RAREmasks/' GRE_runno 'GREmasked.nii.gz']; % masked GRE image
        RAREmasked=[mypath 'E3E4_RAREmasks/' RARE_runno 'RAREmasked.nii.gz']; % masked RARE image
        outputm2f= [mypath 'E3E4_RAREmasks/' GRE_runno 'RARE2GRE.nii.gz']; % RARE image in GRE space
        outputm2fm= [mypath 'E3E4_RAREmasks/' GRE_runno 'RARE2GREm.nii.gz']; % masked RARE image in GRE space
    
        cmd0=[antspath '/CopyImageHeaderInformation  ' RARE ' ' mask ' ' mymask ' 1 1 1 '];
        cmd0b=[[antspath 'ImageMath 3 ' mymask ' Byte ' mymask]']
        cmd0c=[[antspath 'ImageMath 3 ' myshiftedmask ' Byte ' myshiftedmask]']
        cmd1=[antspath 'antsRegistration -d 3  -o [ ' outputTransformPrefix ',' outputm2f ']' ' -m MI[' GRE ',' RARE ',1,32,Regular,1] -t Affine[0.1] -c [ 100x100x20,1e-6,20] ' ...
        ' -s 4x4x4vox -f 8x4x1 -r ['  GRE ',' RARE ',1 ] -u -v'  ];
    
        cmd2=[antspath 'antsApplyTransforms -d 3 -e 0 -i ' myshiftedmask  ' -r ' GRE  ' -o ' GREmask ' -n NearestNeighbor -t ' myAffine ' --float'];
        cmd2b=[antspath 'antsApplyTransforms -d 3 -e 0 -i ' RARE  ' -r ' GRE  ' -o ' outputm2f ' -n BSpline -t ' myAffine ' --float'];
    
        cmd3=[antspath 'ImageMath 3 ' GREmasked ' m ' GREmask ' ' GRE ]'
        cmd4=[antspath 'ImageMath 3 ' RAREmasked ' m ' myshiftedmask ' ' RARE ]'
    
        cmd5=[antspath 'antsRegistration -d 3  -o [ ' outputTransformPrefixm ',' outputm2fm ']' ' -m MI[' GREmasked ',' RAREmasked ',1,32,Regular,1] -t Affine[0.1] -c [ 100x100x20,1e-6,20] ' ...
        ' -s 4x4x4vox -f 8x4x1 -r ['  GREmasked ',' RAREmasked ',1 ] -u -v'  ];
        cmd6=[antspath 'antsApplyTransforms -d 3 -e 0 -i ' RAREmasked  ' -r ' GREmasked  ' -o ' outputm2fm ' -n BSpline -t ' myAffinem ' --float'];
    
        [res,msg]=system(cmd0,'-echo') % copies header info
        [res,msg]=system(cmd0b,'-echo') % transform mask2 to Byte
        [res,msg]=system(cmd0c,'-echo') % transform mask2_rolled to Byte
    
        % rolls mask2 to match rolled RARE images
        if mask2roll == 1
            mymask2rollerpath='/Users/omega/alex/E3E4_RAREmasks/'
            runnos={'B05215','B05225','B05230','B05250','B05255','B05265','B05270','B05280','B05285','B05290','B05295','B05300','B05305','B05310','B05335','B05340','B05350','B05360','B05365','B05370','B05375','B05385','B05405','B05415','B05425','B05440','B05450','B05455','B05465'}
            allz = {1,2,15,-7,-5,4,3,-1,6,4,-13,-9,-11,-4,-4,1,2,-1,-6,-13,-4,12,5,-17,-7,-13,-70,-1,2};
        
            for i=1:numel(runnos)
                runno=runnos{i}
                myz=allz{i}
            
                mynii=load_untouch_nii( [myshiftpath runno '_mask2.nii']);
                myoutfile=[myshiftpath runno '_mask2_rolled.nii'];
            
                myimg=mynii.img;
                mynewim=myimg*0;
                mysize=size(myimg);
                myendz=mysize(3);
            
                mynewim=circshift(myimg, myendz-myz, 3);
            
                mynii.img=mynewim;
                save_untouch_nii(mynii,myoutfile);
            
            end
        end
    
        % continues previous commands
        [res,msg]=system(cmd1,'-echo')
        [res,msg]=system(cmd2,'-echo')
        [res,msg]=system(cmd2b,'-echo')
        [res,msg]=system(cmd3,'-echo')
        [res,msg]=system(cmd4,'-echo')
        [res,msg]=system(cmd5,'-echo')
        [res,msg]=system(cmd6,'-echo')
    end
end

%% generate QSM, T2, and FE

if QSMgenerator == 1
   % run QSM using QSM_star

   addpath(genpath('/Users/omega/alex/qsmpack/'));
   runno=GRE_runno;

   flag_mask=2;

   for i=1:numel(GRE_runno)
       runno=GRE_runno{i};

       makeQSMpath=[work_path char(runno) '.work'];
       cd(makeQSMpath)

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
   end
end

if T2generator == 1
    % make T2star maps
    for i=1:numel(GRE_runno)
       runno=GRE_runno{i};
       
       T22=T2; %abs(T2);
       myT2nii=make_nii(T22,[0.1,0.1,0.1],[0, 0 ,0],16);
       save_nii(myT2nii, [char(runno) 'T2.nii.gz']);
    end
end

if FEgenerator == 1
    % make FE maps
    for i=1:numel(GRE_runno)
       runno=GRE_runno{i};
       
       myimg2=abs(myimg(:,:,:,1));
       myGRE = make_nii(myimg2,[0.1,0.1,0.1],[0, 0 ,0],16);
       save_nii(myGRE, [char(runno) '_FE.nii.gz']);
    end
end

%% create pipeline inputs

if makepipelineinputs == 1
    for i=1:numel(RARE_runnos)
        % copy header information from GRE to QSM
        cmd0 = [antspath '/CopyImageHeaderInformation /Users/omega/alex/E3E4_RAREmasks_rolled/' char(GRE_runnos{i}) 'GREmasked.nii.gz /Users/omega/alex/E3E4_GRE_work/' char(GRE_runnos{i}) '.work/' char(GRE_runnos{i}) '_QSM_masked.nii.gz /Users/omega/alex/E3E4_GRE_work/' char(GRE_runnos{i}) '.work/' char(GRE_runnos{i}) '_QSM_masked.nii.gz 1 1 1']
        [res,msg]=system(cmd0,'-echo')
        % copy and rename masked RARE image for pipeline input
        RAREinput=['/Users/omega/alex/E3E4_RAREmasks/' char(GRE_runnos{i}) 'RARE2GREm.nii.gz'];
        RAREoutput=['/Users/omega/alex/pipeline_inputs/'  char(RARE_runnos{i}) '_T1_masked.nii.gz'];
        cp_cmd1=['cp ' RAREinput ' ' RAREoutput ]
        [status,cmdout]=system(cp_cmd1,'-echo')
        % copy and rename masked GRE image for pipeline input
        GREinput=['/Users/omega/alex/E3E4_RAREmasks_rolled/' char(GRE_runnos{i}) 'GREmasked.nii.gz'];
        GREoutput=['/Users/omega/alex/pipeline_inputs/'  char(RARE_runnos{i}) '_T2star_masked.nii.gz'];
        cp_cmd2=['cp ' GREinput ' ' GREoutput ]
        [status,cmdout]=system(cp_cmd2,'-echo')
        % copy and rename masked QSM for pipeline input
        QSMinput=['/Users/omega/alex/E3E4_GRE_work/' char(GRE_runnos{i}) '.work/' char(GRE_runnos{i}) '_QSM_masked.nii.gz'];
        QSMoutput=['/Users/omega/alex/pipeline_inputs/'  char(RARE_runnos{i}) '_X_masked.nii.gz'];
        cp_cmd3=['cp ' QSMinput ' ' QSMoutput ]
        [status,cmdout]=system(cp_cmd3,'-echo')
        % copy header information from masked GRE pipeline image 
        % to masked RARE pipeline image
        cmd4=[antspath '/CopyImageHeaderInformation /Users/omega/alex/pipeline_inputs/' char(RARE_runnos{i}) '_T2star_masked.nii.gz /Users/omega/alex/pipeline_inputs/' char(RARE_runnos{i}) '_T1_masked.nii.gz /Users/omega/alex/pipeline_inputs/' char(RARE_runnos{i}) '_T1_masked.nii.gz 1 1 1']
        [res,msg]=system(cmd4,'-echo')
        % create T2 pipeline image by multiplying T2 image with GRE mask
        cmd5=[antspath '/ImageMath 3 /Users/omega/alex/pipeline_inputs/' char(RARE_runnos{i}) '_T2_masked.nii.gz m /Users/omega/alex/E3E4_GRE_work/' char(GRE_runnos{i}) '.work/' char(GRE_runnos{i}) 'T2.nii.gz /Users/omega/alex/E3E4_RAREmasks/' char(GRE_runnos{i}) 'GREmask.nii.gz ']
        [res,msg]=system(cmd5,'-echo')
    end
end
