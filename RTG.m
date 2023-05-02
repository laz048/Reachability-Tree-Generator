% Reachability Tree Generator
% by Lazaro Ramos
% 10/14/2022

% HOW TO USE %
% (1) Provide I and O of any petri net (with transitions as columns and
% places as rows)
% (2) Provide the initial marking in the matrix m1(nx1)
% (3) Run
% (4) Output is a table, where the rows are the arcs, the columns are the
% parent nodes, and inside each cell is the child node. E.g. table(3,2) contains
% the child node after firing transition t3 from marking (parent node) m2.
% An empty cell means no child node exists for that marking and transition.

% Case 1 ( PN not pure )
m1 = [1;7;1];
I = [1 1 0 0;0 0 1 1;1 0 1 1];
O = [0 1 0 1;2 0 1 0;1 1 0 0];

% Case 2 ( Pure PN )
% m1 = [1;0;0;1;0];
% I = [1 0 0 0;0 1 0 0;0 0 1 0;0 0 1 0;0 0 0 1];
% O = [0 1 0 0;1 0 0 0;0 1 0 0;0 0 0 1;0 0 1 0];

% Case 3 ( Pure PN )
% m1 = [1;0;10;1;0;0]
% I = [1 0 0 0;0 1 0 0;0 0 10 0;0 0 1 0;0 0 0 1;0 1 0 0];
% O = [0 1 0 0;1 0 0 0;0 10 0 0;0 0 0 1;0 0 1 0;0 0 1 0];


%%%%%%%%%%%%%%%%% DO NOT MODIFY AFTER THIS LINE %%%%%%%%%%%%%%%%%
[tree_matrix,marking_matrix] = find_tree(I,O,m1);
table = create_table(tree_matrix,marking_matrix)
