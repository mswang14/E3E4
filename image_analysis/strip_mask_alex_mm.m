 function strip_mask_alex_mm(ref_nii, dim_divisor, threshold_zero, varargin)
%function STRIP_MASK(nii_path, dim_divisor, threshold_code,mask_result_nii,num_morph,radius,debug)
% This function makes an 8-bit binary skull-strip mask (1s and 0s) from 
% an image. Its patterned off the mask mean diffusion weighted image (DWI) code
% The output mask is saved in the location specified by mask_result_nii or, 
% if not specifed in same directory as the input ref_nii and is named 
%   "original_filename_8bit_mask.nii".
% The dim-divisor downsamples the input nii by the number entered 
% (2 downsamples by 2).  Use 1 if you do not wish to downsample data.  
% 
% The threshold_code can be one of four types of values, see below for
% info.
%
% nii_path, the input path of the nifti to mask
% dim_divisor,     An even number to divide your dimensions by to make the
%                  process faster,  especially useful for testing.
% threshold_zero,  * 100-inf the threshold value to use 
%                  * 1-99    the deriviative low point in the historgram to
%                            use for the threshold .
%                            Typically 4 in DWI images, however 3 and 5 have
%                            been seen as well.
%                  * -1      manual threshold via imagej macro
%                  * -2      histogram threshold via zeros of histogram
%                  derivative for T2* images
%                  appropriate for t1 and t2 images).
% mask_result_nii, path to save nifti mask to, or an empty string, ''.
% num_morph,       number of morpholical iterations to perform, default is 5
%                  generally the less morphs the larger your radius should be. 
%                  recommended values lower than 20
% radius,          radius for morpholigical operations. When using dim_divisor 
%                  this will need to be adjusted, default 2
%                  generally the smaller this value the more num_morphs requried
% debug,           verbosity of the output and which how many steps will 
%                  show the resultant volumes. 
%                  values are: (2 is default)
%                   2, show every step in a view_nii panel,
%                   1, only display the output mask, or 
%                   0, display none.
% To tune your call use
% strip_mask('/path/to/file.nii', 4, -1 , '', 4, 1.6 );
%   4 downsamples to speed up process
%  -1 for no threshold 0 ( could substitute a known threshold if available)
%  '' for outputname like input
%   4 morph iterations
% 1.6 morph radius
%
%
% -Alex Badea 
% -Evan Calabrese added imagej derivitive bassed threshold settings 
% -James cook updated for better memory use and more informative display
% steps, also exposed more settings to the function call via varargin for
% eaiser experimnetation of mask settings.
%TODO,
% make the dim_divisor field effect the raidus, so when we see a good
%mask at low res it represents a similar mask at high
%replace voxel based structuring elements with mm based structureing
%elements
%
%sample call
%run('/Volumes/workstation_home/software/shared//pipeline_utilities/startup.m');
%strip_mask ( '/cretespace/S64470_m0Labels-work/S64470_m0_DTI_dwi.nii', 2, -2, '/cretespace/S64470_m0Labels-work/S64470_m0_DTI_dwi_mask.nii',5 , 2 )

%alex adds path to nifti tools since they are not always found
%addpath('/Volumes/pipe_home/matlab_functions_external/NIFTI_20130306') 
addpath('/Users/omega/Documents/MATLAB/NIfTI_20140122/') 

%default math morphology params in voxels

defaultnum_morph=5;% 8; %6; % 4 works for evan; 5 works for alex
defaultradius=2;   % 2; %3.5; %3.5; %1.6; % 1.6 works for evan; 2 works for alesx
defaultradius0=8; %16; %16; %18 worked well; %3; %12; 16 works for alex
%extradialations=0;
extradialations=1;% comment this line to prevent extra dialations over the
%hardradius=0;
hardradius=1;% comment this line to use a closing radius related to the morph radius
reducethreshold=0.95; % 0-1 lowers threshold high evan often used 0.9, alex used 0.95

%ref_nii, dim_divisor, threshold_zero,mask_result_nii,num_morph,radius,debug
if( length(varargin)>=1) 
    if(isempty(varargin{1}))
        [result_path, filename, extension]=fileparts(ref_nii);
        mask_result_nii=strcat(result_path,'/',filename, '_8bit_mask', extension);
    else
       [result_path, ~, ~]=fileparts(varargin{1});
        mask_result_nii=varargin{1};
    end
else
    [result_path, filename, extension]=fileparts(ref_nii);
    mask_result_nii=strcat(result_path,'/',filename, '_8bit_mask', extension);
end


