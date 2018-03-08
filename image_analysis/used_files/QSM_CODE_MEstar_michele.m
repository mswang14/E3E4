%% imposes RARE mask onto GRE

mypath = '/Users/omega/alex/';
antspath='/Volumes/workstation_home/ants_20160816_darwin_11.4/antsbin/bin/';

RARE_runnos={'B05215','B05220','B05225','B05230','B05235','B05240','B05250','B05255','B05265','B05270','B05275','B05280','B05285','B05290','B05295','B05300','B05305','B05310','B05315','B05320','B05325','B05330','B05335','B05340','B05346','B05350','B05355','B05360','B05365','B05370','B05375','B05380','B05385','B05390','B05395','B05400','B05405','B05410','B05415','B05420','B05425','B05430','B05435','B05440','B05445','B05450','B05455','B05460','B05465','B05470','B05475','B05480'}
GRE_runnos={'B05216','B05221','B05226','B05231','B05236','B05241','B05251','B05256','B05266','B05271','B05276','B05281','B05286','B05291','B05296','B05301','B05306','B05311','B05316','B05321','B05326','B05331','B05336','B05341','B05347','B05351','B05356','B05361','B05366','B05371','B05376','B05381','B05386','B05391','B05396','B05401','B05406','B05411','B05416','B05421','B05426','B05431','B05436','B05441','B05446','B05451','B05456','B05461','B05466','B05471','B05476','B05481'}
roll = 0; %set to 1 if you need to roll
test=1

