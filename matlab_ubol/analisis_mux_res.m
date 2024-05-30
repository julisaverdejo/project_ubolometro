clear; clc; close all;

%% Analis de resistencia de multiplexor

Rtest = 1e3;
Vref = 2.66;
Rref = 10e3;
i = Vref/Rref;

Rmux = (3 - i*Rtest - Vref)/(2*i)
Vdac = i*Rtest + Vref + 2*i*Rmux;
Vrefm = (Rref/(Rref + (Rtest+(2*Rmux))))*3;