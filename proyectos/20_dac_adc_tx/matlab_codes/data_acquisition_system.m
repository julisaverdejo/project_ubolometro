%% RS232 Conection
clear; close all; clc;

port = "COM4";
baudrate = 115200;
fpga = serialport(port,baudrate,"Parity","none","Timeout", 30);
flush(fpga);
filename = "voltajes_" + 1 + ".txt";
file = fopen(filename, "w");

n_lecturas = 92;
data = zeros(n_lecturas,2);
% time = datetime('now','Format','d-MMM-y HH:mm:ss.SSS');

% fprintf(file,"%s\n",time);
%% Read data
% start_time = datetime('now','Format','d-MMM-y HH:mm:ss.SSS');
for i = 1:n_lecturas
    data(i,:) = read(fpga,2,"uint8");
    volt = (data(i,1)*256 + data(i,2))*(3.3/4095);
    % time = datetime('now','Format','HH:mm:ss.SSS');
    % fprintf(file,'%s %3u %3u %8.6f\n',time,data(i,:), volt);
    fprintf(file,'%3u %3u %8.6f\n', data(i,:), volt);
end
% end_time = datetime('now','Format','d-MMM-y HH:mm:ss.SSS');
% fprintf(file,'Start time: %s\n',start_time);
% fprintf(file,'End Time: %s\n',end_time);

fclose(file);
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