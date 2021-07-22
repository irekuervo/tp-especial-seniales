close all;

wn = 10000;
dn = 1000;

tau_mics = [];

for k = 2:numel(mics) % recorremos los audios
    taus=[];
    index = 1;
    for n=1:dn:N-wn
        tau = utils.tau_par_microfono(n,mics{k-1},mics{k},wn,@hamming,fs);
        if tau > 0
            taus = [taus tau];
        end
        %pause(.1)
    end
%     h = histogram(taus,100000);
%     [M,I] = max(h.Values);
    tau_mics = [tau_mics taus(1)]
end

tau_mics