%--- set number of morphological operations
if(  length(varargin)>=2)
    if(isempty(varargin{2}))
        num_morph=defaultnum_morph; %8; %6; % 4 works for evan;
    else
        num_morph=varargin{2};
    end
    % started at 8
else
    num_morph=defaultnum_morph; %8; %6; % 4 works for evan;
end


% --- debug display
if ( length(varargin)>=4)
    if(isempty(varargin{4}))
        debuglevel=2;
    else
        debuglevel=varargin{4};
    end
else
    debuglevel=2;
end
if (debuglevel >=2)
    statusnii=1;
else
    statusnii=0;
end
if (debuglevel >=1 )
    status_largestconnecteddisplay=1; % comment this line to suppress status view_nii
else
    status_largestconnecteddisplay=0;
end

%num_morph ammount.

% addpath('/pipe_home/script/matlab_functions_local/T2WsuseptibilityReg');

%read image


% -- Load nii
tstart=tic;
nii = load_nii(ref_nii);
niioriginal.hdr=nii.hdr;
niioriginal.img=nii.img;
%clear niioriginal.img
%[xdim, ydim, zdim] = size(nii.img);
%alternatively
tmp= nii.hdr.dime.pixdim(2:4); %voxel dimensions (3 element array)
xdim=tmp(1); ydim=tmp(2); zdim=tmp(3);
pixdim=mean(tmp);% i certainly hope your images are isotropic, but just in case we are creating an isotropic structureing element
string=sprintf('x=%d y%d z=%d',xdim,ydim,zdim);
disp(string);
origin=nii.hdr.dime.dim(2:4);



% --- Downsampling: a decent resampling would be nice but this one works too
% --- Note - nii_small isn't created if dim_divisor is 1
if (dim_divisor ~= 1)
    nii_small=imresize(nii.img, 1/dim_divisor);
    nii_small=nii_small(:, :, 1:dim_divisor:zdim);
    nii.img=nii_small;
end

%make a diff nhood here for a diffrent radius?

%end read image

%recalculate math morph params based on voxel sizes (alx)
defaultradius=ceil(2*0.043/pixdim);   % 2; %3.5; %3.5; %1.6; % 1.6 works for evan; 2 works for alesx
radius=ceil(varargin{3}*0.043/pixdim);
defaultradius0=ceil(16*0.043/pixdim); %16; %18 worked well; %3; %12; 16 works for alex
%extradialations=0;
extradialations=1;% comment this line to prevent extra dialations over the
%hardradius=0;
hardradius=ceil(0.043/pixdim);% comment this line to use a closing radius related to the morph radius



% --- Set radius of kernel
if(  length(varargin)>=3)
    if(isempty(varargin{3}))
        radius=defaultradius; %2; %3.5; %3.5; %1.6; % 1.6 works for evan;
    else
        radius=ceil(varargin{3}*0.043/pixdim);
    end
    % started at 1.6
else
        radius=defaultradius; %2; %3.5; %3.5; %1.6; % 1.6 works for evan;
end




% radius=radius/dim_divisor; % james added this line, becuase if we're using the dim divisor, shouldnt the radius change? since its not in absolutes...
% --- Make kernel for erosion & dilation
'radius'
radius
[xx,yy,zz] = ndgrid(-radius:radius);
nhood = sqrt(xx.^2 + yy.^2 + zz.^2) <= radius;


% --- If there is no threshold zero, or using special - value, run the imagej macro to get it
if ~exist('threshold_zero','var') || threshold_zero==-1;
    % --- Write ImageJ macro
    fid=fopen(fullfile(result_path,'auto_threshold.ijm'),'w+');
    display(fullfile(result_path,'auto_threshold.ijm'))
    fprintf(fid,'%s \n','setSlice(nSlices/2);');
    fprintf(fid,'%s \n','run("In [+]");');
    fprintf(fid,'%s \n','run("Tile");');
    fprintf(fid,'%s \n','setAutoThreshold("Default dark");');
    fprintf(fid,'%s \n','run("Threshold...");');
    fprintf(fid,'%s \n','waitForUser("Threshold Macro", "Click OK when the threshold is correct");');
    fprintf(fid,'%s \n','getThreshold(lower, upper);');
    fprintf(fid,'%s \n',horzcat('f = File.open("',fullfile(result_path,'threshold.txt'),'");'));
    fprintf(fid,'%s \n','print(f, lower);');
    fprintf(fid,'%s \n','File.close(f);');
    fprintf(fid,'%s \n','run("Quit");');
    fclose(fid);
    % --- run imageJ macro
   % system(horzcat('java -Xmx2000m -jar /Applications/ImageJ/ImageJ.app/Contents/Resources/Java/ij.jar -ijpath /Applications/ImageJ ',ref_nii,' -macro ',fullfile(result_path,'auto_threshold.ijm')));
    system(horzcat('java -Xmx2000m -jar /Applications/ImageJ/plugins/jars/ij.jar  -ijpath /Applications/ImageJ ',ref_nii,' -macro ',fullfile(result_path,'auto_threshold.ijm')));fid=fopen(fullfile(result_path,'threshold.txt'),'r');
    threshold_min=fscanf(fid,'%u');
    display(horzcat('Threshold from imageJ is ',num2str(threshold_min)));
    fclose(fid);
    threshold_zero=-1;
