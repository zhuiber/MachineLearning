function seq = transformation7to11(seven_bits)
% Generate the 11-bits zero sequence (zero-padding)
seq = zeros(1,11); 
% According to the PCM table, determine the highest effective bit (determine segment)
% Start represents the number of the highest effective bit
if seven_bits(1) == 0
    if seven_bits(2) == 0
        if seven_bits(3) == 0
            start = 11 - 0; % 1st segment, B11=1
        else
            start = 11 - 4; % 2st segment, B7=1
        end
    else
        if seven_bits(3)==0
            start = 11 - 5; % 3st segment, B6=1
        else
            start = 11 - 6; % 4st segment, B5=1
        end
    end
else 
    if seven_bits(2) == 0
        if seven_bits(3) == 0
            start = 11 - 7; % 5st segment, B4=1
        else
            start = 11 - 8; % 6st segment, B3=1
        end
    else
        if seven_bits(3)==0
            start = 11 - 9; % 7st segment, B2=1
        else
            start = 11 - 10; % 8st segment, B1=1
        end
    end
end 
% Set the highest effective bit
seq(start) = 1;
% Set the 4-bit inner segment following the highest effective bit  
for i = 1:4
    seq(start+i) = seven_bits(3+i);
end