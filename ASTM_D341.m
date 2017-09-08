% This script uses ASTM D341-09(2015) to extrapolate or interpolate fluid viscosity based
% off of 2 manufacturer reported visocity measurements.
%
% This is just a single-run script, it can be modified easily to function
% format to be called in other programs.
%
% Code: (c) 2017 Jeremy ven der Buhs
% Referene: ASTM D341-09(2015)

% ASTM D445 Reported Viscosities, Mobil Nuto(TM) H68 used here.
T_1 = 100; % Celcius
nu_1 = 8.5; % cSt
T_2 = 40; % Celcius
nu_2 = 68.0; % cSt

% What temperature would you like viscosity computed at?

T_desired = 60; % Celcius

% Solve for constants A and B

Z_1 = nu_1 + 0.7 + exp(-1.47 - 1.84*nu_1 - 0.51*nu_1^2); % Equation A1.2
Z_2 = nu_2 + 0.7 + exp(-1.47 - 1.84*nu_2 - 0.51*nu_2^2); % Equation A1.2

Y = [log10(log10(Z_1)) ; log10(log10(Z_2))]; % From Equation A1.1

C = [ 1 -log10(T_1 + 273.15);
      1 -log10(T_2 + 273.15)]; % From Equation A1.1

X = C^(-1)*Y; % Solve for A and B in Equation A1.1

A = X(1);
B = X(2);

% Solve for Z for the desired temperature
Z = 10^(10^(A - B*log10(T_desired + 273.15))); % Equation A1.1


% Compute desired viscosity
nu_desired = (Z - 0.7) - exp(-0.7487 - 3.295*(Z - 0.7) + 0.6119*(Z - 0.7)^2 - 0.3193*(Z - 0.7)^3); % Equation A1.3

% Display result to the user
disp(['nu = ' num2str(nu_desired) ' cSt']);
