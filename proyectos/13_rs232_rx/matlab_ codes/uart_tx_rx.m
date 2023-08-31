% Serial connection
% Port name:COM8
%
% Bluetooth connection 
% Device name:       Receptor (HC-06)
% Transmission rate: 115200 bps 
% Association pin: 1234
% Previamente ya debe estar emparejado el divece con la laptop.
%
% Envía una trama de 32 bits = 4 bytes. El primer byte transmitido y 
% recibido son los menos significativos.
% La paridad y baud rate se configuran en el modulo HC-06.
%
%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
close all; clear all; clc;
%bluetoothlist    %Find available Bluetooth devices.
%UART=bluetooth("Receptor",1); %Connect to Bluetooth Device, channel=1

%serialportlist   %List of serial ports conected
UART = serialport("COM15",115200);
%---------------------------------------------------------------------
for i=1:2000
    dataT(i,:) = [186 175 186 47]; %BA AF BA 2F     
    flush(UART); %Clear serial port device buffers    
    write(UART,dataT(i,:),"uint8");
    dataR(i,:) = read(UART,4,"uint8");
end

error=0;
for j=1:2000
    if dataR(j,:) ~= dataT(j,:)
        error=error+1;
    end
end
error
