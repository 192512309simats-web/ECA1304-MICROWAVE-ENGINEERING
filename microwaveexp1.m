clc;
clear;
close all;

% Microwave parameters
c = 3e8;              % Speed of light
f = 10e9;             % Frequency = 10 GHz

% Rectangular waveguide dimensions
a = 22.86e-3;         % Width
b = 10.16e-3;         % Height

% Wavelength
lambda = c/f;

% Grid
x = linspace(0,a,100);
y = linspace(0,b,100);
[X,Y] = meshgrid(x,y);

%% TEM MODE
% TEM has zero cut-off frequency
fc_TEM = 0;

% Simple electric field representation
E_TEM = cos(pi*X/a);

figure;
surf(X*1000,Y*1000,E_TEM);
shading interp;
xlabel('x (mm)');
ylabel('y (mm)');
zlabel('Electric Field');
title('TEM Mode');
colorbar;
view(2);

%% TE10 MODE
m = 1;
n = 0;

fc_TE10 = (c/2)*sqrt((m/a)^2+(n/b)^2);

E_TE10 = sin(pi*X/a);

figure;
surf(X*1000,Y*1000,E_TE10);
shading interp;
xlabel('x (mm)');
ylabel('y (mm)');
zlabel('Electric Field');
title('TE_{10} Mode');
colorbar;
view(2);

%% TM11 MODE
m = 1;
n = 1;

fc_TM11 = (c/2)*sqrt((m/a)^2+(n/b)^2);

E_TM11 = sin(pi*X/a).*sin(pi*Y/b);

figure;
surf(X*1000,Y*1000,E_TM11);
shading interp;
xlabel('x (mm)');
ylabel('y (mm)');
zlabel('Electric Field');
title('TM_{11} Mode');
colorbar;
view(2);

%% Display Results
fprintf('-------------------------------------\n');
fprintf('MICROWAVE MODE ANALYSIS\n');
fprintf('-------------------------------------\n');

fprintf('Operating Frequency = %.2f GHz\n',f/1e9);
fprintf('Wavelength = %.2f mm\n\n',lambda*1000);

fprintf('TEM Cut-off Frequency  = %.2f GHz\n',fc_TEM/1e9);
fprintf('TE10 Cut-off Frequency = %.2f GHz\n',fc_TE10/1e9);
fprintf('TM11 Cut-off Frequency = %.2f GHz\n',fc_TM11/1e9);

fprintf('\nPropagation at 10 GHz:\n');

if f > fc_TE10
    fprintf('TE10 : PROPAGATING\n');
else
    fprintf('TE10 : NOT PROPAGATING\n');
end

if f > fc_TM11
    fprintf('TM11 : PROPAGATING\n');
else
    fprintf('TM11 : NOT PROPAGATING\n');
end

fprintf('TEM  : PROPAGATING (no cut-off frequency)\n');