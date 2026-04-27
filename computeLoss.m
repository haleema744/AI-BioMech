%% Corrected Helper Functions
function [loss, gradients] = computeLoss(net, x_colloc, bc_points, bc_values, E, nu)
    [pde_loss, ~] = computePDE(net, x_colloc, E, nu);
    
    u_pred_bc = predict(net, bc_points);
    bc_loss = mean((extractdata(u_pred_bc(1,:))' - bc_values(:,1)).^2 + ...
              (extractdata(u_pred_bc(2,:))' - bc_values(:,2)).^2);
    
    loss = pde_loss + 10.0 * bc_loss;
    gradients = dlgradient(loss, net.Learnables);
end