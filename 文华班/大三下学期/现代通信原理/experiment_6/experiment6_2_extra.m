clear;
clc;
% Create a null array to record the bit error rate for each random sequence
ratios1 = [];
ratios2 = [];
times = 10; % Simulate 10 random times
for time=1:times 
    % Generate a binary sequence with length of 100
    L = 100; 
    os = round(rand(1,L));
    os(os==0) = -1;
    % Convert the binary sequence into original siganl
    Ts = 1; % Symbol period
    N_sample = 100; % Sample points for single symbol
    dt = Ts / N_sample; % Interval of sampling for single symbol
    t = 0:dt:(L * N_sample - 1)*dt; % Time during for whole symbol
    wave = [];
    for i=1:L % For each symbol
        if os(i) == 1 % If symbol is 1, turn to corresponding waveform
            wave = [wave, ones(1, N_sample)];
        else % If symbol is 0, turn to 0
            wave = [wave, zeros(1, N_sample)];
        end
    end
    % Plot both the original signal
    figure(1)
    subplot(311)
    set(gcf,'position', [250 200 1200 600]);
    plot(t, wave)
    grid on;
    title("The original signal");
    ylim([-0.25, 1.25]);
    xlabel("time (s)")
    ylabel("voltage (V)")
    % Define the symbol transmission rate
    Rb = 0.5e4; % Rb = 0.5e4;
    Fs = 1e5;
    % Upsample the sequence to make symbols
    N = Fs/Rb;
    os_upsampled = upsample(os, N);
    % Let the Nyquist rate be 5kBaud and 20kBaud
    Rs1 = 5e3;
    Rs2 = 20e3;
    % Generate the corresponding roll-off systems
    Fs = 1e5;
    span = 6;
    alpha = 0.5;
    sps1 = Fs/Rs1;
    sps2 = Fs/Rs2;
    h1 = rcosdesign(alpha, span, sps1); 
    h2 = rcosdesign(alpha, span, sps2);
    % Signal and systems convolution
    rs1 = conv(os_upsampled, h1, 'same');
    rs2 = conv(os_upsampled, h2, 'same');
   
    % Downsample the receive signal
    rs1_downsampled = downsample(rs1, N);
    rs2_downsampled = downsample(rs2, N);
    % Perform sample decision and convert it into waveform
    Vd = 0;
    rs1_decision = [];
    rs2_decision = [];
    for i=1:length(rs1_downsampled)
        if rs1_downsampled(i)>=Vd
            rs1_decision = [rs1_decision, ones(1, N_sample)];
        else
            rs1_decision = [rs1_decision, zeros(1, N_sample)];
        end
        if rs2_downsampled(i)>=Vd
            rs2_decision = [rs2_decision, ones(1, N_sample)];
        else
            rs2_decision = [rs2_decision, zeros(1, N_sample)];
        end
    end
    % Plot the received signal1
    subplot(312)
    plot(t, rs1_decision)
    grid on;
    title("The received signal Rs=5kB");
    ylim([-0.25, 1.25]);
    xlabel("time (s)")
    ylabel("voltage (V)")
    % Plot the received signal2
    subplot(313)
    plot(t, rs2_decision)
    grid on;
    title("The received signal Rs=20kB");
    ylim([-0.25, 1.25]);
    xlabel("time (s)")
    ylabel("voltage (V)")
    % Calculate the error bit rate
    [number1, ratio1] = biterr(wave, rs1_decision);
    [number2, ratio2] = biterr(wave, rs2_decision);
    % Save the BER
    ratios1 = [ratios1, ratio1];
    ratios2 = [ratios2, ratio2];
end
% Calculate the average BER
ratio1_avg = mean(ratios1);
ratio2_avg = mean(ratios2);
% Plot the BER for each experiment and mark the average BER
figure(2)
% Draw the area of the BER
xconf = [1, 10, 10, 1];
yconf = [min(ratios1), min(ratios1), max(ratios1), max(ratios1)];
p1 = fill(xconf,yconf, 'red', FaceColor=[0.93 0.91 0.91], EdgeColor='none');
hold on
yconf = [min(ratios2), min(ratios2), max(ratios2), max(ratios2)];
p2 = fill(xconf,yconf, 'red', FaceColor=[0.93 0.91 0.91], EdgeColor='none');
hold on
% Plot the BER
plot((1:times), ratios1, (1:times), ratios2, 'LineWidth',2)
line([1, times], [ratio1_avg, ratio1_avg], 'color','r','linestyle','--')
line([1, times], [ratio2_avg, ratio2_avg], 'color','r','linestyle','--')
text(times/2, ratio1_avg, num2str(ratio1_avg))
text(times/2, ratio2_avg, num2str(ratio2_avg))
grid on;
title("The BER of each random experiment");
legend('Area Rs1=5e3', 'Area Rs2=20e3', 'BER Rs2=5e3', 'BER Rs2=20e3')
ylim([0, 1])
xlabel("Experiment time")
ylabel("Bit Error Rate")

% Plot the received signal1
figure(3)
subplot(211)
plot(rs1(1:50*sps2))
hold on
plot(os_upsampled(1:50*sps2)/2)
title("The original impulse sequence and sampling curve Nyquist rate 5kB")
subplot(212)
plot(rs2(1:50*sps2))
hold on
plot(os_upsampled(1:50*sps2)/2)
title("The original impulse sequence and sampling curve Nyquist rate 20kB")
