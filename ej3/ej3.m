
corr_temp = [];
gcc_sin_ventaneo = [];

for k = 1:4 % recorremos los audios 
    %correlacion cruzada
    tau = utils.tau_correlacion_cruzada(mics(:,k),mics(:,k+1),fs);
    corr_temp  = [corr_temp tau];
    %gccphat
    tau = utils.tau_gcc_phat(mics(:,k),mics(:,k+1),fs);
    gcc_sin_ventaneo = [gcc_sin_ventaneo tau];
end

corr_temp
gcc_sin_ventaneo
