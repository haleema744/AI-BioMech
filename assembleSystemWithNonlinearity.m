% Helper function to assemble nonlinear system
function [K, F_int] = assembleSystemWithNonlinearity(nodes, elements, U, D, thickness)
    num_nodes = size(nodes, 1);
    K = sparse(2*num_nodes, 2*num_nodes);
    F_int = zeros(2*num_nodes, 1);
    
    for el = 1:size(elements, 1)
        node_ids = elements(el, :);
        x = nodes(node_ids, 1);
        y = nodes(node_ids, 2);
        A = polyarea(x, y);
        
        % Shape function derivatives
        b = [y(2)-y(3); y(3)-y(1); y(1)-y(2)] / (2*A);
        c = [x(3)-x(2); x(1)-x(3); x(2)-x(1)] / (2*A);
        
        % Element displacements
        u_el = [U(2*node_ids-1); U(2*node_ids)];
        
        % Linear B-matrix
        B_linear = [b(1)  0     b(2)  0     b(3)  0;
                    0     c(1)  0     c(2)  0     c(3);
                    c(1)  b(1)  c(2)  b(2)  c(3)  b(3)];
        
        % Nonlinear B-matrix (additional terms)
        G = [b(1)  b(2)  b(3)  0     0     0;
             0     0     0      c(1)  c(2)  c(3);
             c(1)  c(2)  c(3)  b(1)  b(2)  b(3)];
        
        B_nonlinear = G' * diag([1 1 0.5]) * G * u_el;
        
        % Full B-matrix
        B = B_linear + B_nonlinear;
        
        % Stress and tangent stiffness
        stress = D * B_linear * u_el;
        K_geo = G' * diag([stress(1), stress(2), stress(3)]) * G * A * thickness;
        K_mat = B' * D * B * A * thickness;
        
        Ke = K_mat + K_geo;
        Fe_int = B' * stress * A * thickness;
        
        % Assembly
        dofs = [2*node_ids-1; 2*node_ids];
        K(dofs, dofs) = K(dofs, dofs) + Ke;
        F_int(dofs) = F_int(dofs) + Fe_int;
    end
end