clear; close all; clc;
format longG

%% pwm 25
res_25 = zeros(31,20);
path = "analisis_fotorres/pwm_25/";

for i = 1:20
    filename = path + "voltajes_" + i + ".txt";
    datar = load(filename);
    Vadcr = (datar(:,3));
    res_25 = Vadcr; 
end

Vadc_25 = mean(res_25,2);
%% pwm 50
res_50 = zeros(31,20);
path = "analisis_fotorres/pwm_50/";

for i = 1:20
    filename = path + "voltajes_" + i + ".txt";
    datar = load(filename);
    Vadcr = (datar(:,3));
    res_50 = Vadcr; 
end

Vadc_50 = mean(res_50,2);
%% pwm 75
res_75 = zeros(31,20);
path = "analisis_fotorres/pwm_75/";

for i = 1:20
    filename = path + "voltajes_" + i + ".txt";
    datar = load(filename);
    Vadcr = (datar(:,3));
    res_75 = Vadcr; 
end

Vadc_75 = mean(res_75,2);
%% pwm 100
res_100 = zeros(31,20);
path = "analisis_fotorres/pwm_100/";

for i = 1:20
    filename = path + "voltajes_" + i + ".txt";
    datar = load(filename);
    Vadcr = (datar(:,3));
    res_100 = Vadcr; 
end

Vadc_100 = mean(res_100,2);
%% Grafica
Vdac = 0:0.1:3;
plot(Vdac, Vadc_25, 'Color', "#A2142F", 'LineWidth',2)
hold on;
plot(Vdac, Vadc_50, 'Color', "#0072BD", 'LineWidth',2)
hold on;
plot(Vdac, Vadc_75, 'Color', "#D95319", 'LineWidth',2)
hold on;
plot(Vdac, Vadc_100, 'Color', "#77AC30", 'LineWidth',2)
hold on;
grid on; grid minor;
title("Respuesta de luminica", 'FontSize', 14, 'Interpreter','latex');
xlabel("Vdac (V)",'FontSize', 14,'Interpreter','latex'); ylabel("Vadc(V)",'FontSize',14,'Interpreter','latex');
legend({'$25\%$ duty cycle','$50\%$ duty cycle','$75\%$ duty cycle', '$100\%$ duty cycle'},'FontSize',12,'Location','southeast', 'Interpreter','latex');