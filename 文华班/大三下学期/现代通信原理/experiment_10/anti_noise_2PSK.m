clc
close all
clear
SNR=0:1:20; % Set a set of experimential SNR                
SNR1=0.5*(10.^(SNR/10));    
N=1000000; % Number of samples for signal                  
M1=2; % Determine the modulation order                     
x1=randi([0,1],1,N); % Generate the random binary signal       
R=raylrnd(0.5,1,N); % Generate the rayleigh channel        
h1=pskmod(x1,M1); % Modulate the original signal by 2PSK            
H1=h1.*R; %BPSK pass through rayleigh channel

% Calculate the bit error rate under different SNR
for i=1:length(SNR)
    yAn1=awgn(h1,SNR(i),'measured'); % Add the AWGN to the 2PSK
    yA1=pskdemod(yAn1,M1); % Demodulate the 2PSK added AWGN    
    [bit_A1,~]=biterr(x1,yA1); % Calculate the number of bit error
    BPSK_AWGN(i)=bit_A1/N; % Calculate the bit error rate
    
    yRn1=awgn(H1,SNR(i),'measured'); % Add the AWGN to the 2PSK
    yR1=pskdemod(yRn1,M1); % Demodulate the 2PSK added AWGN      
    [bit_R1,~]=biterr(x1,yR1); % Calculate the number of bit error
    BPSK_Ray(i)=bit_R1/N; % Calculate the bit error rate
end

% Calculate the theoretical result
BPSK_theoretical=erfc((SNR/4).^(1/2))./2;

% Plot the corresponding figure
figure
semilogy(SNR,BPSK_AWGN,'r*');hold on;
semilogy(SNR,BPSK_Ray,':b*');hold on;
semilogy(SNR,BPSK_theoretical,':g*')
grid on;
axis([-1 20 10^-6 1]);
legend('BPSK-AWGN仿真','BPSK-Rayleigh仿真','BPSK理论');
title('PSK误码性能分析');
xlabel('信噪比（dB）');ylabel('BER');