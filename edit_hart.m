% Hart's editing method CNN
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
% Author: Lucy Kuncheva 17/11/14

function [v,v_lab] = edit_hart(b,l,~)
n = size(b,1);
store = false(n,1); grabbag = true(n,1);
store(1) = true;
flag = true;
while sum(grabbag) > 0 && flag
    flag = false;
    for i = 1:n
        C = fitcknn(b(store,:),l(store));
        las = predict(C,b(i,:));
        ee = las~=l(i);
        if ee == 1
            store(i) = true;
            grabbag(i) = false;
            flag = true;
        end
    end
end

v = b(store,:);
v_lab = l(store);
