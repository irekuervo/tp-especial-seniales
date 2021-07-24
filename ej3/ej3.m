
retardos_correlacion_temporal = [];
retardos_correlacion_espectral = [];

for k = 1:4 % recorremos los audios 
    %correlacion cruzada
    tau = utils.tau_correlacion_cruzada(mics(:,k),mics(:,k+1),fs);
    retardos_correlacion_temporal  = [retardos_correlacion_temporal tau];
    %gccphat
    tau = utils.tau_gcc_phat(mics(:,k),mics(:,k+1),fs,@rectwin);
    retardos_correlacion_espectral = [retardos_correlacion_espectral tau];
end

retardos_correlacion_temporal
retardos_correlacion_espectral
