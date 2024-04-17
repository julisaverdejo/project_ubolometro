clear; close all; clc;
format long

steps = 0:45:91*45;
voltajes = steps*(3.3/4095);

%% ROM for same_val_1time

for i = 1:numel(steps)
    steps_bin = dec2bin(steps(i), 12);
    fprintf("%8d : rom_o = 12'b%s; //%8.6f\n", i-1, steps_bin, voltajes(i))
end

%% ROM for same_val_10times

for i = 1:numel(steps)
    steps_bin = dec2bin(steps(i), 12);
    for v = 1:10
        fprintf("%9d : rom_o = 12'b%s; //%8.6f\n", 10*(i-1) + (v-1), steps_bin, voltajes(i))
    end
end