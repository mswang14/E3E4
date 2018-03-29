runnos = {'N54717','N54718','N54719','N54720','N54722','N54759','N54760','N54761','N54762','N54763', 'N54764','N54765','N54766','N54770','N54771','N54772','N54798','N54801','N54802','N54803','N54804','N54805','N54806','N54807','N54818','N54824','N54825','N54826','N54837','N54838','N54843','N54844','N54856','N54857','N54858','N54859','N54860','N54861','N54873','N54874','N54875','N54876','N54877','N54879','N54880','N54891','N54892','N54893','N54897','N54898','N54899','N54900','N54915','N54916','N54917'};


for i=1:numel(runnos)
    
    cmd1 = ['/Applications/dsi_studio1.app/Contents/MacOS/dsi_studio --action=trk --source=/Volumes/CivmUsers/omega/alex/E3E4v1/connect4dsistudio/pre_rigid_native_space/' runnos{i} '/' runnos{i} '_nii4D_RAS.nii.gz.src.gz.dti.fib.gz --method=1 --fiber_count=2000000 --fa_threshold=0.08 --initial_dir=1 --seed_plan=0 --interpolation=0 --thread_count=12 --random_seed=1 --step_size=0.03 --smoothing=0.01 --min_length=0.0 --max_length=300.0 --connectivity=/Volumes/CivmUsers/omega/alex/E3E4v1/connect4dsistudio/pre_rigid_native_space/fa_labels_warp_' runnos{i} '_RAS.nii.gz --connectivity_value=count --connectivity_threshold=0 --connectivity_type=pass > /Volumes/CivmUsers/omega/alex/E3E4v1/connect4dsistudio/pre_rigid_native_space/' runnos{i} '/' runnos{i} '.log'];
    [res,msg]=system(cmd1,'-echo');
    
end


% /Applications/dsi_studio1.app/Contents/MacOS/dsi_studio --action=trk --source=/Volumes/CivmUsers/omega/alex/E3E4v1/connect4dsistudio/pre_rigid_native_space/N54764/N54764_nii4D_RAS.nii.gz.src.gz.dti.fib.gz --method=1 --fiber_count=2000000 --fa_threshold=0.08 --initial_dir=1 --seed_plan=0 --interpolation=0 --thread_count=12 --random_seed=1 --step_size=0.03 --smoothing=0.01 --min_length=0.0 --max_length=300.0 --connectivity=/Volumes/CivmUsers/omega/alex/E3E4v1/connect4dsistudio/pre_rigid_native_space/fa_labels_warp_N54764_RAS.nii.gz --connectivity_value=count --connectivity_threshold=0 --connectivity_type=pass > /Volumes/CivmUsers/omega/alex/E3E4v1/connect4dsistudio/pre_rigid_native_space/N54764/N54764.log




