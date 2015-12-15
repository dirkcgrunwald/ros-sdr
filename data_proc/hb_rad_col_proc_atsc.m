clear,clc,close('all')
load pn_seq_12MHz.mat

fid = fopen('hb_rec.bin'); % put your filename here

[data, count] = fread(fid,'uint16');
% Select subset of data
data = data(1e6:11e6);
mask_hi = 65280; % 0xFFO
mask_lo = 255; % 0xFF
data_I = bitand(data,mask_hi,'uint16');
data_Q = bitand(data,mask_lo,'uint16');
data_I = data_I/(16^2);
data_Q = data_Q;
ind_I = find(data_I>128);
ind_Q = find(data_Q>128);
data_I(ind_I) = data_I(ind_I)-256;
data_Q(ind_Q) = data_Q(ind_Q)-256;
fclose(fid);
data_complex = 1i*data_I+1*data_Q;
%% Plot Spectrum
figure(1)
clf(1)
plot(db(fftshift(fft(data_complex))))
xlim([-inf,inf])
data_len = min(length(data_I),length(data_Q));
%% Plot Constelation 
figure(2)
clf(2)
plot((data_complex(1:10000)),'.')
%% Plot Autocorrelation
pn_seq = resample(pn_seq,1,2);
data_in = data_complex;
size(pn_seq)
%zero pad the pn_seq
diff_len = length(data_in)-length(pn_seq);
pn_seq = [pn_seq; zeros(diff_len,1)];
% Take the FFT of the Data and filter sequence
data_f = fft(data_in);
pn_seq_f = fft(pn_seq);
% Perform the filtering, don't forget the conj
data_filt_f = data_f.*conj(pn_seq_f);
data_out = ifft(data_filt_f);
%
figure(3)
clf(3)
hold all
plot(db(data_out))
title('Autocorrelation')
ylabel('Mag (dB)')
xlabel('Symbol #')
hold off
%% Plot Waterfall
figure(4)
clf(4)
Fs = 6e6; % took a guess at your sample rate, will only change scaling, not shapes
Fc = 533e6; % center freqeuncy, can ignore this one
sig_of_int = data;
[S,F,T,P] = spectrogram(sig_of_int,256,128,128,Fs);
F = linspace(-Fs/2,Fs/2,length(F))/1e6+Fc/1e6;
imagesc(T/1e-3,F,fftshift(10*log10(P),1))
colorbar