end
% --- clean up text files
if exist('threshold_high','var');
    system(horzcat('rm ',fullfile(result_path,'auto_threshold.ijm')));
end
% --- if threshold_zero is special code -2, use historgraming code from
% alex's strip_mask
if threshold_zero==-2 
    % assume that the first 20pts in each direction is noise and not
    % sample.
    noise=double(reshape(nii.img(1:20,1:20, 1:20), 20*20*20,1));
    threshold_min=mean(noise)+2*std(noise);
    [counts,ns]=hist(double(reshape(nii.img, prod(size(nii.img)),1)), 200);
    threshold_high=ns(round(200*reducethreshold)); %33000;
    
    %smoothing histogram
    hsmooth=smooth(counts,5,'sgolay',3);
    [~,~,~,imin2] = extrema(hsmooth);
    vals=sort(ns(imin2));
    %thresh1=vals(3); %commennted for redundency, test data does not produce a
    %vals(3)
    
    %december 8 2011 second extrema
    threshold_min=vals(2);
    %threshold_high=thresh1;

end

% --- Choose thresholds for converting image to binary
% --- Find zeros of histogram derivative to set thresholds
% --- This section plots the histogram and highlights zeros with green dots
if threshold_zero>=0 && threshold_zero < 100
    [counts,ns]=hist(double(reshape(nii.img, prod(size(nii.img)),1)), 200);
    if(statusnii>0);
        figure(1);
        plot(ns,counts);
    end
    hsmooth=smooth(counts,5,'sgolay',3);
    if(statusnii>0);
        plot(ns,hsmooth,'b',ns,counts,'r.')
        set(gca(), 'YLim',[0 1.5*10^7]);
    end
    [ymax2,imax2,ymin2,imin2] = extrema(hsmooth);
    if(statusnii>0);
        hold
        plot(ns(imax2),ymax2,'r*',ns(imin2),ymin2,'g*');
        hold
        set(gca(), 'YLim',[0 1.5*10^6]);
    end
    vals=sort(ns(imin2));
    threshold_min=vals(threshold_zero);
    threshold_min=reducethreshold*threshold_min; % relax threshold(can be disabled above)
end
if ~exist('threshold_high','var')
    threshold_high=max(nii.img(:));
end
if ~exist('threshold_min','var')
    threshold_min=threshold_zero;
end
%threshold 664, threshold_high 2.9326e04

'threshold_min';
threshold_min

% --- This is effective if dim_divisor is not 1, downsample nifti 
origin=origin/(2*dim_divisor);
nii.img(nii.img<threshold_min)=0;
nii.img(nii.img>=threshold_high)=0; 
nii.img(nii.img>=threshold_min)=1;
%move struct elemts radii caluclation after downsampling alex

nii = make_nii(nii.img, [], origin, 4); % fix up header, we busted it earlier(maybe).
nii_t=nii;  % we want to save this for later.


% --- Fill holes in nii
nii.img=imfill(nii.img, 'holes');

% --- Erode binary image
tic
disp('eroding binary...');
for i=1:num_morph
    nii.img=imerode(nii.img, nhood);
end
toc

if(statusnii==1);
    name=['erroded binary' '_z' num2str(threshold_zero) '_m' num2str(num_morph) '_r' num2str(radius)];
    status_e=view_nii(nii);
    set(status_e.fig,'Name',name);
end

% --- Region growing, dilates the binary image
% --- Detect largest connected component
CC = bwconncomp(nii.img, 26);
S = regionprops(CC,'Area');
sz=(size(S)); sz=sz(1);
sa=zeros(sz,1);
for i=1:sz 
    sa(i)=S(i).Area;
end
[~, indmax]=max(sa);
labelim=uint16(labelmatrix(CC));
labelim=labelim*0;
labelim(CC.PixelIdxList{indmax})=1;

