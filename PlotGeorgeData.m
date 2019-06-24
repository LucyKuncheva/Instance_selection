% Plot George data
% Lucy Kuncheva 24/06/2019

clear, clc, close all

cm = [0 0 0;0 1 0; 0 0 1]; % colour map

load GeorgeTheFish

[r,c,~] = size(im); % grid size
[x,y] = meshgrid(1:c,1:r); % grid for plotting

figure
subplot(221)
gscatter(GeorgeData(:,1), GeorgeData(:,2), GeorgeLabels, cm)
legend('off'), axis equal off
title('Full set')

load DataClean

subplot(222)
gscatter(Data(:,1), Data(:,2), Labels, cm, '.', 8)
legend('off'), axis equal off
title('Sampled data')

onenn = fitcknn(Data, Labels); % 1-nn classifier on the clean data
al = predict(onenn, [x(:) y(:)]); % classify the grid
subplot(223)
gscatter(x(:), y(:), al, cm)
legend('off'), axis equal off
title('1-nn regions with clean data')


load DataNoise

onenn = fitcknn(DataN, LabelsN); % 1-nn classifier on the noisy data
al = predict(onenn, [x(:) y(:)]); % classify the grid
subplot(224)
gscatter(x(:), y(:), al, cm)
legend('off'), axis equal off
title('1-nn regions with noisy data')





