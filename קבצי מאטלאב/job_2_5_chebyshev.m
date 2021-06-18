clc
clear all
close all

%% Dolph_Chebyshev_array_1
f = 70500000;
N = 10;
lamda = (3e8)/f %lamda = c/f % this value in meters
d = 2.1262;
k = 2*pi/lamda; % ווקטור הגל
disp(' ')
theta = 0:0.01:180;
U = (0.5*k*d)*cos(theta*pi/180);
R0db = 13.5; % r — Sidelobe attenuation on db
c = chebwin(N,R0db);
b = c';
x = mod (N,2);
if x==0
    for i=1:(N/2);
        a(i) = b((N/2)+i);
    end
elseif x~=0;
    for i = 0 : floor( N/2);
        a(1+i)=b(round(N/2)+i);
    end
end
if x==0;
    AF=0;
    for n=1:N/2;
        AF=AF+a(n).*cos(((2*n-1))*U);
    end
elseif x~=0;
   AF=0;
   for n=1:round(N/2);
       AF=AF+a(n).*cos((2*(n-1))*U);
   end
end
v = polarpattern(theta,abs(AF));
title('Pattern of array in linear scale.')
figure;
AFdb = 20*log10(abs(AF));
p = polarpattern(theta,AFdb);
title('Pattern of array in db scale.')

