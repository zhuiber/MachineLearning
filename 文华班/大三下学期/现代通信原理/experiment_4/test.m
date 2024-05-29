clear;
clc;
% The verification of on special case 7-bit encoded result [1,0,0,0,1,1,0]
seq = transformation7to11([1,0,0,0,1,1,0]);
% Load the audio signal
[y, Fs] = audioread("Mozart.wav");
% Extract the first channel for the audio signal
signal = y(:,1).';
% Perform PCM for the first 10
seq1 = pcm(signal);
seq1 = seq1(1:80);
% Create a vector with (sample_number*11) length to record the encoded 11-bit result for each sample
y = zeros(1, 11*10);
% Perform 7/11 transformation for each sample
for i = 1:10
        y(1, (i-1)*11+1:i*11) = transformation7to11(seq1(1, (i-1)*8+2:i*8));
end
% Convert the sequence into a matrix in convenience to observe
encoded_matrix = zeros(10 ,11);
for j = 1:10
    encoded_matrix(j, 1:11) = y(1, (j-1)*11+1:j*11);
end
encoded_matrix