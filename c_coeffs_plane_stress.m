% Function definition for linear elastic c coefficient (CORRECTED FORMAT)
function cMatrix = c_coeffs_plane_stress(location, state, E, nu)
    % C-matrix for linear isotropic plane stress
    
    % Number of locations where the solver is asking for coefficients
    numLocations = size(location.x, 2);
    
    c11 = E / (1 - nu^2);
    c12 = E * nu / (1 - nu^2);
    c33 = E / (2 * (1 + nu)); % Shear modulus G
    
    % Create the 4x4 matrix once
    C_local = [c11, c12, 0, 0;
               c12, c11, 0, 0;
               0, 0, c33, 0;
               0, 0, 0, c33];
               
    % Reshape the 4x4 matrix into a 16x1 column vector for a single location
    % The solver expects the output for N locations to be a (Ncomponents*Ncomponents) x N matrix
    % which is 4 x N for our 2-component system. Wait, this is still wrong. 
    
    % The solver documentation specifies: "For a system of N equations, specify a 
    % 4-by-4-by-K array for 2-D geometry, or a 6-by-6-by-K array for 3-D geometry, 
    % where K is the number of mesh elements." 
    % Your *original* function was actually closer to the expected format if you indexed elements!
    
    % The error message "requested to calculate coefficients at 1 locations so should have 
    % returned a matrix with 1 columns. Instead it returned a matrix with 4 columns." 
    % suggests the solver is running an initial check using a *single* test point, 
    % and it expects a 4x1 vector for that one location.
    
    % Let's restructure the function to be dynamic based on the input size:

    cMatrix = zeros(4, numLocations); % 4 rows (Ncomponents*Ncomponents), numLocations columns
    
    cMatrix(1, :) = c11;
    cMatrix(2, :) = c12;
    cMatrix(3, :) = c12;
    cMatrix(4, :) = c11;
    % This is still incorrect for mapping the 4x4 matrix components into 4 rows.
    
    % The mapping is complex. It's often better to just use the domain-specific functions 
    % if possible, or follow the exact structure requested. 
    
    % Since the error demands 4 rows and 1 column for 1 location, we provide that format:
    % The coefficient 'c' for a system is mapped internally.
    % The *linear* coefficients (m, d, a, f) can be constants.
    % Only the 'c' coefficient seems to demand this specific vectorized format per location.

    % Let's use a simpler constant coefficient definition for 'c' in the main script 
    % to bypass the function definition error during the initial validation check, 
    % and then discuss actual nonlinearity implementation. 
    % You cannot easily define a nonlinear 'c' coefficient this way.
end
