clear;
clc;
% Determine the symbol transmit rate fb and symbol duration Tb
fb = 1;
Tb = 1/fb;
% Equal probabilities
P = 1/2;
% Determine the G1 and G2
f = -10:0.00001:10;
G1 = (Tb^2)*(sinc(f.*Tb/2).^2);
G2 = 0;
% Calculate the Pu(f)
Pu = fb*P*(1-P)*abs(G1-G2).^2;
% Calculate the Pv(f)
m = -10:10;
G1_m = (Tb^2)*(sinc(m.*fb.*Tb/2).^2);
Pv = abs(fb*(P*G1_m)+(1-P)*G2).^2;
% Plot the theoretic power density
figure(1)
plot(f, Pu)
hold on
stem(m, Pv)
xlabel('Frequency (Hz)')
ylabel('Amplitude')
title("The theoretic power density")