% Editing by a genetic algorithm
% ------------------------------------------------------------------------
% Input:
%    b -- the data set;
%    l -- the labels (vector with integers; labels must be: 1,2,...,c
%    PARAM.NumberOfPrototypes
%    PARAM.PopulationSize
%    PARAM.NumberOfGenerations
%
% Output
%     v: the set prototypes;
%     v_lab: prototype class labels
% ------------------------------------------------------------------------
% Author: Lucy Kuncheva 07/09/2019

function [v,v_lab] = edit_ga(b,l,PARAM)
m = PARAM.NumberOfPrototypes;
n = size(b,1);
all = 1:n; % all available prototypes

K = 40; % default population size
if isfield(PARAM,'PopulationSize')
   if ~isempty(PARAM.PopulationSize)
       K = PARAM.PopulationSize;
   end
end

T = 300; % default number of generations
if isfield(PARAM,'NumberOfGenerations')
   if ~isempty(PARAM.NumberOfGenerations)
       T = PARAM.NumberOfGenerations;
   end
end

% Initial population
P = zeros(K,m);
for i = 1:K
    P(i,:) = randperm(n,m);
    knn = fitcknn(b(P(i,:),:),l(P(i,:)));
    f(i) = mean(predict(knn,b) == l); % fitness
end

for i = 2:T    
    % Select parents and create offspring
    O = []; % offspring set
    for j = 1:K/2
        p1 = P(randi(K),:); % parent 1
        p2 = P(randi(K),:); % parent 2
        cop = randi(m); % cross-over point
        O = [O;[p1(1:cop) p2(cop+1:end)]; ... 
            [p2(1:cop) p1(cop+1:end)]]; % augment O (Offspring set0 with
        % the 2 children
    end

    % Mutate the offspring (one prototype in each chromosome)
    for j = 1:K
       to_mutate = randi(m);
       to_choose_from = setxor(all,O(j,:)); % n-m remaining prototypes
       replacement_index = randi(n-m); % index into to_choose_from
       O(j,to_mutate) = to_choose_from(replacement_index);
    end
    
    % Evaluate the offspring
    for j = 1:K
       knn = fitcknn(b(O(j,:),:),l(O(j,:)));
       f(j+K) = mean(predict(knn,b) == l); % fitness
    end    
    % Choose the new generation (elitist)
    G = [P;O];
    [Fitness,Index] = sort(f,'descend');
    P = G(Index(1:K),:);
    f = Fitness(1:K);
    
    if f(1) == 1 % All correct
        break
    end

end
v = b(P(1,:),:);
v_lab = l(P(1,:));

[v,q] = unique(v,'rows');
v_lab = v_lab(q);
