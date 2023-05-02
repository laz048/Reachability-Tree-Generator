% Reachability Tree Generator
% by Lazaro Ramos
% 10/14/2022

function M_prime = find_new_marking(current_marking,incidence_matrix,mu)
    
    % Function M-prime calculates the next marking using the incidence
    % matrix, current marking, and mu (enabled transition)
    
    M_prime = current_marking + incidence_matrix*mu;
end
