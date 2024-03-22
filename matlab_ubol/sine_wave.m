%% RS232 Conection
clear; close all; clc;

% t  = linspace(0,2*pi,1024);
% y = sin(t);
t  = linspace(0,2*pi,20);
y = sin(t);
figure(1); plot(t,y);grid on; grid minor;
% yp = round((4095/2)*(y+1));
yp = round((4095/2)*(y+1));
% figure(2); plot(yp); axis([1 1023 0 4096]);
figure(2); plot(yp); axis([1 20 0 4095]);
grid on; grid minor;

for i = 1:numel(yp)
    num = dec2bin(yp(i), 12);
    fprintf("%2d: dout_o = 12'b%s;\n", i-1, num);
end