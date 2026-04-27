function [F_int, K_T] = assembleNonlinearSystem(nodes, elements, u, E, nu, thickness)
    numNodes = size(nodes,2);
    numElements = size(elements,2);
    
    F_int = zeros(2*numNodes, 1);
    K_T = zeros(2*numNodes, 2*numNodes);
    
    % Plane stress elasticity matrix
    C = E/(1-nu^2) * [1, nu, 0; nu, 1, 0; 0, 0, (1-nu)/2];
    
    for e = 1:numElements
        % Element nodes and displacements
        nodeIDs = elements(:,e);
        nodeCoords = nodes(:,nodeIDs);
        u_e = [u(nodeIDs*2-1); u(nodeIDs*2)];  % [ux1, uy1, ux2, uy2, ux3, uy3]
        
        % Gauss points (1-point integration for simplicity)
        [~, dNdx, ~, detJ] = computeShapeFunctions(nodeCoords);
        
        % Deformation gradient (F = I + ∇u)
        F = eye(2) + [u_e(1:2:end), u_e(2:2:end)]' * dNdx;
        
        % Green-Lagrange strain (E = 0.5*(F'F - I))
        E_GL = 0.5*(F'*F - eye(2));
        
        % 2nd Piola-Kirchhoff stress (S = C:E_GL)
        S_voigt = C * [E_GL(1,1); E_GL(2,2); 2*E_GL(1,2)];  % Voigt notation
        
        % Internal force (F_int = ∫ B^T S dV)
        B = computeStrainDisplacementMatrix(dNdx, F);
        F_int_e = B' * S_voigt * detJ * thickness;
        
        % Tangent stiffness (K_T = ∫ B^T C B dV + geometric stiffness)
        K_T_e = B' * C * B * detJ * thickness;
        
        % Assemble into global matrices
        dofs = [nodeIDs*2-1, nodeIDs*2];
        F_int(dofs) = F_int(dofs) + F_int_e;
        K_T(dofs, dofs) = K_T(dofs, dofs) + K_T_e;
    end
end