close all
clear all
run('utils')
run('loadData')

%% agrego el ruido
for k = 1:5 % recorremos los audios 
    noisy = awgn(mics(:,k),20,'measured');
    mics(:,k) = noisy;
end

%% ventaneo
gcc_ventaneo_upsample = [];
Nw = 2000;
for k = 1:4 % recorremos los audios 
    [tau,tau_temporal] = utils.tau_ventaneo_resampleado(mics(:,k),mics(:,k+1),Nw,fs,@hamming);
    gcc_ventaneo_upsample = [gcc_ventaneo_upsample tau];
end
gcc_ventaneo_upsample
