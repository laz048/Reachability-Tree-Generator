% Reachability Tree Generator
% by Lazaro Ramos
% 10/14/2022

function table = create_table(tree_matrix,marking_matrix)
% Function create_table, generates a table of the tree matrix with the
% markings and transitions labeled on the axis, as well as labeling each
% cell.

[num_places,~] = size(marking_matrix{1,1}); % Defining number of places.
% Defining number of transitions and markings.
[num_transitions,num_markings] = size(tree_matrix);

% Nested function to convert numbers in markings to text.
function [txt_matrix] = marking_to_text(input_matrix,matrix_type)

t_num = num_transitions; % Value changes, need new variable.
if (matrix_type == "marking") % Marking matrix is 1xn.
    t_num = 1;
end
txt_matrix = cell(1,num_markings); % Pre-allocating size.

for c = 1:num_markings % Loops through all the markings in the matrix
    % Loops through each transition in the tree, for the marking matrix it
    % only needs to do one pass since 1xn.
    for r = 1:t_num 
        % Only changing cells that contain a marking, needed for tree.
        if(any(input_matrix{r,c}))
            current_marking = input_matrix{r,c}; % Get the current marking.
            % Looping through marking_matrix to identify current marking.
            for marking_num = 1:num_markings
                if (current_marking == marking_matrix{1,marking_num})
                    string = "m" + marking_num + " = ( ";
                end
            end
            for p = 1:num_places % Appending each number to marking string.
                if (current_marking(p,1) == Inf) % Replace Inf by w.
                    string = string + "w ";
                else                
                    string = string + current_marking(p,1) + " ";
                end
            end
            string = string + ")";
            % Converting string to char to label the columns of the table.
            if (matrix_type == "marking")
                char = convertStringsToChars(string);
                txt_matrix{r,c} = char;
            else % Contents of table can be a string.
                txt_matrix{r,c} = string; % Replacing cell with string.
            end
        end
     end
end
end
% Calling nested function to convert matrices to text.
new_tree_matrix = marking_to_text(tree_matrix,"tree");
new_marking_matrix = marking_to_text(marking_matrix,"marking");

t_array = ""; % Transition array created to label the rows of the table.
for t_pos = 1:num_transitions
    t_array(t_pos,1) = "t" + t_pos;
end

table = cell2table(new_tree_matrix,"VariableNames",new_marking_matrix,...
    "RowNames",t_array);
end % End function
