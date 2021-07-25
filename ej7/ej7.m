clear all

run('loadData');
fi
filtro = fir1(120,[0.006 0.1],'bandpass',hamming(121));
%% agrego el ruido y filtro
for k = 1:5 % recorremos los audios 
    noisy = awgn(mics(:,k),20,'measured');
    
    filtered = filter(filtro,1,noisy);
    mics(:,k) = filtered;
end

%% ventaneo
gcc_ventaneo_upsample = [];
Nw = 2000;
for k = 1:4 % recorremos los audios 
    [tau,tau_temporal] = utils.tau_ventaneo_resampleado(mics(:,k),mics(:,k+1),Nw,fs,@hamming);
    gcc_ventaneo_upsample = [gcc_ventaneo_upsample tau];
end
gcc_ventaneo_upsample
