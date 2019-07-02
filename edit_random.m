% Random editing (Monte Carlo 1 in Skalak94)
% ------------------------------------------------------------------------
% Input:
%    b -- the data set;
%    l -- the labels (vector with integers; labels must be: 1,2,...,c
%    PARAM.NumberOfPrototypes
%    PARAM.NumberOfTrials
%
% Output
%     v: the set prototypes;
%     v_lab: prototype class labels
% ------------------------------------------------------------------------
% Author: Lucy Kuncheva 07/09/2019

function [v,v_lab] = edit_random(b,l,PARAM)
n = size(b,1);
m = PARAM.NumberOfPrototypes;
T = 12000; % number of trials
if isfield(PARAM,'NumberOfTrials')
   if ~isempty(PARAM.NumberOfTrials)
       T = PARAM.NumberOfTrials;
   end
end

best_ac = 0;
for i = 1:T
    if ~mod(i,600)
        fprintf('.')
        if PARAM.Verbose
            fprintf(' %5i %.4f\n', i, 1-best_ac)
        end

    end
    Snew = randperm(n,m);
    knn = fitcknn(b(Snew,:),l(Snew));
    ac = mean(predict(knn,b) == l);
    if ac > best_ac
        S = Snew;
        best_ac = ac;
    end
end
v = b(S,:);
v_lab = l(S,:);
