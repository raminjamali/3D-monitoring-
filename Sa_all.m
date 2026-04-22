%% AVERAGE ROUGHNESS
%% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 filename_np=['np.mat'];
    h_np=importdata(filename_np); 
    h0_np=(h_np-min(min(h_np))).*1e6.*2;
h0m_np=mean(mean(h0_np));
M_np=size(h0_np,1).*size(h0_np,2);
s_np=0;
for ii=1:M_np;
        s_np=s_np+(abs(h0_np(ii)-h0m_np));
end
Sa_np=(1/(M_np-1))*s_np; % Calculate Average roughness