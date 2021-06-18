clc
clear all
close all

df = dipoleFolded('Length',2,'Width',0.05) % ����� ������
freq = 70.5e6; % ������
[bw, angles] = beamwidth(df, freq, 0, 1:1:360) % ����� ������ ����� ���
figure(1)
show(df); % ���� ������ 
hold on
figure(2)
pattern(df, freq, 'Type', 'efield', 'Normalize', true); % ���� ������
figure(3)
patternAzimuth(df, freq, [0 30 60]); % ���� ���� ������ ����� ������ �����

