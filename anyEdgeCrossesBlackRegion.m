%% ==================== HELPER FUNCTION ====================
function crosses = anyEdgeCrossesBlackRegion(triangleVertices, binaryImage)
    % Check if any edge of the triangle crosses the black region
    crosses = false;
    
    % Define the three edges
    edges = [1, 2; 2, 3; 3, 1];
    
    for e = 1:3
        p1 = triangleVertices(edges(e, 1), :);
        p2 = triangleVertices(edges(e, 2), :);
        
        % Sample points along the edge
        num_samples = 10;
        x_samples = linspace(p1(1), p2(1), num_samples);
        y_samples = linspace(p1(2), p2(2), num_samples);
        
        % Check if any sample point is in black region
        for s = 1:num_samples
            x_round = round(x_samples(s));
            y_round = round(y_samples(s));
            
            % Ensure indices are within bounds
            if x_round >= 1 && x_round <= size(binaryImage, 2) && ...
               y_round >= 1 && y_round <= size(binaryImage, 1)
               
                if binaryImage(y_round, x_round) == 0
                    crosses = true;
                    return;
                end
            end
        end
    end
end