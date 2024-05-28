clear; clc; close all;

%%
Rref = 10e3;
Rtest = 5.6e3 + 300;
Vin = 3;
Vref = Rref*Vin/(Rtest+Rref);


clear;
Vin = 3;
Vref = 1.88;
Rref = 10e3;
I = Vref/Rref;
mux = 33e-3/I;
Rtest = Rref*Vin/Vref - Rref - mux*2;

%% Analis resistencia de multiplexor
Rtest = 3.3e3;
Vref = 2.21;
Rref = 10e3;
i = Vref/Rref;

Rmux = (3 - i*Rtest - Vref)/(2*i)
Vdac = i*Rtest + Vref + 2*i*Rmux;
Vrefm = (Rref/(Rref + (Rtest+(2*Rmux))))*3;