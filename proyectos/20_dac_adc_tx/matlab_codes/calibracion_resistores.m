clear; close all; clc;
format shortG

Vdac = 0:0.1:3;
Rref = [10,1e3,10e3,22e3,33e3,100e3,300e3];
Rprue = [10,100,330,1e3,2.2e3,4.7e3,10e3,33e3,100e3,1e6,10e6,30e6];

%%
Vadc_10 = zeros(31,12);
Vadc_1k = zeros(31,12);
Vadc_10k = zeros(31,12);
Vadc_22k = zeros(31,12);
Vadc_33k = zeros(31,12);
Vadc_100k = zeros(31,12);
Vadc_300k = zeros(31,12);

%%
i_10 = zeros(31,12);
i_1k = zeros(31,12);
i_10k = zeros(31,12);
i_22k = zeros(31,12);
i_33k = zeros(31,12);
i_100k = zeros(31,12);
i_300k = zeros(31,12);

%%
for r = 1:numel(Rprue)
    for v = 1:numel(Vdac)
        Vadc_10(v,r) = (Rref(1)/(Rref(1)+Rprue(r)))*Vdac(v);
        i_10(v,r) = Vadc_10(v,r)/Rref(1);
    end
end

%%
for r = 1:numel(Rprue)
    for v = 1:numel(Vdac)
        Vadc_1k(v,r) = (Rref(2)/(Rref(2)+Rprue(r)))*Vdac(v);
        i_1k(v,r) = Vadc_1k(v,r)/Rref(2);
    end
end

%%
for r = 1:numel(Rprue)
    for v = 1:numel(Vdac)
        Vadc_10k(v,r) = (Rref(3)/(Rref(3)+Rprue(r)))*Vdac(v); 
        i_10k(v,r) = Vadc_10k(v,r)/Rref(3);        
    end
end

%%
for r = 1:numel(Rprue)
    for v = 1:numel(Vdac)
        Vadc_22k(v,r) = (Rref(4)/(Rref(4)+Rprue(r)))*Vdac(v);
        i_22k(v,r) = Vadc_22k(v,r)/Rref(4);        
    end
end

%%
for r = 1:numel(Rprue)
    for v = 1:numel(Vdac)
        Vadc_33k(v,r) = (Rref(5)/(Rref(5)+Rprue(r)))*Vdac(v); 
        i_33k(v,r) = Vadc_33k(v,r)/Rref(5);        
    end
end

%%
for r = 1:numel(Rprue)
    for v = 1:numel(Vdac)
        Vadc_100k(v,r) = (Rref(6)/(Rref(6)+Rprue(r)))*Vdac(v); 
        i_100k(v,r) = Vadc_100k(v,r)/Rref(6);        
    end
end
%%
for r = 1:numel(Rprue)
    for v = 1:numel(Vdac)
        Vadc_300k(v,r) = (Rref(7)/(Rref(7)+Rprue(r)))*Vdac(v);
        i_300k(v,r) = Vadc_1k(v,r)/Rref(7);        
    end
end