%% RS232 Conection
clear; close all; clc;

port = "COM9";
baudrate = 9600;
fpga = serialport(port,baudrate,"Parity","even");

%% Read data
data = read(fpga,4,"uint8");
lecture1 = data(1)*256 + data(2);
voltaje1 = lecture1 * (3.3/4095); %ch0
temp1 = (voltaje1 - 0.5)*100;

lecture2 = data(3)*256 + data(4);
voltaje2 = lecture2 * (3.3/4095); %ch1
temp2 = (voltaje2 - 0.5)*100;
%% Close conection 
clear fpga;

% Default Configurations
    % "Parity","none" 
    % "DataBits",8
    % "StopBits",1
    % "FlowControl","none"
    % "ByteOrder","little-endian"
    % "Timeout", 10