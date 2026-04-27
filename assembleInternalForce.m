function F_int = assembleInternalForce(nodes, elements, stress)
    num_nodes = size(nodes, 2);
    F_int = zeros(2*num_nodes, 1);
    for e = 1:size(elements, 1)
        node_ids = elements(e,:);
        x = nodes(1, node_ids); y = nodes(2, node_ids);
        A = polyarea(x, y);
        b = [y(2)-y(3); y(3)-y(1); y(1)-y(2)]/(2*A);
        c = [x(3)-x(2); x(1)-x(3); x(2)-x(1)]/(2*A);
        B = [b(1) 0 b(2) 0 b(3) 0; 0 c(1) 0 c(2) 0 c(3); c(1) b(1) c(2) b(2) c(3) b(3)];
        f_e = B' * stress(:,e) * A;
        F_int([2*node_ids-1; 2*node_ids]) = F_int([2*node_ids-1; 2*node_ids]) + f_e;
    end
end