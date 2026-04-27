function [nodal_stress, nodal_strain] = calculatePlasticStressStrain(nodes, elements, U, E, nu, sigma_y, H)
    % Initialize
    num_nodes = size(nodes,1);
    nodal_stress = zeros(num_nodes,1);
    nodal_strain = zeros(num_nodes,1);
    node_count = zeros(num_nodes,1);
    
    % Plane stress constitutive matrix
    D_elastic = E/(1-nu^2) * [1 nu 0; nu 1 0; 0 0 (1-nu)/2];
    
    % Material state variables (persistent across steps)
    persistent plastic_strain;
    if isempty(plastic_strain)
        plastic_strain = zeros(3, size(elements,1)); % [εp_xx; εp_yy; εp_xy] per element
    end
    
    for el = 1:size(elements,1)
        % Element setup (from your code)
        node_ids = elements(el,:);
        x = nodes(node_ids,1); y = nodes(node_ids,2);
        A = polyarea(x,y);
        b = [y(2)-y(3); y(3)-y(1); y(1)-y(2)]/(2*A);
        c = [x(3)-x(2); x(1)-x(3); x(2)-x(1)]/(2*A);
        B = [b(1) 0 b(2) 0 b(3) 0;
             0 c(1) 0 c(2) 0 c(3);
             c(1) b(1) c(2) b(2) c(3) b(3)];
        
        % Get displacements
        u_el = [U(2*node_ids(1)-1); U(2*node_ids(1));
                U(2*node_ids(2)-1); U(2*node_ids(2));
                U(2*node_ids(3)-1); U(2*node_ids(3))];
        
        % Total strain
        strain_total = B * u_el;
        
        % Plasticity calculation
        stress_trial = D_elastic * (strain_total - plastic_strain(:,el));
        [stress, plastic_strain(:,el)] = radialReturn(stress_trial, plastic_strain(:,el), D_elastic, sigma_y, H);
        
        % Von Mises stress and equivalent plastic strain
        vonMises = sqrt(stress(1)^2 - stress(1)*stress(2) + stress(2)^2 + 3*stress(3)^2);
        peeq = sqrt(2/3*(plastic_strain(1,el)^2 + plastic_strain(2,el)^2 + 2*plastic_strain(3,el)^2));
        
        % Accumulate to nodes
        nodal_stress(node_ids) = nodal_stress(node_ids) + vonMises;
        nodal_strain(node_ids) = nodal_strain(node_ids) + sqrt(strain_total(1)^2 + strain_total(2)^2 - strain_total(1)*strain_total(2));
        node_count(node_ids) = node_count(node_ids) + 1;
    end
    
    % Average nodal values
    nodal_stress = nodal_stress ./ node_count;
    nodal_strain = nodal_strain ./ node_count;
end