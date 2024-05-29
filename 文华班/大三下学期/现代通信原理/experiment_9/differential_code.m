function different_code = differential_code(bits)
    L = length(bits); % Obtain the length of symbol
    initial_voltage = 1; % Initial voltage
    pre_voltage = initial_voltage; % Record the previous voltage
    different_code = [];
    for i = 1:L
        if bits(i) == 1 % If symbol is 1, jump the voltage
            different_code = [different_code, abs(pre_voltage-1)];
            pre_voltage = abs(pre_voltage-1); % Update the previous voltage
        else % If symbol is 0, no jump the voltage
            different_code = [different_code, pre_voltage];
        end
    end
end