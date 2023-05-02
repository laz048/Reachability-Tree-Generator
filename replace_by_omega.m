% Reachability Tree Generator
% by Lazaro Ramos
% 10/14/2022

function omega_marking = replace_by_omega(num_places,next_marking,parent_marking)

    % This function replace_by_omega replaces all places where the child
    % marking is larger than the parent marking by omega.

    omega_marking = next_marking;
    
    for current_place = 1:num_places
        if ( next_marking(current_place,1) > ...
                parent_marking(current_place,1) )
            omega_marking(current_place,1) = Inf;
        end
    end
end