for i=1:numel(GRE_runnos)
%for i=1:2
    
    RARE_runno = RARE_runnos{i};
    GRE_runno=GRE_runnos{i};
    
    RARE = [mypath 'E3E4_RARE_rolled/' RARE_runno '_rolled.nii.gz']; %previously .nii
    GRE = [mypath 'E3E4_GRE_work/' GRE_runno '.work/' GRE_runno '_FE.nii.gz'];
    mask = [mypath 'E3E4_RAREmasks/' RARE_runno '_mask.nii'];% original RARE mask
    mymask= [mypath 'E3E4_RAREmasks/' RARE_runno '_mask2.nii']; %mask2 - hase RARE image header
    myshiftedmask = [mypath 'E3E4_RAREmasks/' RARE_runno '_mask2_rolled.nii'];
    outputTransformPrefix= [mypath 'E3E4_RAREmasks/' GRE_runno 'transf'];
    outputTransformPrefixm= [mypath 'E3E4_RAREmasks/' GRE_runno 'transfm'];
    myAffine= [mypath 'E3E4_RAREmasks/' GRE_runno 'transf0GenericAffine.mat'];
    myAffinem= [mypath 'E3E4_RAREmasks/' GRE_runno 'transfm0GenericAffine.mat'];
    outputWarpedImage= [mypath 'E3E4_RAREmasks/' RARE_runno 'Warped2RARE.nii.gz'];
    outputInverseWarpedImage= [mypath 'E3E4_RAREmasks/' GRE_runno 'bInvWarped.nii.gz'];
    GREmask= [mypath 'E3E4_RAREmasks/' GRE_runno 'GREmask.nii.gz'];
    GREmasked= [mypath 'E3E4_RAREmasks/' GRE_runno 'GREmasked.nii.gz'];
    RAREmasked=[mypath 'E3E4_RAREmasks/' RARE_runno 'RAREmasked.nii.gz'];
    outputm2f= [mypath 'E3E4_RAREmasks/' GRE_runno 'RARE2GRE.nii.gz'];
    outputm2fm= [mypath 'E3E4_RAREmasks/' GRE_runno 'RARE2GREm.nii.gz'];
    
    if test==1
        cmd6=[antspath 'antsApplyTransforms -d 3 -e 0 -i ' RAREmasked  ' -r ' GREmasked  ' -o ' outputm2fm ' -n BSpline -t ' myAffinem ' --float'];
        [res,msg]=system(cmd6,'-echo')
    else
    cmd0=[antspath '/CopyImageHeaderInformation  ' RARE ' ' mask ' ' mymask ' 1 1 1 '];
    cmd0b=[[antspath 'ImageMath 3 ' mymask ' Byte ' mymask]']
    cmd0c=[[antspath 'ImageMath 3 ' myshiftedmask ' Byte ' myshiftedmask]']
    cmd1=[antspath 'antsRegistration -d 3  -o [ ' outputTransformPrefix ',' outputm2f ']' ' -m MI[' GRE ',' RARE ',1,32,Regular,1] -t Affine[0.1] -c [ 100x100x20,1e-6,20] ' ...
        ' -s 4x4x4vox -f 8x4x1 -r ['  GRE ',' RARE ',1 ] -u -v'  ];
%     cmd1=[antspath 'antsRegistration -d 3  -o [ ' outputTransformPrefix ',' outputm2f ']' ' -m MI[' GRE ',' RARE ',1,32,Regular,1] -t Affine[0.1] -c [ 3x3x0,1e-6,20] ' ...
%         ' -s 4x4x4vox -f 8x4x1 -r ['  GRE ',' RARE ',1 ] -u -v'  ];
%     
    
    cmd2=[antspath 'antsApplyTransforms -d 3 -e 0 -i ' myshiftedmask  ' -r ' GRE  ' -o ' GREmask ' -n NearestNeighbor -t ' myAffine ' --float'];
    cmd2b=[antspath 'antsApplyTransforms -d 3 -e 0 -i ' RARE  ' -r ' GRE  ' -o ' outputm2f ' -n BSpline -t ' myAffine ' --float'];
    
    
    cmd3=[antspath 'ImageMath 3 ' GREmasked ' m ' GREmask ' ' GRE ]'
    cmd4=[antspath 'ImageMath 3 ' RAREmasked ' m ' myshiftedmask ' ' RARE ]'
    
    
    cmd5=[antspath 'antsRegistration -d 3  -o [ ' outputTransformPrefixm ',' outputm2fm ']' ' -m MI[' GREmasked ',' RAREmasked ',1,32,Regular,1] -t Affine[0.1] -c [ 100x100x20,1e-6,20] ' ...
        ' -s 4x4x4vox -f 8x4x1 -r ['  GREmasked ',' RAREmasked ',1 ] -u -v'  ];
%     cmd5=[antspath 'antsRegistration -d 3  -o [ ' outputTransformPrefixm ',' outputm2fm ']' ' -m MI[' GREmasked ',' RAREmasked ',1,32,Regular,1] -t Affine[0.1] -c [ 3x3x0,1e-6,20] ' ...
%         ' -s 4x4x4vox -f 8x4x1 -r ['  GREmasked ',' RAREmasked ',1 ] -u -v'  ];
     cmd6=[antspath 'antsApplyTransforms -d 3 -e 0 -i ' RAREmasked  ' -r ' GREmasked  ' -o ' outputm2fm ' -n BSpline -t ' myAffinem ' --float'];
    
%     [res,msg]=system(cmd0,'-echo') % copies header info
    [res,msg]=system(cmd0b,'-echo') % transform mask2 to Byte
    [res,msg]=system(cmd0c,'-echo') % transform mask2_rolled to Byte
    %% rolls mask2 to match rolled RARE images
    if roll == 1
    
    myshiftpath='/Users/omega/alex/E3E4_RAREmasks/'
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
    
    
    %% continues previous commands
    [res,msg]=system(cmd1,'-echo')
    [res,msg]=system(cmd2,'-echo')
    [res,msg]=system(cmd2b,'-echo')
    [res,msg]=system(cmd3,'-echo')
    [res,msg]=system(cmd4,'-echo')
    [res,msg]=system(cmd5,'-echo')
    [res,msg]=system(cmd6,'-echo')
    end %no test
    
end


% %% second step registration for better masking
% 
% outputTransformPrefix2= '/Users/omega/APOE_Study/RARE_Masks/B05221transf2'
% myAffine2='/Users/omega/APOE_Study/RARE_Masks/B05221transf20GenericAffine.mat'
% outputWarpedImage2='/Users/omega/APOE_Study/RARE_Masks/B05220Warped2RARE2.nii.gz'
% outputInverseWarpedImage2='/Users/omega/APOE_Study/RARE_Masks/B05221bInvWarped2.nii.gz'
% GREmask2='/Users/omega/APOE_Study/RARE_Masks/B05221GREmask2.nii.gz'
% GREmasked2='/Users/omega/APOE_Study/RARE_Masks/B05221GREmasked2.nii.gz'
% RAREmasked2='/Users/omega/APOE_Study/RARE_Masks/B05220RAREmasked2.nii.gz'
% outputm2f2='/Users/omega/APOE_Study/RARE_Masks/B05221RARE2GRE2.nii.gz'
% 
% cmd12=['/Applications/ants_201410/antsRegistration -d 3  -o [ ' outputTransformPrefix2 ',' outputm2f2 ']' ' -m MI[' GREmasked ',' RAREmasked ',1,32,Regular,1] -t Affine[0.1] -c [ 100x100x20,1e-6,20] ' ...
%     ' -s 4x4x4vox -f 8x4x1 -r ['  GREmasked ',' RAREmasked ',1 ] -u -v'  ];
% 
% cmd22=['/Applications/ants_201410/' 'antsApplyTransforms -d 3 -e 0 -i ' mymask  ' -r ' GREmasked  ' -o ' GREmask2 ' -n NearestNeighbor -t ' myAffine2 ' --float'];
% %cmd2b=['/Applications/ants_201410/' 'antsApplyTransforms -d 3 -e 0 -i ' RAREmasked  ' -r ' GREmasked  ' -o ' outputm2f2 ' -n BSpline -t ' myAffine2 ' --float'];
% 
% 
% cmd32=['/Applications/ants_201410/ImageMath 3 ' GREmasked2 ' m ' GREmask2 ' ' GRE ]
% 
% [res,msg]=system(cmd12,'-echo')
% [res,msg]=system(cmd22,'-echo')
% [res,msg]=system(cmd32,'-echo')
% 
% close all