clear; close all; clc;
format long
% filename = "volt1.txt"; %luz normal
filename = "voltajes.txt"; %sombra
% filename = "volt3.txt"; %cubierta
data = load(filename);

Vadc = (data(:,1)*256 + data(:,2))*(3.3/4095);
dac = 0:45:91*45;
dac = dac*(3.3/4095);
i = Vadc/(1e3);

plot(dac, i)
% plot(dac, adc)
% xlabel("DC Sweep"); ylabel("Vresistor");
xlabel("DC Sweep (V)"); ylabel("Current (A)")
grid on; grid minor;

%%
Rref = 1e3;
Rprue = 0;
dac = 0:45:91*45;
Vdac = dac*(3.3/4095);
Vref = (Rref/(Rprue + Rref))*Vdac;
plot(Vdac,Vref)
xlabel("Vdac (V)"); ylabel("Vref(V)")
grid on; grid minor;
% filename2 = "voltajes_teoricos.txt";
% file2 = fopen(filename2, "w");
% fprintf(file2,'%8.6f\n', Vrload);
% fclose(file2);