% Author: Lucy Kuncheva 01/07/2019
clear, clc, close all

load DataClean
load GeorgeTheFish

Methods = {'full_data','edit_hart', 'edit_wilson', 'edit_wilson_hart',...
    'edit_rnge', 'edit_rnn', 'edit_rmhc', 'edit_random', 'edit_ga'};

PARAM.NumberOfPrototypes = 20;
PARAM.PopulationSize = 10;
PARAM.NumberOfGenerations = 50;
PARAM.NumberOfTrials = 500;

Pr(7:9) = 20; % number of ptotoypes for the RMHC, MC1 and GA

for i = 1:numel(Methods)
    fprintf('Currently running %s.\n', Methods{i})
    PARAM.NumberOfPrototypes = Pr(i);
    
    tic
    if i > 1
        [R,R_lab] = feval(Methods{i}, Data, Labels, PARAM);
    else
        R = Data; R_lab = Labels;
    end
    
    knn = fitcknn(R,R_lab); % train 1-nn with the reduced prototype set
    al = predict(knn,GeorgeData); % acquire labels
    acc = mean(al == GeorgeLabels);
    count = size(R,1);
    tictoc = toc;
    st = 'Error %5.2f%% --- Number of prototypes %4i --- Time %6.3f\n\n';
    fprintf(st, (1 - acc)*100, count, tictoc)      
    
    subplot(3,3,i)
    plot_george(R, R_lab)
    title([Methods{i}, ' (', num2str(size(R,1)) ')'],'Interp','none')
    drawnow
end
