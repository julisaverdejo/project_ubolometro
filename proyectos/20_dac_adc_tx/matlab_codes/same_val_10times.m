clear; close all; clc;
format longG

Vadc_r = zeros(92,11);
path = "02_nval10_volts/01_resistencias/";

for i = 1:11
    num = sprintf("%02d",i);
    filename = path + num + "_voltajes_dac_adc.txt";
    data = load(filename);
    Vadc = (data(:,3));
    for v = 1:92
        temp = Vadc(((10*(v-1))+1):10*v,1);
        avg = mean(temp, 1);
        Vadc_r(v,i) = avg;
    end
end

%%
Vdac = 0:45:91*45;
Vdac = Vdac*(3.3/4095);

% plot(Vdac, Vadc_r(:,1), 'Color','red', 'LineWidth',2)
% title("Voltaje real vs Voltaje teorico (Rprue: $0\Omega$)", 'FontSize', 14, 'Interpreter','latex');
% plot(Vdac, Vadc_r(:,2), 'Color','red', 'LineWidth',2)
% title("Voltaje real vs Voltaje teorico (Rprue: $10\Omega$)", 'FontSize', 14, 'Interpreter','latex');
% plot(Vdac, Vadc_r(:,3), 'Color','red', 'LineWidth',2)
% title("Voltaje real vs Voltaje teorico (Rprue: $100\Omega$)", 'FontSize', 14, 'Interpreter','latex');
% plot(Vdac, Vadc_r(:,4), 'Color','red', 'LineWidth',2)
% title("Voltaje real vs Voltaje teorico (Rprue: $330\Omega$)", 'FontSize', 14, 'Interpreter','latex');
% plot(Vdac, Vadc_r(:,5), 'Color','red', 'LineWidth',2)
% title("Voltaje real vs Voltaje teorico (Rprue: $1K\Omega$)", 'FontSize', 14, 'Interpreter','latex');
% plot(Vdac, Vadc_r(:,6), 'Color','red', 'LineWidth',2)
% title("Voltaje real vs Voltaje teorico (Rprue: $2.2K\Omega$)", 'FontSize', 14, 'Interpreter','latex');
% plot(Vdac, Vadc_r(:,7), 'Color','red', 'LineWidth',2)
% title("Voltaje real vs Voltaje teorico (Rprue: $4.7K\Omega$)", 'FontSize', 14, 'Interpreter','latex');
% plot(Vdac, Vadc_r(:,8), 'Color','red', 'LineWidth',2)
% title("Voltaje real vs Voltaje teorico (Rprue: $10K\Omega$)", 'FontSize', 14, 'Interpreter','latex');
% plot(Vdac, Vadc_r(:,9), 'Color','red', 'LineWidth',2)
% title("Voltaje real vs Voltaje teorico (Rprue: $33K\Omega$)", 'FontSize', 14, 'Interpreter','latex');
% plot(Vdac, Vadc_r(:,10), 'Color','red', 'LineWidth',2)
% title("Voltaje real vs Voltaje teorico (Rprue: $100K\Omega$)", 'FontSize', 14, 'Interpreter','latex');
plot(Vdac, Vadc_r(:,11), 'Color','red', 'LineWidth',2)
title("Voltaje real vs Voltaje teorico (Rprue: $1M\Omega$)", 'FontSize', 14, 'Interpreter','latex');

grid on; grid minor;

hold on;
%

Rref = 1e3;
% Rprue = 0;
% Rprue = 10;
% Rprue = 100;
% Rprue = 330;
% Rprue = 1e3;
% Rprue = 2.2e3;
% Rprue = 4.7e3;
% Rprue = 10e3;
% Rprue = 33e3;
% Rprue = 100e3;
Rprue = 1e6;

Vref = (Rref/(Rprue + Rref))*Vdac;
plot(Vdac,Vref, ':','Color','blue', 'LineWidth',3)
xlabel("Vdac (V)",'FontSize', 14,'Interpreter','latex'); ylabel("Vadc(V)",'FontSize',14,'Interpreter','latex');
grid on; grid minor;
legend({'Voltaje real','Voltaje teorico'},'FontSize',14,'Location','southeast', 'Interpreter','latex');