clear;
clc;

% Generate a 0-1 sequence with equal probability
L = 20;
bits = round(rand(1,L));

% Convert binary sequence into waveform
sample_number = 60;
Unipolar_signal = rectpulse(bits, sample_number);

% Transform it to a bipolar symbol sequence
Polar_signal = Unipolar_signal;
Polar_signal(Polar_signal==0) = -1;

% Plot the original signal
figure(1)
set(gcf,'position', [250 200 1000 800]);
T = 1;
dt = T/sample_number;
t = 0:dt:L*T-dt;
subplot(411)
plot(t, Polar_signal)
ylim([-2, 2])
grid on;
title("The original bipolar waveform");
xlabel("time (s)")
ylabel("voltage (V)")

% Plot the power spectral density of original signal
subplot(412)
interval = 500;
df = sample_number/interval;
f = -sample_number/2:df:sample_number/2-df;
Sf_original = pwelch(Polar_signal, interval, interval/2, interval, 'centered', 'power');
plot(f, 10*log10(Sf_original))
grid on;
title("The power spectral density of original signal");
xlabel("time (s)")
ylabel("voltage (V)")

% Modulate it with 2FSK
A = 1;
fc1 = 1;
fc2 = fc1*3;
t = 0:dt:L*T-dt;
ct1 = A*sin(2*pi*fc1*t);
ct2 = A*sin(2*pi*fc2*t);
signal_2FSK = Unipolar_signal.*ct1 + ~Unipolar_signal.*ct2;

% Plot the signal modulated by 2FSK 
subplot(413)
plot(t, signal_2FSK)
ylim([-2, 2])
grid on;
title("The original bipolar waveform modulated by 2FSK");
xlabel("time (s)")
ylabel("voltage (V)")

% Plot the power spectral density of the signal modulated by 2FSK 
subplot(414)
Sf_2FSK = pwelch(signal_2FSK, interval, interval/2, interval, 'centered', 'power');
plot(f, 10*log10(Sf_2FSK))
grid on;
title("The original bipolar waveform modulated by 2FSK");
xlabel("time (s)")
ylabel("voltage (V)")

% Modulate the sequence with 2PSK
A = 1;
fc = 1;
ct = A*sin(2*pi*fc*t);
signal_2PSK = Polar_signal.*ct;

% Plot the original signal
figure(2)
set(gcf,'position', [250 200 1000 800]);
subplot(411)
plot(t, Polar_signal)
ylim([-2, 2])
grid on;
title("The original bipolar waveform");
xlabel("time (s)")
ylabel("voltage (V)")

% Plot the power spectral density of original signal
subplot(412)
plot(f, 10*log10(Sf_original))
grid on;
title("The power spectral density of original signal");
xlabel("time (s)")
ylabel("voltage (V)")

% Plot the signal modulated by 2PSK 
subplot(413)
plot(t, signal_2PSK)
ylim([-2, 2])
grid on;
title("The original bipolar waveform modulated by 2PSK");
xlabel("time (s)")
ylabel("voltage (V)")

% Plot the power spectral density of the signal modulated by 2PSK 
subplot(414)
Sf_2PSK = pwelch(signal_2PSK, interval, interval/2, interval, 'centered', 'power');
plot(f, 10*log10(Sf_2PSK))
grid on;
title("The original bipolar waveform modulated by 2PSK");
xlabel("time (s)")
ylabel("voltage (V)")

% Modulate the sequence with 2DPSK
different_code = differential_code(bits);
Unipolar_different_code = rectpulse(different_code, sample_number);
Polar_different_code = Unipolar_different_code;
Polar_different_code(Polar_different_code==0) = -1;
A = 1;
fc = 1;
ct = A*sin(2*pi*fc*t);
signal_2DPSK = Polar_different_code.*ct;

% Plot the signal waveform
figure(3)
set(gcf,'position', [250 200 1000 800]);
subplot(411)
plot(t, Unipolar_signal)
ylim([-2, 2])
grid on;
title("The original bipolar waveform");
xlabel("time (s)")
ylabel("voltage (V)")

% Plot the differential code
subplot(412)
plot(t, Unipolar_different_code)
ylim([-2, 2])
grid on;
title("The differential code of the original sequence");
xlabel("time (s)")
ylabel("voltage (V)")

% Plot the signal modulated by 2DPSK 
subplot(413)
plot(t, signal_2DPSK)
ylim([-2, 2])
grid on;
title("The original bipolar waveform modulated by 2DPSK");
xlabel("time (s)")
ylabel("voltage (V)")

% Plot the power spectral density of the signal modulated by 2DPSK 
subplot(414)
Sf_2DPSK = pwelch(signal_2DPSK, interval, interval/2, interval, 'centered', 'power');
plot(f, 10*log10(Sf_2DPSK))
grid on;
title("The original bipolar waveform modulated by 2DPSK");
xlabel("time (s)")
ylabel("voltage (V)")
