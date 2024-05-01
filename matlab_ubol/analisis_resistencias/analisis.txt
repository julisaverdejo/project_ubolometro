clear; close all; clc;

x = linspace(0,3.3,100);
Rref = 10e3;
Rt = 1e3;
y = x* (Rref/(Rref + Rt));
amp = 2;
plot(x,x, "DisplayName", "Normal", "LineWidth",2);
hold on;
plot(x,y, "DisplayName", string(Rt/1000)+"k");
plot(x,amp*y, "DisplayName",  string(amp) + " x " + string(Rt/1000)+"k");

% idx = 1e3:1e3:40e3;
% for i = idx
%     Rt = i;
%     y = x* (Rref/(Rref + Rt));
%     plot(x,y, "DisplayName", string(i/1000)+"k");
% end

grid on; grid minor; legend();
