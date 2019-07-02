function plot_george(Data, Labels)
% Author: Lucy Kuncheva 02/07/2019

cm = [0 0 0;0 1 0; 0 0 1]; % colour map
c = 769;
r = 391;
[x,y] = meshgrid(1:c,1:r); % grid for plotting

onenn = fitcknn(Data, Labels); % 1-nn classifier on the reference data
al = predict(onenn, [x(:) y(:)]); % classify the grid
gscatter(x(:), y(:), al, cm, '.', 8)
legend('off'), axis equal off
