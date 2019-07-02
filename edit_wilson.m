% Wilson's editing method
% ------------------------------------------------------------------------
% Input:
%    b -- the data set;
%    l -- the labels (unsorted vector with integers,
%               labels must be consecuitive: 1,2,...,max_cls)
%
% Output
%     v: the set of prototypes;
%     v_lab: prototype class labels (corresponding to these
%            in "classes")
%
% ------------------------------------------------------------------------
% Last 17/11/14

function [v,v_lab] = edit_wilson(b,l,~)
n = size(b,1);
lab = zeros(n,1);
for i = 1:n
    p = pdist2(b(i,:),b);
    [~,ind] = sort(p);
    lab(i) = mode(l(ind(2:4))); % assigned label by 3-nn, assuming that
    % ith objects is at position 1
end
mark = lab == l; % retained
v = b(mark,:);
v_lab = l(mark);


