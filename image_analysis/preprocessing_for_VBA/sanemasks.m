 
antspath='/Volumes/workstation_home/ants_20160816_darwin_11.4/antsbin/bin/';

% runnos={'B05215','B05220','B05225','B05230','B05235','B05240','B05250','B05255','B05265','B05270','B05275','B05280','B05285','B05290','B05295','B05300','B05305','B05310','B05315','B05320','B05325','B05330','B05335','B05340','B05346','B05350','B05355','B05360','B05365','B05370','B05375','B05380','B05385','B05390','B05395','B05400','B05405','B05410','B05415','B05420','B05425','B05430','B05435','B05440','B05445','B05450','B05455','B05460','B05465','B05470','B05475','B05480'}
runnos={'B05216','B05221','B05226','B05231','B05236','B05241','B05251','B05256','B05266','B05271','B05276','B05281','B05286','B05291','B05296','B05301','B05306','B05311','B05316','B05321','B05326','B05331','B05336','B05341','B05347','B05351','B05356','B05361','B05366','B05371','B05376','B05381','B05386','B05391','B05396','B05401','B05406','B05411','B05416','B05421','B05426','B05431','B05436','B05441','B05446','B05451','B05456','B05461','B05466','B05471','B05476','B05481', 'B05342'}


for i=1:numel(runnos)
    runno = runnos{i}
    cmd1 = [antspath '/CopyImageHeaderInformation /Users/omega/alex/E3E4_RAREmasks_rolled/' runno 'GREmasked.nii.gz /Users/omega/alex/E3E4_GRE_work/' runno '.work/' runno '_QSM_masked.nii.gz /Users/omega/alex/E3E4_GRE_work/' runno '.work/' runno '_QSM_masked.nii.gz 1 1 1']
    % ./ImageMath 3 /Users/omega/alex/E3E4_RAREmasks_hdr/B05335_mask.nii Byte /Users/omega/alex/E3E4_RAREmasks_hdr/B05335_mask.nii
    
    [res,msg]=system(cmd1,'-echo')
end
