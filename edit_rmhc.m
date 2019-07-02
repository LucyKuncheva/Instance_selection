% Random Mutation Hill Climbing (Skalak94, winner of Garcia12)
% ------------------------------------------------------------------------
% Input:
%    b -- the data set;
%    l -- the labels (vector with integers; labels must be: 1,2,...,c
%    PARAM.NumberOfPrototypes
%
% Output
%     v: the set prototypes;
%     v_lab: prototype class labels
% ------------------------------------------------------------------------

% Author: Lucy Kuncheva 07/09/2019

function [v,v_lab] = edit_rmhc(b,l,PARAM)

m = PARAM.NumberOfPrototypes;
n = size(b,1);
all = 1:n; % all available prototypes

K = 40; % default number of runs
if isfield(PARAM,'PopulationSize')
   if ~isempty(PARAM.PopulationSize)
       K = PARAM.PopulationSize; % number of runs
   end
end

T = 300; % default number of mutations
if isfield(PARAM,'NumberOfGenerations')
   if ~isempty(PARAM.NumberOfGenerations)
       T = PARAM.NumberOfGenerations;
   end
end

B = zeros(1,K);
for i = 1:K
    S = randperm(n,m);
    knn = fitcknn(b(S,:),l(S));
    best_ac = mean(predict(knn,b) == l);
    for j = 1:T
        Snew = S;
        to_mutate = randi(m);
        to_choose_from = setxor(all,S); % n-m remaining prototypes
        replacement_index = randi(n-m); % index into to_choose_from
        Snew(to_mutate) = to_choose_from(replacement_index);
        
        % Check fitness
        knn = fitcknn(b(Snew,:),l(S));
        ac = mean(predict(knn,b) == l);
        if ac >= best_ac
            S = Snew;
            best_ac = ac;
        end
    end
    B(i) = best_ac;
    BS(i,:) = S;
end
[~,index_best] = max(B);
v = b(BS(index_best,:),:);
v_lab = l(BS(index_best,:));
