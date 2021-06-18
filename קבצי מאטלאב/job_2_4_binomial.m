clc
clear all
close all

f = 70500000;
N = 10
P = round(N/2);
lamda = (3e8)/f;
d = 2.1262;
k = 2*pi/lamda;
disp('')
theta = 0:0.01:2*pi;
U = k*d*cos(theta);
A = [0 0 0 0 0; 1 0 0 0 0; 1 1 0 0 0; 3 1 0 0 0;3 4 1 0 0; 10 5 1 0 0; 10 15 6 1 0;...
    35 21 7 1 0; 35 56 28 8 1; 126 84 36 9 1];
x = mod(N,2);
if x==0;
    AF=0;
    for n =1:5;
        AF=AF + A(N,n).*cos(((2*n-1)/2).*U);
    end
elseif x~=0;
    AF=0;
    for n=1:5;
        AF=AF +A(N,n).*cos((2*n-1)/2.*U);
    end 
end
W = abs(AF);
w = W/max(W);
figure;

polar(theta,w)
title('Normalized E-field polar Pattern of array Antenna in linear scaler')
figure;
afdb=20*log10(W);
afplot=(afdb+abs(afdb))/2;
polar(theta,afplot)
title('Non-normalized polar pattern of the array in db scale')
disp('')
HPBW=(1.06/(N-1)^0.5)*(180/pi)
Do=1.77*(N)*0.5

Do db=10*log10(5.5972)