clear;
clc;
% Load the audio signal
[y, Fs] = audioread("Mozart.wav");
% Extract the first channel for the audio signal
signal = y(:,1).';
% Perform PCM for the first 100 samples and the last 100 samples
seq = pcm(signal);
seq1 = seq(1:800);
seq2 = seq((end-100*8-1):end);
% Plot the encoded result of the first 100 samples
figure(1)
set(gcf,'position', [250 200 2000 400]);
stem(seq1, ".");
title("The encoded result of the first 100 samples");
ylim([0, 2]);
% Plot the encoded result of the last 100 samples
figure(2)
set(gcf,'position', [250 200 2000 400]);
stem(seq2, ".");
title("The encoded result of the last 100 samples")
ylim([0, 2]);