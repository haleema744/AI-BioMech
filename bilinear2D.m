function [sigma_new, Ct, eps_p_new] = bilinear2D(sigma_old, eps, eps_p_old, C, sigma_y, Ep)
% 2D bilinear elastic-plastic update
% Inputs:
%   sigma_old  = 1x3 previous stress [sigma_xx, sigma_yy, sigma_xy]
%   eps        = 3x1 total strain [eps_xx; eps_yy; gamma_xy]
%   eps_p_old  = 3x1 previous plastic strain
%   C          = 3x3 elastic constitutive matrix
%   sigma_y    = yield stress
%   Ep         = plastic modulus
%
% Outputs:
%   sigma_new  = 3x1 updated stress
%   Ct         = 3x3 tangent modulus
%   eps_p_new  = 3x1 updated plastic strain

% Elastic trial strain
eps_trial = eps - eps_p_old;  % 3x1
sigma_trial = C * eps_trial;  % 3x1

% Compute equivalent von Mises stress
seq = sqrt(sigma_trial(1)^2 - sigma_trial(1)*sigma_trial(2) + sigma_trial(2)^2 + 3*sigma_trial(3)^2);

if seq <= sigma_y
    % Elastic step
    sigma_new = sigma_trial;
    Ct = C;
    eps_p_new = eps_p_old;
else
    % Plastic step (linear isotropic hardening)
    H = Ep;
    % Simplified scaling for demonstration
    beta = sigma_y / seq;
    sigma_new = beta * sigma_trial;       % scale stress to yield
    Ct = C*0;                             % placeholder tangent
    eps_p_new = eps - C\sigma_new;        % updated plastic strain
end
end
