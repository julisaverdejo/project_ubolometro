clear; close all; clc;
format long
% filename = "volt1.txt"; %luz normal
filename = "voltajes.txt"; %sombra
% filename = "volt3.txt"; %cubierta
data = load(filename);

adc = (data(:,1)*256 + data(:,2))*(3.3/4095);
dac = 0:45:91*45;
dac = dac*(3.3/4095);
i = adc/(1e3);

plot(dac, i)
% plot(dac, adc)
% xlabel("DC Sweep"); ylabel("Vresistor");
xlabel("DC Sweep (V)"); ylabel("Current (A)")
grid on; grid minor;