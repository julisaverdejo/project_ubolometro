clear; close all; clc;
format longG

res = zeros(92,10);
% path = "01_nval_volts/01_resistencias/00_0ohm/";
% path = "01_nval_volts/01_resistencias/01_10ohm/";
% path = "01_nval_volts/01_resistencias/02_100ohm/new_times/";
% path = "01_nval_volts/01_resistencias/03_330ohm/";
% path = "01_nval_volts/01_resistencias/04_1k/new_times/";
% path = "01_nval_volts/01_resistencias/05_2k2/";
% path = "01_nval_volts/01_resistencias/06_4k7/";
% path = "01_nval_volts/01_resistencias/07_10k/";
% path = "01_nval_volts/01_resistencias/08_33k/";
% path = "01_nval_volts/01_resistencias/09_100k/";
% path = "01_nval_volts/01_resistencias/10_1M/";

for i = 1:10
    num = sprintf("%02d",i);
    filename = path + num + "_voltajes_dac_adc.txt";
    data = load(filename);
    Vadc = (data(:,3));
    res(:,i)  = Vadc;
end

Vadc_r = mean(res,2);
% plot(Vadc_r(1:88))

%%
% Voltajes enviados
Vdac = 0:45:91*45;
Vdac = Vdac*(3.3/4095);

plot(Vdac, Vadc_r, 'Color','red', 'LineWidth',2)
% title("Voltaje real vs Voltaje teorico (Rprue: $0\Omega$)", 'FontSize', 14, 'Interpreter','latex');
% title("Voltaje real vs Voltaje teorico (Rprue: $10\Omega$)", 'FontSize', 14, 'Interpreter','latex');
title("Voltaje real vs Voltaje teorico (Rprue: $100\Omega$)", 'FontSize', 14, 'Interpreter','latex');
% title("Voltaje real vs Voltaje teorico (Rprue: $330\Omega$)", 'FontSize', 14, 'Interpreter','latex');
% title("Voltaje real vs Voltaje teorico (Rprue: $1K\Omega$)", 'FontSize', 14, 'Interpreter','latex');
% title("Voltaje real vs Voltaje teorico (Rprue: $2.2K\Omega$)", 'FontSize', 14, 'Interpreter','latex');
% title("Voltaje real vs Voltaje teorico (Rprue: $4.7K\Omega$)", 'FontSize', 14, 'Interpreter','latex');
% title("Voltaje real vs Voltaje teorico (Rprue: $10K\Omega$)", 'FontSize', 14, 'Interpreter','latex');
% title("Voltaje real vs Voltaje teorico (Rprue: $33K\Omega$)", 'FontSize', 14, 'Interpreter','latex');
% title("Voltaje real vs Voltaje teorico (Rprue: $100K\Omega$)", 'FontSize', 14, 'Interpreter','latex');
% title("Voltaje real vs Voltaje teorico (Rprue: $1M\Omega$)", 'FontSize', 14, 'Interpreter','latex');

grid on; grid minor;

hold on;
%%

Rref = 1e3;
Rprue = 0;
% Rprue = 10;
% Rprue = 100;
% Rprue = 330;
% Rprue = 1e3;
% Rprue = 2.2e3;
% Rprue = 4.7e3;
% Rprue = 10e3;
% Rprue = 33e3;
% Rprue = 100e3;
% Rprue = 1e6;

Vref = (Rref/(Rprue + Rref))*Vdac;
plot(Vdac,Vref, ':','Color','blue', 'LineWidth',3)
xlabel("Vdac (V)",'FontSize', 14,'Interpreter','latex'); ylabel("Vadc(V)",'FontSize',14,'Interpreter','latex');
grid on; grid minor;
legend({'Voltaje real','Voltaje teorico'},'FontSize',14,'Location','southeast', 'Interpreter','latex');