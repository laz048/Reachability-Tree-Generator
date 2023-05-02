function [A,A_mu] = find_incidence_matrices(I,O)
    
    % Function find_incidence_matrices finds two incidence matrices using I
    % and O. A = O-I. A_mu is the same as A except that for any loops
    % found (when the PN is not pure), A_mu will store a negative value for
    % the input arcs to transitions that are missing from A.

    [r_I,c_I] = size(I);
    [r_O,c_O] = size(O);

    % Error Detection:
    if (r_I ~= r_O) || (c_I ~= c_O)
        error('Error: I and O must have the same size.')
    end
    
    A = zeros(r_I,c_I);
    A_mu = zeros(r_I,c_I);
    loop_found = 0;
    for c1 = 1:c_I
        for r1 = 1:r_I
            % Loop is detected here and replaced by a negative
            if ((O(r1,c1) == I(r1,c1)) && (O(r1,c1) ~= 0) && (I(r1,c1)...
                    ~= 0))
                loop_found = 1;
                A_mu(r1,c1) = -1*O(r1,c1);
            end
            A(r1,c1) = O(r1,c1) - I(r1,c1);
            if(loop_found == 0)
                A_mu(r1,c1) = O(r1,c1) - I(r1,c1);
            end
            loop_found = 0;
        end
    end
end

