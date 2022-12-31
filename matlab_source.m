%% Clearing workspace
clc; % clear command line
clear all; % clear workspace variables
%% Declaring symbolic functions
syms y(x) ... % The ODE dy/dx function
    k1(xk,yk) k2(xk,yk) k3(xk, yk) k3(xk, yk); % The auxiliary quantities used in RK4 method
%% Inputs
N = input('Enter the number of mesh points: ');
fun = input('Enter the function: ');
X0 = input('Enter the initial starting point: ');
XF = input('Enter the end point: ');
Y0 = input('Enter the initial solution of the function: ');
%% Processing and initializing variables, symbolic variables and functions
h = (XF - X0) / N; % Calculating step
% Calculating the auxiliary quantities
k1(xk, yk) = h * subs(fun, [x, y(x)], [xk, yk]);
k2(xk, yk) = h * subs(fun, [x, y(x)], [xk + h / 2, yk + k1(xk, yk) / 2]);
k3(xk, yk) = h * subs(fun, [x, y(x)], [xk + h / 2, yk + k2(xk, yk) / 2]);
k4(xk, yk) = h * subs(fun, [x, y(x)], [xk + h, yk + k3(xk, yk)]);
YF = zeros(1, N); % Initializing the vector of the numerical solutions
MP = zeros(1, N); % Initializing the vector of the mesh points
YF(1) = Y0; % Equalling to the initial value
MP(1) = X0; % Equalling to the first point
% Solving the equation as a first order ODE
ode = diff(y,x) == fun;
cond = y(0) == 1;
ySol(x) = dsolve(ode, cond);
%% Main loop to find the numerical solution
for i = 2:(N+1)
   YF(i) = YF(i - 1) + (1/6) * (k1(MP(i - 1), YF(i - 1)) + 2 * k2(MP(i - 1), YF(i - 1)) + 2 * k3(MP(i - 1), YF(i - 1)) + k4(MP(i - 1), YF(i - 1)));
   MP(i) = MP(i - 1) + h;
end
%% Printing the output
% The first column is the solution by RK4 method, second column is exact
% solution, third column is the absolute error between exact and numerical
% solution
fprintf('RK4          Exact          Absolute Error\n');
for ind=1:(N+1)
	fprintf('%f          %f          %f\n',YF(ind), subs(ySol, x, MP(ind)), abs(YF(ind) - subs(ySol, x, MP(ind))))
end
