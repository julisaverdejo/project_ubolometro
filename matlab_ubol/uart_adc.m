%% RS232 Conection
clear; close all; clc;

port = "COM8";
baudrate = 9600;
fpga = serialport(port,baudrate,"Parity","none","Timeout", 20);
flush(fpga);

file = fopen("temperatura.txt", "w");

n_lecturas = 1500;
data = zeros(n_lecturas,6);
time = datetime('now','Format','d-MMM-y HH:mm:ss.SSS');

fprintf(file,"%s\n",time);
%% Read data
start_time = datetime('now','Format','d-MMM-y HH:mm:ss.SSS');
for i = 1:n_lecturas
    data(i,:) = read(fpga,6,"uint8");
    temp1 = (data(i,1)*16^2 + data(i,2))*(3.1/4095)*100 -2;
    temp2 = (data(i,3)*16^2 + data(i,4))*(3.1/4095)*100 -2;
    time = datetime('now','Format','HH:mm:ss.SSS');
    fprintf(file,'%s %3u %3u %3u %3u %3u %3u %4.2f °C %4.2f °C\n',time,data(i,:), temp1, temp2);
end
end_time = datetime('now','Format','d-MMM-y HH:mm:ss.SSS');
fprintf(file,'Start time: %s\n',start_time);
fprintf(file,'End Time: %s\n',end_time);
%% Write 
% for i = 1:100
%     fprintf(file,'%u %u %u %u %u %u\n',data(i,:));
% end
%% Close conection 
%flush(fpga);
clear fpga;

% Default Configurations
    % "Parity","none" 
    % "DataBits",8
    % "StopBits",1
    % "FlowControl","none"
    % "ByteOrder","little-endian"
    % "Timeout", 10