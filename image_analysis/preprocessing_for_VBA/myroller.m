%my roller
mypathin='/Users/omega/alex/E3E4_RARE_rolled/'
% roll the RARE image files
% runnos = {'B05225','B05250','B05255','B05265','B05270','B05275','B05280','B05285','B05290','B05295','B05300','B05305','B05310','B05315','B05335','B05340','B05355','B05360','B05365','B05370','B05375','B05385','B05405','B05410','B05425','B05430','B05435','B05440','B05445','B05455','B05465'};
% allz = {12,59,61,49,78,74,19,55,78,62,55,89,71,80,26,31,24,23,25,87,96,31,35,20,10,40,47,34,15,29,22}
% runnos = {'B05215','B05220','B05230','B05235','B05240','B05320','B05325','B05330','B05346','B05350','B05380','B05390','B05395','B05400','B05415','B05420','B05460','B05470','B05475','B05480'};
% allz = {100,100,100,100,100,100,100, 100,100,100,100,100,100,100,100,100,100,100,100,100};
runnos = {'B05350'}
allz = {12}

for i=1:numel(runnos)
runno=runnos{i}
myz=allz{i};

mynii=load_untouch_nii( [mypathin runno '.nii.gz']);
myoutfile=[mypathin runno '_rolled.nii.gz']

myimg=mynii.img;
mynewim=myimg*0;
mysize=size(myimg);
myendz=mysize(3);

mynewim=circshift(myimg, myendz-myz, 3);


mynii.img=mynewim;
save_untouch_nii(mynii,myoutfile);

end

%% roll the RARE masks
mypathin='/Users/omega/alex/E3E4_RAREmasks/'
% runnos = {'B05225','B05250','B05255','B05265','B05270','B05275','B05280','B05285','B05290','B05295','B05300','B05305','B05310','B05315','B05335','B05340','B05355','B05360','B05365','B05370','B05375','B05385','B05405','B05410','B05425','B05430','B05435','B05440','B05445','B05450','B05455','B05465'};
% allz = {12,59,61,49,78,74,19,55,78,62,55,89,71,80,26,31,24,23,25,87,96,31,35,20,10,40,47,34,15,30,29,22};


for i=1:numel(runnos)
runno=runnos{i}
myz=allz{i}

mynii=load_untouch_nii( [mypathin runno '_mask.nii']);
myoutfile=[mypathin runno '_mask_rolled.nii'];

myimg=mynii.img;
mynewim=myimg*0;
mysize=size(myimg);
myendz=mysize(3);

mynewim=circshift(myimg, myendz-myz, 3);


mynii.img=mynewim;
save_untouch_nii(mynii,myoutfile);

end


%[data_buffer.headfile.roll_change,data_buffer.headfile.first_voxel_offset] = reroll_img(data_buffer,roll_keys,2);
