% Reduced Nearest Neighbor (RNN) [Gates 1971]
% ------------------------------------------------------------------------
% Input:
%    b -- the data set;
%    l -- the labels (unsorted vector with integers,
%         labels must be consecuitive: 1,2,...,max_cls)
%
% Output
%     v: the set prototypes;
%     v_lab: prototype class labels (corresponding to these
%            in "classes")
% ------------------------------------------------------------------------
% [Gates 1971] The Reduced Nearest Neighbor Rule
%
% Author: Lucy Kuncheva 09/06/2019

function [v,v_lab] = edit_rnn(b,l,~)
[a,a_lab] = edit_hart(b,l,1); 
% Start with Hart's CNN set and minimise
N = size(a,1);
selected = 1:N;

flag = true; % errors in the classfification
while flag
    flag = false;
    newset = zeros(1,N);
    newset(selected) = 1;
    for i = 1:numel(selected)
        % Remove a point
        newset(selected(i)) = 0;
        knn = fitcknn(a(find(newset),:),a_lab(find(newset))); %#ok<*FNDSB>
        al = predict(knn,b);
        if mean(al~=l) > 0 % not consistent
            % return the point
            newset(selected(i)) = 1;
        else
            flag = true; % point removed, keep going
        end
    end    
    selected = find(newset); 
end

v = a(selected,:);
v_lab = a_lab(selected);
