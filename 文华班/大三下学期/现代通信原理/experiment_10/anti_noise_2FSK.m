clc
close all
clear
SNR=0:1:20; % Set a set of experimential SNR                
SNR1=0.5*(10.^(SNR/10)); 
freqsep=8; % Set the frequency separation
nsamp=8; % Set the number of samples per symbol
Fs=32; % Set the sample rate
N=1000000; % Number of samples for signal                  
M1=2; % Determine the modulation order                     
x1=randi([0,1],1,N); % Generate the random binary signal       
R=raylrnd(0.5,1,nsamp*N); % Generate the rayleigh channel        
h1=fskmod(x1,M1,freqsep,nsamp,Fs); % Modulate the original signal by 2FSK            
H1=h1.*R; %2FSK pass through rayleigh channel

% Calculate the bit error rate under different SNR
for i=1:length(SNR)
    yAn1=awgn(h1,SNR(i),'measured'); % Add the AWGN to the 2FSK
    yA1=fskdemod(yAn1,M1,freqsep,nsamp,Fs); % Demodulate the 2FSK added AWGN    
    [bit_A1,~]=biterr(x1,yA1); % Calculate the number of bit error
    BFSK_AWGN(i)=bit_A1/N; % Calculate the bit error rate
    
    yRn1=awgn(H1,SNR(i),'measured'); % Add the AWGN to the 2FSK
    yR1=fskdemod(yRn1,M1,freqsep,nsamp,Fs); % Demodulate the 2FSK added AWGN      
    [bit_R1,~]=biterr(x1,yR1); % Calculate the number of bit error
    BFSK_Ray(i)=bit_R1/N; % Calculate the bit error rate
end

% Calculate the theoretical result
BFSK_theoretical=erfc((SNR/2).^(1/2))./2;

% Plot the corresponding figure
figure
semilogy(SNR,BFSK_AWGN,'r*');hold on;
semilogy(SNR,BFSK_Ray,':b*');hold on;
semilogy(SNR,BFSK_theoretical,':g*')
grid on;
axis([-1 20 10^-6 1]);
legend('2FSK-AWGN仿真','2FSK-Rayleigh仿真','2FSK理论');
title('2FSK误码性能分析');
xlabel('信噪比（dB）');ylabel('BER');