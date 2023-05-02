% Reachability Tree Generator
% by Lazaro Ramos
% 10/14/2022

function [tree_matrix,marking_matrix] = find_tree(I,O,m1)

    % Function find_tree is the main functionality of the program. It 
    % outputs two cell arrays, tree_matrix which stores the next marking
    % based on the current marking and enabled transition, and 
    % marking_matrix is used to keep track of all the markings.
    
    % Incidence matrix A is used for firing, incidence matrix A_mu is used
    % for finding all enabled transitions. A_mu is required when the petri
    % net is not pure. If the petri net is pure, both matrices are the 
    % same.
    [A,A_mu] = find_incidence_matrices(I,O);
    
    [num_places,num_transitions] = size(A);
    [num_pm1, num_1m1] = size(m1); % m1 must be num_pAx1.
    
    % Error Detection:
    if (num_pm1 ~= num_places)
        error('I and O must have the same number of places as m1')
    end
    if (num_1m1 ~= 1)
        error('Error: m1 must be an nx1 matrix')
    end
    
    incidence_matrix = A;
    incidence_matrix_mu = A_mu;
    initial_marking = m1;
    initial_mu = find_mu(incidence_matrix_mu,initial_marking);
    
    current_marking = initial_marking; % Stores the current marking.
    current_marking_num = 1; % Keeps track of current marking #.
    num_new_marking = 1; % Tracks total # of markings.
    all_enabled_transitions = initial_mu; % mu of all enabled transitions.
    
    % Reachability tree matrix in the format:
    % Each row represents the current transition.
    % Each columns represents the current marking.
    % Inside are the next markings where the current marking and transition
    % intersect.
    % For example, tree_matrix{4,2} contains the next marking after firing 
    % t2 from m4.
    tree_matrix = cell(num_transitions,1); % Pre-allocating matrix.
    
    % Cell array that contains all the markings.
    % Used to find existing markings.
    marking_matrix = {initial_marking};
    
    end_of_tree = 0; % Tree done when = 1
    
    while(end_of_tree == 0)
        for current_transition_num = 1:num_transitions
    
            % If next marking is found, store in tree_matrix, otherwise 
            % store empty marking.
            if (all_enabled_transitions(current_transition_num,1) == 1)
                % Firing one transition at a time.
                single_transition_mu = zeros(num_transitions,1);
                single_transition_mu(current_transition_num,1) = 1;
                % Finding the next marking after firing.
                next_marking = find_new_marking(current_marking,...
                    incidence_matrix,single_transition_mu);
                % Place marking in correct cell.
                tree_matrix{current_transition_num,current_marking_num}...
                    = next_marking;
                       
%             DEBUGGING ONLY
%             debug = 0;
%             if (current_marking == [])
%                 debug = 1;
%             end
    
                % Tree is traversed from here to replace markings with 
                % omega = Inf.
                % Parent marking of next marking.
                parent_marking = marking_matrix{1,current_marking_num};
                % Need original parent marking to loop through all parents
                % again in case omega is found
                parent_marking_og = parent_marking;
                find_next_parent = 0; % Needed since initial parent exists.
                % Needed to preserve the value of variables.
                current_marking_num_o = current_marking_num;
                current_transition_num_o = current_transition_num;
                top_of_tree = 0; % Set to 1 in last comparison.
                while(top_of_tree == 0)
    
                    % Find parent marking in tree_matrix.
                    if (find_next_parent)
                        [parent_marking,current_transition_num_o,...
                            current_marking_num_o] = find_parent_marking...
                            (tree_matrix,marking_matrix,parent_marking,...
                            current_transition_num_o,current_marking_num_o);
                    end % Found parent marking.
                    
                    % Comparing current marking to parent(s).
                    is_child_bigger = is_child_marking_bigger...
                        (num_places,next_marking,parent_marking);
                    
                    % Change token(s) to omega if child marking is bigger.
                    if (is_child_bigger)
                        next_marking = replace_by_omega(num_places,...
                            next_marking,parent_marking);
                        % Modify current marking if omega is found.
                        tree_matrix{current_transition_num,...
                            current_marking_num} = next_marking;
                        % When omega is found, loop through all parents 
                        % again to find additional omegas.
                        find_next_parent = 0;
                        parent_marking = parent_marking_og;
                        current_marking_num_o = current_marking_num;
                        current_transition_num_o = current_transition_num;
                    else
                        find_next_parent = 1;
                    end
                    % Used to find parent(s) after the initial one.
                    % Exit loop after comparing child to initial marking.
                    if (parent_marking == marking_matrix{1,1})
                        top_of_tree = 1;
                    end
                end % End of omega finder.
                
                old_marking = 0; % Checking if marking already exists.
                for a2 = 1:num_new_marking
                    if (marking_matrix{1,a2} == next_marking)
                        old_marking = 1;
                    end
                end
                % If new marking, store in marking_matrix.
                if (old_marking == 0)
                    num_new_marking = num_new_marking + 1;
                    marking_matrix{1,num_new_marking} = next_marking;
                end
    
            else % If no new marking is found, store 0 in tree_matrix cell.
                tree_matrix{current_transition_num,current_marking_num} = 0;
            end
        end % Finished firing all transitions for current marking.
        
        % If no new markings are found finish tree.
        if (num_new_marking == current_marking_num) 
            end_of_tree = 1;
        else % If new markings are found, find children of next marking.
            current_marking_num = current_marking_num + 1;
            current_marking = marking_matrix{1,current_marking_num};
            all_enabled_transitions = ...
            find_mu(incidence_matrix_mu,current_marking);
        end
    end % Tree generation complete.
end % Function done
