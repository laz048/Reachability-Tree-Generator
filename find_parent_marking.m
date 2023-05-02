% Reachability Tree Generator
% by Lazaro Ramos
% 10/14/2022

function [new_parent,t_t,m_t] = find_parent_marking(tree_matrix,...
   marking_matrix,current_parent_marking,current_transition_num,...
   current_marking_num)

    % Function find_parent_marking finds the parent marking by looking
    % through the tree matrix and detecting the column based on the last
    % parent marking. The function returns the new parent and the location
    % of the last place it looked in the tree.

    [num_of_transitions,~] = size(tree_matrix);
    new_parent = current_parent_marking;

    for m_t = current_marking_num:-1:1
        for t_t = current_transition_num:-1:1
            if (~any(tree_matrix{t_t,m_t})) % Skipping empty tree cells
                continue;
            elseif (isequal(tree_matrix{t_t,m_t},current_parent_marking))
                new_parent = marking_matrix{1,m_t};
                break;
            end
        end
        if(~isequal(new_parent,current_parent_marking))
            break;
        end
        current_transition_num = num_of_transitions;
    end
end