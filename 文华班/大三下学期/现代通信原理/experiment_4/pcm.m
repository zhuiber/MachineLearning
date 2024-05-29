function seq = pcm(signal)
% input  signal: the signal to encode
% output seq   : the encoded signal
% 13-segment A-law PCM encoder

% Use sign function to obtain the sign of each sample for C1 determination
z = sign(signal);   
% Perofrm normalization (voltage_value*2048deta/max_voltage_value)
mx = max(abs(signal));  
s = abs(signal/mx);  
q = 2048*s; 
% Create a matrix with 8 colunms to record the encoded 8-bit result for each sample
y = zeros(length(s),8); 
% Create a vector with (sample_number*8) length to record the encoded 8-bit result for each sample
seq = zeros(1,length(s)*8); 
% Determine the C2, C3, C4 for each sample
for m=1:length(s)
    % According to the PCM encoded table, when a sample drops in the range of 128-2048, C2=1
    if (q(m)>=128 && q(m)<2048)
        y(m,2) = 1;
    end
    % According to the PCM encoded table, when a sample drops in the range of 32-128 or 512-2048, C3=1
    if (q(m)>=32 && q(m)<128) || (q(m)>=512 && q(m)<2048)
        y(m,3) = 1;
    end
    % According to the PCM encoded table, when a sample drops in the range of 16-32 or 64-128 or 256-512 or 1024-2048, C4=1
    if (q(m)>=16 && q(m)<32) || (q(m)>=64 && q(m)<128) || (q(m)>=256 && q(m)<512) || (q(m)>=1024 && q(m)<2048)      
        y(m,4) = 1;           
    end
    % Calculate the level for the inner segment bits C5C6C7C8
    level = 0; % Initialize the level
    if (q(m)<16)
        level = floor(q(m)/1); % The quantization interval for 1st segment is 1
    elseif (q(m)<32)
        level = floor((q(m)-16)/1); % The quantization interval for 2nd segment is 1
    elseif (q(m)<64)     
        level = floor((q(m)-32)/2); % The quantization interval for 3rd segment is 2
    elseif (q(m)<128)    
        level = floor((q(m)-64)/4); % The quantization interval for 4th segment is 4
    elseif (q(m)<256)       
        level = floor((q(m)-128)/8); % The quantization interval for 5th segment is 8
    elseif (q(m)<512)           
        level = floor((q(m)-256)/16); % The quantization interval for 6th segment is 16
    elseif (q(m)<1024)   
        level = floor((q(m)-512)/32); % The quantization interval for 7th segment is 32
    elseif (q(m)<2048) 
        level = floor((q(m)-1024)/64); % The quantization interval for 8th segment is 64
    end
    % Convert level into inner segment bits C5C6C7C8
    k  = dec2bin(level,4); % Convert level into binary form
    y(m,5) = str2num(k(1)); % B1 refers to C5
    y(m,6) = str2num(k(2)); % B2 refers to C6
    y(m,7) = str2num(k(3)); % B3 refers to C7
    y(m,8) = str2num(k(4)); % B4 refers to C8
    % The special case when the value of sample is 2048
    if (q(m)==2048)
        y(m,:) = [0 1 1 1 1 1 1 1];
    end
    % Determine C1. When sampling value is positive, C1=1; else, C1=0
    if (z(m)>0)
        y(m,1) = 1;
    end
end
% Convert the encoded matrix into the sequence in convenience to transmit
for i = 1:length(s)
    for j = 1:8
        seq(1,(i-1)*8+j) = y(i,j);
    end
end
end
        