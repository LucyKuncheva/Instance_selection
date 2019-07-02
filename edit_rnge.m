% Sanchez et al's editing method RNGE (editing)
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
% [Sanchez et al. 1997] Prototype selection for the nearest neighbour rule
% through proximity graphs
%
% Author: Lucy Kuncheva 09/06/2019

function [v,v_lab] = edit_rnge(b,l,~)
g = relative_neighbourhood_graph(b); % create the RNG (graph)
to_delete = zeros(size(b,1),1);
for i = 1:numnodes(g)
    to_delete(i) = mode(l(neighbors(g,i))) ~= l(i);
end
v = b; v_lab = l;
to_delete = logical(to_delete);
v(to_delete,:) = [];
v_lab(to_delete) = [];
end

function [g,A] = relative_neighbourhood_graph(data)
% WIKIPEDIA: In computational geometry, the relative neighborhood graph 
% (RNG) is an undirected graph defined on a set of points in the 
% Euclidean plane by connecting two points p and q by an edge whenever 
% there does not exist a third point r that is closer to both p and q 
% than they are to each other. 
%
% Author: Lucy Kuncheva 09/07/2019

d = squareform(pdist(data));
N = size(data,1); % number of points
A = zeros(N); % adjacency matrix

for i = 1:N-1
    for j = i+1:N
        ni = d(i,:) < d(i,j); 
        nj = d(:,j) < d(i,j);
        % The intersection of the the two must be empty to include the edge
        % in the RNG graph
        A(i,j) = ~(ni * nj);
        A(j,i) = A(i,j);
    end
end
g = graph(A); 
end