nii.img=labelim;
if(status_largestconnecteddisplay==1);
    name=['Largest Connected Region' '_z' num2str(threshold_zero) '_m' num2str(num_morph) '_r' num2str(radius)];
    status_cc=view_nii(nii); 
    set(status_cc.fig,'Name',name);
end
% nii_d=nii_s.img;
disp('dilating');
tic
for i=1:num_morph
    nii.img=imdilate(nii.img, nhood);
end
toc

if ( extradialations==1)
    
    disp('more dilating 1 of 2...');
    tic
    nii.img=imdilate(nii.img, nhood);
    disp('more dilating 2 of 2...');
    nii.img=imdilate(nii.img, nhood);
    toc
end

if(statusnii==1);
    name=[ 'Dialated Binary' 'erroded binary' '_z' num2str(threshold_zero) '_m' num2str(num_morph) '_r' num2str(radius)];
    status_d=view_nii(nii); 
    set(status_d.fig,'Name',name);
end


%to make it conditional dilation intersect with thresholded mask
%will fault you if thresholding aggresively- eg when cortex is lower than
%threhold_high
tic
nii.img=uint16(nii.img).*uint16(nii_t.img);
disp('filling holes 1of2...');
nii.img=imfill(nii.img, 'holes');
disp('filling holes 2of2...');
nii.img=imfill(nii.img, 'holes');
disp('holes filled');
toc
if(statusnii==1);
    name=['Filled Holes' 'erroded binary' '_z' num2str(threshold_zero) '_m' num2str(num_morph) '_r' num2str(radius)];
    status_f=view_nii(nii); 
    set(status_f.fig,'Name',name);
end
disp('closing...');
tic
% --- Make radius0
if(hardradius==1)
    radius0=defaultradius0;
else
    radius0=ceil(radius*2/dim_divisor); % james experimenting with raidus control.... related to original radius
end

% --- Make kernel0
nhood0=strel('ball', radius0, radius0, 0);
nii.img=imclose(nii.img, nhood0);
toc

if(statusnii==1);
    name=['Holes Closed' 'erroded binary' '_z' num2str(threshold_zero) '_m' num2str(num_morph) '_r' num2str(radius)];
    status_c=view_nii(nii); 
    set(status_c.fig,'Name',name);
end

if (dim_divisor ~= 1)
  % ---- Make upsampled mask
  disp('Upsampling... ');
  tic;
  nii.img=imresize(nii.img, dim_divisor, 'nearest');
  transf_scalez= [1 0 0 0 ; 0 1 0 0; 0 0 dim_divisor 0; 0 0 0 1];
  T = maketform('affine', transf_scalez);
  R = makeresampler('nearest', 'fill');
  nii_temp=tformarray(nii.img, T, R, [1 2 3], [1 2 3], [xdim ydim zdim], [], 0);
  toc;
  disp('converting to 8bit');
  nii8bit = make_nii(nii_temp, [], [xdim ydim zdim], 2);
  nii8bit.hdr=niioriginal.hdr;
  %nii8bit.img=nii8bit.img;
  nii8bit.hdr.dime.bitpix=8;
  nii8bit.hdr.dime.datatype=2;
  
 
else  % slg: got to save somrthing for other dim_divisors
  disp('converting to 8bit');
  tic
  %nii = make_nii(nii_s.img, [], [xdim ydim zdim], 2);
  nii8bit = make_nii(nii.img, [], [xdim ydim zdim], 2);
  %nii16bit = make_nii(nii_s.img, [], [xdim ydim zdim], 512);
  
  nii8bit.hdr=niioriginal.hdr;
  %nii8bit.img=nii8bit.img;
  nii8bit.hdr.dime.bitpix=8;
  nii8bit.hdr.dime.datatype=2;
  toc
end

tic
%[path filename extension]=fileparts(ref_nii);
%mask_result8=strcat(filename, '_8bit_mask', extension);
%mask_result8=mask_result_nii;

save_nii(nii8bit, mask_result_nii);
disp('wrote mask');

%alex makes everything uint16

nii_greyscale.hdr=nii8bit.hdr;

nii_greyscale.img=uint16(niioriginal.img).*uint16(nii8bit.img);

if(statusnii>=1);
    name=['Greyscale' 'erroded binary' '_z' num2str(threshold_zero) '_m' num2str(num_morph) '_r' num2str(radius)];
    status_g=view_nii(nii_greyscale);
    set(status_g.fig,'Name',name);
end

toc
ttotal=toc(tstart); %get total time to display
string=sprintf('Skull stripping done in %f seconds',ttotal);
disp(string);

