%% RS232 Conection
clear; close all; clc;

port = "COM4";
baudrate = 115200;
fpga = serialport(port,baudrate,"Parity","none","Timeout", 30);
flush(fpga);

n_lecturas = 4;
data = zeros(n_lecturas,2);
%% Read data
for i = 1:n_lecturas
    data(i,:) = read(fpga,2,"uint8");
end
%% Close conection 
clear fpga;

% Default Configurations
    % "Parity","none" 
    % "DataBits",8
    % "StopBits",1
    % "FlowControl","none"
    % "ByteOrder","little-endian"
    % "Timeout", 10