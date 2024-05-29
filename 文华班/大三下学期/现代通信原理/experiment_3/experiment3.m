clear;
clc;
% Determine the sample rate for plotting m(t)
Fs = 10000;
t = 0:1/Fs:0.05;
% Generate the original signal m(t)
m_t = cos(90*pi*t);
% Determine the sample rate for m(t)
fs = 2000;
t_sample = 0:1/fs:0.05;
% Sample the orginal signal
m_t_sample = cos(90*pi*t_sample);
% Plot the original signal m(t)
figure(1)
set(gcf,'position', [250 200 1000 800]);
subplot(211)
plot(t, m_t, 'linewidth', 0.5)
title("The original signal m(t)")
xlabel("t (s)")
ylabel('Ampltitude')
grid on;
% Plot the sampled signal
subplot(212)
stem(t_sample, m_t_sample, ".", 'linewidth', 0.5)
title("The sampled signal m(t)")
xlabel("t (s)")
ylabel('Ampltitude')
grid on;
% Quantization
max = 1;
min = -1;
delv = (max - min) / 32;
for i = 1:32+1
    m(i) = min + delv*(i - 1);
end
mt_riser = m_t;
for i = 1 : length(mt_riser)
    for j = 1:32
        if mt_riser(i) >= m(j) && mt_riser(i) <= m(j+1)
            mt_riser(i) = (m(j) + m(j+1)) / 2;
            break
        end
    end
end
% Plot the original and quantization signal
figure(2)
set(gcf,'position', [250 200 1000 800]);
subplot(211)
plot(t, m_t, 'linewidth', 0.5)
title("The original signal m(t)")
xlabel("t (s)")
ylabel('Ampltitude')
grid on;
subplot(212)
plot(t, mt_riser, 'linewidth', 0.5)
title("The quantization signal m(t)")
xlabel("t (s)")
ylabel('Ampltitude')
grid on;