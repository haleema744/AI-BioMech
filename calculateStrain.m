% Define a function to calculate strain for a triangular element
function [ex, ey, gxy] = calculateStrain(coords, uXNodes, uYNodes)
    % Extract coordinates for the three vertices of the triangle
    x1 = coords(1, 1); y1 = coords(1, 2);
    x2 = coords(2, 1); y2 = coords(2, 2);
    x3 = coords(3, 1); y3 = coords(3, 2);
    
    % Displacements at the three vertices
    uX1 = uXNodes(1); uY1 = uYNodes(1);
    uX2 = uXNodes(2); uY2 = uYNodes(2);
    uX3 = uXNodes(3); uY3 = uYNodes(3);
    
    % Calculate the area of the triangle (using the determinant method)
    A = 0.5 * abs(x1*(y2 - y3) + x2*(y3 - y1) + x3*(y1 - y2));
    
    % Compute the derivatives of the shape functions
    B = (1 / (2 * A)) * [
        y2 - y3, y3 - y1, y1 - y2;
        x3 - x2, x1 - x3, x2 - x1
    ];
    
    % Compute the strain components using B matrix and displacements
    epsilon = B * [uX1; uX2; uX3; uY1; uY2; uY3];
    
    % Extract strain components
    ex = epsilon(1); % Normal strain in x-direction
    ey = epsilon(2); % Normal strain in y-direction
    gxy = epsilon(3); % Shear strain
    
end