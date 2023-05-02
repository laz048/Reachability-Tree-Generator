% Reachability Tree Generator
% by Lazaro Ramos
% 10/14/2022

function child_marking_is_bigger = is_child_marking_bigger(num_places,child_marking,parent_marking)

    % Function is_child_marking_bigger compares the child marking to its
    % parent to determine if the child is bigger than the parent. To be
    % bigger the marking has to be greater in at least one place, and
    % must be equal in all the rest.

    is_place_smaller = 0;
    is_place_larger = 0;
    
    for current_place = 1:num_places
        if ( child_marking(current_place,1) == Inf)
            continue;
        end                    
        if ( child_marking(current_place,1) > ...
                parent_marking(current_place,1) )
            is_place_larger = 1;
        end
        if ( child_marking(current_place,1) < ...
                parent_marking(current_place,1) )
            is_place_smaller = 1;
        end
    end
    
    if (~is_place_smaller && is_place_larger)
        child_marking_is_bigger = 1;
    else
        child_marking_is_bigger = 0;
    end
end

