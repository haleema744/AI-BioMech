function K_global = assembleGlobal(K_global, Ke, elemNodes)
    % K_global: The global stiffness matrix (sparse)
    % Ke: Element stiffness matrix (4x4)
    % elemNodes: The local element node indices (1x4)

    % Map local node DOFs to global DOFs (2 DOF per node)
    dofIndices = [2*elemNodes-1; 2*elemNodes]; % X and Y DOFs for each node
    dofIndices = dofIndices(:); % Flatten to a column vector (8x1)

    % Check if Ke is 4x4 (4 nodes, 2 DOF each)
    if size(Ke, 1) ~= 4 || size(Ke, 2) ~= 4
        error('Element stiffness matrix Ke should be 4x4 for 4-node elements.');
    end
    
    % Add the element stiffness matrix to the global stiffness matrix
    K_global(dofIndices, dofIndices) = K_global(dofIndices, dofIndices) + Ke;
end