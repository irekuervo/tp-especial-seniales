close all;

retardos_correlacion_cruzada = [];
retardos_gccphat = [];
retardos_IDFT = [];

for k = 1:(numel(mics)-1) % recorremos los audios 
    %correlacion cruzada
    [r,lags] = xcorr(mics{k+1},mics{k});
    [maximo,index] = max(r);
    tau = lags(index)/fs;
    retardos_correlacion_cruzada  = [retardos_correlacion_cruzada tau];
    %gccphat
    tau = gccphat(mics{k+1}.',mics{k}.',fs);
    retardos_gccphat = [retardos_gccphat tau];
end
