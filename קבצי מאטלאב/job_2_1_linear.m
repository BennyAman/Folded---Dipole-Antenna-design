% %Create a linearArray with dipoleFolded element.
% Generated by MATLAB(R) 9.7 and Antenna Toolbox 4.1.
% Generated on: 07-Jun-2020 09:51:19

%% Array Properties 
%Define Array
arrayObject = linearArray;

arrayObject.NumElements = 4;

%Define Array Elements
Element1 = dipoleFolded;
arrayObject.Element = [Element1 ];

% Design array at frequency 70500000Hz
arrayObject = design(arrayObject,70500000,Element1);
%arrayObject Properties Changed
arrayObject.PhaseShift = 90;
arrayObject.Tilt = 180;

%Element1 Properties Changed
arrayObject.Element(1).Tilt = 180;
% Update load properties 
arrayObject.Element(1).Load.Impedance = 280;

%% Array Analysis 
% Show for linearArray
figure;
show(arrayObject) 
% Layout for linearArray
figure;
layout(arrayObject) 
% Pattern for linearArray
plotFrequency = 70500000; Termination = 50;
figure;
pattern(arrayObject, plotFrequency,'Termination',Termination);
%%
figure;
arrayFactor(arrayObject, plotFrequency);
%% Calculate the Directivity of Array
[Directivity] = pattern(arrayObject,plotFrequency,0,90)
% Calculate EH Fields of Array
[E,H] = EHfields(arrayObject,plotFrequency,[0;0;1])
% calculate BW and angels
[bw, angles] = beamwidth(arrayObject, plotFrequency, 0, 1:1:360)
%%
% Azimuth for linearArray
plotFrequency = 70500000; azRange = 0:5:360; Termination = 50;
figure;
pattern(arrayObject, plotFrequency,azRange,0,'Termination',Termination);
% Elevation for linearArray
plotFrequency = 70500000; elRange = 0:5:360; Termination = 50;
figure;
pattern(arrayObject, plotFrequency,0,elRange,'Termination',Termination);
%% Beam Scanning
c = physconst('lightspeed');
lambda = c/plotFrequency;
dx= 0.49*lambda;
scanangle = [120 0];
ps = phaseshift(plotFrequency,dx,scanangle,arrayObject.NumElements);
arrayObject.PhaseShift = ps;
patternazfig2 = figure;
pattern(arrayObject,plotFrequency,azRange,0,'CoordinateSystem','rectangular')
axis([0 180 -25 15])
%%
% Impedance for linearArray
freqRange = [63450000           64155000           64860000           65565000           66270000           66975000           67680000           68385000           69090000           69795000           70500000           71205000           71910000           72615000           73320000           74025000           74730000           75435000           76140000           76845000           77550000];
figure;
impedance(arrayObject, freqRange) 
% Sparameters for linearArray
freqRange = [63450000           64155000           64860000           65565000           66270000           66975000           67680000           68385000           69090000           69795000           70500000           71205000           71910000           72615000           73320000           74025000           74730000           75435000           76140000           76845000           77550000]; RefImpedance = 50;
figure;
rfplot(sparameters(arrayObject, freqRange,RefImpedance)); 
%% Calculate Return Loss of Array
figure;
returnLoss(arrayObject,60e6:1e6:70e6,72)

%% Grating Lobes ????? ????
arrayObject.ElementSpacing = lambda/2;
D_half_lambda = pattern(arrayObject,plotFrequency,azRange,0,'CoordinateSystem','rectangular');
arrayObject.ElementSpacing = 0.75*lambda;
D_three_quarter_lambda = pattern(arrayObject,plotFrequency,azRange,0,'CoordinateSystem','rectangular');
arrayObject.ElementSpacing = 1.5*lambda;
D_lambda = pattern(arrayObject,plotFrequency,azRange,0,'CoordinateSystem','rectangular');
patterngrating1 = figure;
plot(azRange,D_half_lambda,azRange,D_three_quarter_lambda,azRange,D_lambda,'LineWidth',1.5);
grid on
xlabel('Azimuth (deg)')
ylabel('Directivity (dBi)')
title('Array Pattern (Elevation = 0 deg)')
legend('d=\lambda/2','d=0.75\lambda','d=1.5\lambda','Location','best')
%% Grating Lobes ????
% Compared to the landa/2 spaced array, the 1.5 lamda spaced array shows 2 additional 
% equally strong peaks in the visible space - the grating lobes. 
% The 0.75 lamda  spaced array still has a single unique beam peak
% at zero scan off broadside (azimuthal angle of 90 deg). Scan this array off broadside
% to observe appearance of the grating lobes
arrayObject.ElementSpacing = 0.75*lambda;
azscan = 45:10:135;
scanangle = [azscan ;zeros(1,numel(azscan))];
D_scan = nan(numel(azscan),numel(azRange));
legend_string1 = cell(1,numel(azscan));
for i = 1:numel(azscan)
    ps = phaseshift(plotFrequency,dx,scanangle(:,i),arrayObject.NumElements);
    arrayObject.PhaseShift = ps;
    D_scan(i,:) = pattern(arrayObject,plotFrequency,azRange,0,'CoordinateSystem','rectangular');
    legend_string1{i} = strcat('scan = ',num2str(azscan(i)),' deg');
end
patterngrating2 = figure;
plot(azRange,D_scan,'LineWidth',1)
xlabel('Azimuth (deg)')
ylabel('Directivity (dBi)')
title('Scan Pattern for 0.75\lambda Spacing Array ((Elevation = 0 deg)')
grid on
legend(legend_string1,'Location','best')
