%% SKEWNESS
%% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 filename_np=['np.mat'];
    h_np=importdata(filename_np); 
    h0_np=(h_np-min(min(h_np))).*1e6.*2;
    
Ssk_np=skewness(h0_np(:));% Calculate Skewness
