close all;

retardos_correlacion_cruzada = [];
retardos_gccphat = [];

for k = 1:4 % recorremos los audios 
    %correlacion cruzada
    tau = utils.tau_correlacion_cruzada(mics{k+1},mics{k},fs);
    retardos_correlacion_cruzada  = [retardos_correlacion_cruzada tau];
    %gccphat
    tau = utils.tau_gcc_phat(mics{k+1},mics{k},fs,@rectwin);
    retardos_gccphat = [retardos_gccphat tau];
end

retardos_correlacion_cruzada
retardos_gccphat
