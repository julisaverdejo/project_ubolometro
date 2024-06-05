clear; close all; clc;
format longG

%% Voltajes recibidos sin multiplexores
% res = zeros(31,10);
fres = zeros(31,30);
% path = "voltajes_resistencias/01_1k/";
% path = "voltajes_resistencias/02_3k3/";
% path = "voltajes_resistencias/03_5k6/";
% path = "voltajes_resistencias/04_10k/";
path = "analisis_fotorres/";

for i = 1:30
    % num = sprintf("%02d",i);
    filename = path + "voltajes_" + i + ".txt";
    datar = load(filename);
    Vadcr = (datar(:,3));
    % res(:,i)  = Vadcr;
    fres(:,i)  = Vadcr;
end

% Vadc_r = mean(res,2);
Vadc_fres = mean(fres,2);
%% Error sin mux
Vdac = 0:0.1:3;
res_t = res';
err = 200*std(res_t);
e = errorbar(Vdac, Vadc_r, err, 'Color', "#D95319");
e.Marker = "*";

%% Voltajes recibidos con multiplexores
res_m = zeros(31,10);
% path = "voltajes_resistencias/01_1k_m/";
% path = "voltajes_resistencias/02_3k3_m_new/";
% path = "voltajes_resistencias/03_5k6_m_new/";
path = "voltajes_resistencias/04_10k_m_new/";

for j = 1:10
    filename = path + "voltajes_" + j + ".txt";
    datarm = load(filename);
    Vadcrm = (datarm(:,3));
    res_m(:,j)  = Vadcrm;
end

Vadc_rm = mean(res_m,2);

%% Error con mux
Vdac = 0:0.1:3;
res_tm = res_m';
err_mux = 100*std(res_tm);
e_mux = errorbar(Vdac, Vadc_rm, err_mux,'Color',"#0072BD");
e_mux.Marker = "*";
%%
% Voltajes enviados
Vdac = 0:0.1:3;

plot(Vdac, Vadc_r, '--', 'Color','red', 'LineWidth',2)
hold on;
plot(Vdac, Vadc_rm, '-.', 'Color','blue', 'LineWidth',2)
% title("Voltajes recibidos vs Voltaje teorico (Rtest: $1k\Omega$)", 'FontSize', 14, 'Interpreter','latex');
% title("Voltajes recibidos vs Voltaje teorico (Rtest: $3.3k\Omega$)", 'FontSize', 14, 'Interpreter','latex');
% title("Voltajes recibidos vs Voltaje teorico (Rtest: $5.6k\Omega$)", 'FontSize', 14, 'Interpreter','latex');
% title("Voltajes recibidos vs Voltaje teorico (Rtest: $10k\Omega$)", 'FontSize', 14, 'Interpreter','latex');

hold on;

%% Fotorresistencia
Vdac = 0:0.1:3;
plot(Vdac, Vadc_fres, 'Color','#A2142F', 'LineWidth',2)
grid on; grid minor;
title("Fotorresistencia con luz normal", 'FontSize', 14, 'Interpreter','latex');
xlabel("Vdac (V)",'FontSize', 14,'Interpreter','latex'); ylabel("Vadc(V)",'FontSize',14,'Interpreter','latex');
%%

Rref = 10e3;
% Rprue = 1e3;
% Rprue = 3.3e3;
% Rprue = 5.6e3;
% Rprue = 10e3;

Vref = (Rref/(Rprue + Rref))*Vdac;
plot(Vdac,Vref, 'Color',"#77AC30", 'LineWidth',2)
xlabel("Vdac (V)",'FontSize', 14,'Interpreter','latex'); ylabel("Vadc(V)",'FontSize',14,'Interpreter','latex');
grid on; grid minor;
legend({'Voltaje s/mux','Voltaje c/mux','Voltaje teorico'},'FontSize',14,'Location','southeast', 'Interpreter','latex');