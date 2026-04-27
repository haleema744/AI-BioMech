function Ke = localStiffnessTet1(coords, lambda, mu)
% Compute stiffness for 4-node tetrahedral element
X = [ones(4,1), coords];
V = abs(det(X))/6;
B = zeros(6,12);
for i = 1:4
    i1 = mod(i,4)+1; i2 = mod(i+1,4)+1; i3 = mod(i+2,4)+1;
end
a = [X(2,2)*X(3,3)-X(3,2)*X(2,3), X(3,2)*X(4,3)-X(4,2)*X(3,3), X(4,2)*X(2,3)-X(2,2)*X(4,3), X(2,2)*X(3,3)-X(3,2)*X(2,3)];
b = [X(3,3)-X(2,3), X(4,3)-X(3,3), X(2,3)-X(4,3), X(3,3)-X(2,3)];
c = [X(2,2)-X(3,2), X(3,2)-X(4,2), X(4,2)-X(2,2), X(2,2)-X(3,2)];
B = zeros(6,12);
for i = 1:4
    Bi = [b(i), 0, 0;
          0, c(i), 0;
          0, 0, a(i);
          c(i), b(i), 0;
          0, a(i), c(i);
          a(i), 0, b(i)];
    B(:,(i-1)*3+1:i*3) = Bi;
end
B = B / (6*V);
D = lambda*[1 1 1 0 0 0; 1 1 1 0 0 0; 1 1 1 0 0 0; 0 0 0 0 0 0; 0 0 0 0 0 0; 0 0 0 0 0 0] + ...
    2*mu*diag([1 1 1 0.5 0.5 0.5]);
Ke = V * (B' * D * B);
end