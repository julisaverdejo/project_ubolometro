%% RS232 Conection
clear; close all; clc;

port = "COM8";
baudrate = 9600;
fpga = serialport(port,baudrate,"Parity","even");

%% Read data
data = read(fpga,960*15,"uint8");
%% Close conection 
clear fpga;

% Default Configurations
    % "Parity","none" 
    % "DataBits",8
    % "StopBits",1
    % "FlowControl","none"
    % "ByteOrder","little-endian"
    % "Timeout", 10