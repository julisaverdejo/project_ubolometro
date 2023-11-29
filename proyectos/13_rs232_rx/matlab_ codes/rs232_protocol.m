% Clean up
clear; close all; clc;

% Open and setup COM port
com = "COM12";
% com = "COM13";
% com = "COM14";
% com = "COM4";
baud = 9600;
fpga = serialport(com,baud,"Timeout",10,"Parity","none");

% Write data
value = 129;
write(fpga,value,"uint8");
% for j = 1:1000
%     for i = 0:255
%         write(fpga,i,"uint8");
%     end
% end

% for i=1:2000
%     dataT(i,:) = 81; %BA AF BA 2F     
%     flush(fpga); %Clear serial port device buffers    
%     write(fpga,dataT(i,:),"uint8");
% end
%% read data
% data = read(fpga,1,"uint8");
% data_char = char(data)  
% Close COM port
clear fpga;