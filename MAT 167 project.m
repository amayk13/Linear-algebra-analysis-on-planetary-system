theta = [117.2, 303.6, 202.8, 23.4, 258.6, 137.4, 315.8, 214.6, 44, 268.7, 155.7, 329.1, 225.7, 66, 279];
cos_theta = cosd(theta); % Evaluates theta values in degrees
sin_theta = sind(theta);
e = 0.2056; % Eccentricity of Mercury
x = cos_theta./(1 + e*cos_theta); % Polar to cartesian coordinates formula 
y = sin_theta./(1 + e*cos_theta);
x = x';
y = y';

m = length(x); % The number of data equations

B = -ones(size(x)); % Creates matrix B that is 15 x 1
A = [x.^2, x.*y, y.^2, x, y]; % Creates the matrix A that is 15 x 5

A;

% Singular Value Decomposition (SVD) code
[U,S,V] = svd(A);
C = U' * B;
coefficient_y = [C(1)/S(1,1); C(2)/S(2,2); C(3)/S(3,3); C(4)/S(4,4); C(5)/S(5,5)];
coefficient_x = V * coefficient_y; % Solution

% Coefficients
a = coefficient_x(1)
b = coefficient_x(2)
c = coefficient_x(3)
d = coefficient_x(4)
e = coefficient_x(5)
f = 1

% Conic section function along with coefficients
F = @(x,y) a*x.^2 + b*x.*y + c*y.^2 + d*x + e*y + f;

plot(x,y, 'ok')
hold on % To combine plots
fimplicit(F) % Implicit function plot

% Part B (perturbation)

min_val = -0.0005; 
max_val = -min_val;

x_pert = x + min_val+rand(m,1)*(max_val-min_val)*100; % Multiplied by 100 to make perturbations visible on plot
y_pert = y + min_val+rand(m,1)*(max_val-min_val)*100;

B_pert = -ones(size(x_pert)); % Creates matrix B that is 15 x 1
A_pert = [x_pert.^2, x_pert.*y_pert, y_pert.^2, x_pert, y_pert]; % Creates the matrix A that is 15 x 5
A_pert;

% SVD
[U_pert,S_pert,V_pert] = svd(A_pert);
C_pert = U_pert' * B_pert;
coefficient_y_pert = [C_pert(1)/S_pert(1,1); C_pert(2)/S_pert(2,2); C_pert(3)/S_pert(3,3); C_pert(4)/S_pert(4,4); C_pert(5)/S_pert(5,5)];
coefficient_x_pert = V_pert * coefficient_y_pert;

% Coefficients
a_pert = coefficient_x_pert(1)
b_pert = coefficient_x_pert(2)
c_pert = coefficient_x_pert(3)
d_pert = coefficient_x_pert(4)
e_pert = coefficient_x_pert(5)
f_pert = 1

% Perturbed equation
F_pert = @(x_pert,y_pert) a_pert*x_pert.^2 + b_pert*x_pert.*y_pert + c_pert*y_pert.^2 + d_pert*x_pert + e_pert*y_pert + f_pert;

fimplicit(F_pert)
plot(x_pert,y_pert, 'xr') % plot the randomized data
hold off