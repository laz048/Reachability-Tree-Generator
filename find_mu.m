% Reachability Tree Generator
% by Lazaro Ramos
% 10/14/2022

function mu = find_mu(incidence_matrix,current_marking)
    % This function generates mu, an nx1 vector with all enabled
    % transitions. To generate the mu matrix, we first check each
    % transition column for negative values (places that output to
    % transitions). Then we add each place in the marking M to the negative
    % values. If for all the places that contain a negative value the sum
    % is >= to zero, that transition can fire.
    
    % Obtaining the number of places and transitions
    [num_pA,num_tA] = size(incidence_matrix); 
    
    mu = zeros(num_tA,1); % Initializing mu.
    for a=1:num_tA % Loops through all the transitions.
        num_ninputs = 0; % Counts negative inputs in each column of A.
        num_additions = 0; % Counts each sum >= to zero.
        for b=1:num_pA % Loops through all the places.
            % Checks which values in A are negative.
            if(incidence_matrix(b,a) < 0) 
            num_ninputs = num_ninputs + 1;
                % Checks if sum is >= to zero.
                if ((incidence_matrix(b,a) + current_marking(b,1)) >= 0) 
                    num_additions = num_additions + 1;
                end
            end
        end
        % If for the entire transition all the sums are >= to zero, then 
        % that transition is enabled (can fire).
        if ((num_ninputs ~= 0) && (num_additions ~= 0))
            if (num_ninputs == num_additions)
                mu(a,1) = 1;
            end
        end
    end
end
