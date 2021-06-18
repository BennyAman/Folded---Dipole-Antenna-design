clc
clear all
close all

df = dipoleFolded('Length',2,'Width',0.05) % הגדרת האנטנה
freq = 70.5e6; % תדירות
[bw, angles] = beamwidth(df, freq, 0, 1:1:360) % חישוב זוויות ורוחב סרט
figure(1)
show(df); % הצגת האנטנה 
hold on
figure(2)
pattern(df, freq, 'Type', 'efield', 'Normalize', true); % עקום הקרינה
figure(3)
patternAzimuth(df, freq, [0 30 60]); % הצגת עקום הקרינה בשלוש זוויות שונות

