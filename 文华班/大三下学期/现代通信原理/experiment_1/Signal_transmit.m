% Initialize the parameters for signal
w = 4;
delay1 = pi / 3;
delay2 = pi / 2;
Ts = 0.01;
t = -pi:Ts:pi;
a = 0.8;
% Transmit signal
s_ = sin(w*t);
% Two transmitted siganls in two different path
s1 = a*sin(w*t+delay1);
s2 = a*sin(w*t+delay2);
% Plot the transmit signal
figure(1);
subplot(2, 1, 1)
plot(t, s_, 'LineWidth',1,'color','#8B4513','MarkerSize',10);
grid on;
xlabel("Time (s)");
ylabel("Amplitude");
title('The transmit signal (time domain)');
legend('sin(4t)');
axis([-4 4 -3 3]);
set(gcf,'position', [250 200 1000 800]);
% Synthetic the two signals
s = s1 + s2;
% Plot the receiving signal
subplot(2, 1, 2)
plot(t, s, 'LineWidth',1,'color','#708090','MarkerSize',10);
grid on;
xlabel("Time (s)");
ylabel("Amplitude");
title('The receiving signals (time domain)');
legend('sin(4t+pi/3)+sin(4t+pi/2)');
axis([-4 4 -3 3]);
set(gcf,'position', [250 200 1000 800]);

% Perform FFT for two original signals
y1 = fft(s1);
y2 = fft(s2);
y = fft(s_);
fs = 1/Ts;
f = (0:length(y1)-1)*fs/length(y1);
n = length(s1);
fshift = (-n/2:n/2-1)*(fs/n);
y1shift = fftshift(y1);
y2shift = fftshift(y2);
yshift = fftshift(y);
% Plot the transmit signal in frequency domain
figure(2);
subplot(2, 1, 1)
plot(fshift, abs(yshift), 'LineWidth',1,'color','#8B4513','MarkerSize',10);
grid on;
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('The transmit signals (frequency domain)');
legend('sin(4t)');
axis([-5 5 0 600]);
set(gcf,'position', [250 200 1000 800]);
% Plot the receiving signal in frequency domain
subplot(2, 1, 2)
plot(fshift, abs(y1shift+y2shift), 'LineWidth',1,'color','#708090','MarkerSize',10);
grid on;
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('The receiving signals (frequency domain)');
legend('sin(4t+pi/3)+sin(4t+pi/2)');
axis([-5 5 0 600]);
set(gcf,'position', [250 200 1000 800]);

% Obtain the channel in frequency domain
w_= -20:0.01:20;
H1 = a.*exp(-1i*w_*delay1);
H2 = a.*exp(-1i*w_*delay2);
H = H1 + H2;
% Plot the Amplitude-frequency characteristic of channel
figure(3)
subplot(1, 2, 1)
plot(w_, H, 'LineWidth',1,'color','#708090','MarkerSize',10);
grid on;
xlabel('\omega')
ylabel('|H(j(\omega))|');
title('Amplitude-frequency characteristic of channel');
legend('channel');
set(gcf,'position', [250 200 1100 400]);
% Plot the Phase-frequency characteristic of channel
subplot(1, 2, 2)
plot(w_, angle(H)/(2*pi), 'LineWidth',1,'color','#8B4513','MarkerSize',10);
grid on;
xlabel('\omega')
ylabel('\phi(\omega)');
title('Phase-frequency characteristic of channel');
legend('channel');
axis([-20 20 -1 1]);
set(gcf,'position', [250 200 1100 400]);