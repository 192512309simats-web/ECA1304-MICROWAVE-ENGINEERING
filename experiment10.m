
clc;
clear;
close all;

% INPUT PARAMETERS
c = 3e8;
f0 = 2.4e9;
er = 4.4;
h = 1.6e-3;
W = 37.2e-3;
L = 28.8e-3;

% EFFECTIVE PERMITTIVITY
eeff = (er+1)/2 + (er-1)/2/sqrt(1+12*h/W);

% LENGTH EXTENSION
dL = 0.412*h*((eeff+0.3)*(W/h+0.264)) / ...
    ((eeff-0.258)*(W/h+0.8));

% RESONANT FREQUENCY
Leff = L + 2*dL;
fr = c/(2*Leff*sqrt(eeff));

% APPROXIMATE BANDWIDTH
lambda0 = c/f0;
FBW = 3.77*((er-1)/er^2)*(W/L)*(h/lambda0);
BW = FBW*fr;

% APPROXIMATE GAIN (typical patch estimate)
gain_dBi = 6;

% DISPLAY RESULTS
fprintf('\nMICROSTRIP PATCH ANTENNA SIMULATION\n');
fprintf('-----------------------------------\n');
fprintf('Design Frequency = %.3f GHz\n',f0/1e9);
fprintf('Effective Permittivity = %.3f\n',eeff);
fprintf('Resonant Frequency = %.3f GHz\n',fr/1e9);
fprintf('Estimated Bandwidth = %.2f MHz\n',BW/1e6);
fprintf('Fractional Bandwidth = %.2f %%\n',FBW*100);
fprintf('Assumed Typical Gain = %.1f dBi\n',gain_dBi);

% FREQUENCY RESPONSE: APPROXIMATE MODEL
f = linspace(2e9,2.8e9,1000);
delta = f-fr;
S11 = abs(delta)./sqrt(delta.^2+(1.5*BW).^2);
S11dB = 20*log10(max(S11,1e-6));

figure(1);
plot(f/1e9,S11dB,'LineWidth',2);
hold on;
yline(-10,'r--');
xline(fr/1e9,'k--');
grid on;
xlabel('Frequency (GHz)');
ylabel('S11 (dB)');
title('Estimated Antenna Resonance Response');
ylim([-40 0]);

% RADIATION PATTERN: APPROXIMATE E-PLANE
theta = linspace(0,2*pi,721);
k = 2*pi/lambda0;

E = abs(cos((k*L/2).*sin(theta)).*cos(theta));
E = E/max(E);

figure(2);
polarplot(theta,E,'LineWidth',2);
title('Normalized Approximate Radiation Pattern');

% 3D PATCH GEOMETRY
figure(3);
rectangle('Position',[0 0 W*1000 L*1000], ...
    'FaceColor',[0.3 0.7 0.9]);
axis equal;
grid on;
xlabel('Width (mm)');
ylabel('Length (mm)');
title('Rectangular Microstrip Patch Layout');

fprintf('Simulation completed.\n');
