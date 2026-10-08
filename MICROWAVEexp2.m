clc;
clear;
close all;

%% PARAMETERS
Z0 = 50;                 % Characteristic impedance (ohms)
ZL = 75;                 % Load impedance (ohms)

f = linspace(1e9,10e9,500);   % Frequency: 1 to 10 GHz
c = 3e8;                 % Speed of light
L = 0.05;               % Transmission line length (m)

%% WAVELENGTH AND PHASE
lambda = c./f;
beta = 2*pi./lambda;

%% REFLECTION COEFFICIENT
Gamma_L = (ZL-Z0)/(ZL+Z0);

%% S PARAMETERS
% Reflection at input
S11 = Gamma_L .* exp(-2j*beta*L);

% Transmission coefficient
S21 = (1+Gamma_L) .* exp(-1j*beta*L);

% Reciprocal network
S12 = S21;

% Output reflection
S22 = Gamma_L;

%% MAGNITUDE IN dB
S11_dB = 20*log10(abs(S11));
S21_dB = 20*log10(abs(S21));
S12_dB = 20*log10(abs(S12));
S22_dB = 20*log10(abs(S22));

%% PLOT S11
figure;
plot(f/1e9,S11_dB,'LineWidth',2);
grid on;
xlabel('Frequency (GHz)');
ylabel('|S_{11}| (dB)');
title('Input Reflection Coefficient S_{11}');

%% PLOT S21
figure;
plot(f/1e9,S21_dB,'LineWidth',2);
grid on;
xlabel('Frequency (GHz)');
ylabel('|S_{21}| (dB)');
title('Forward Transmission Coefficient S_{21}');

%% PLOT S12
figure;
plot(f/1e9,S12_dB,'LineWidth',2);
grid on;
xlabel('Frequency (GHz)');
ylabel('|S_{12}| (dB)');
title('Reverse Transmission Coefficient S_{12}');

%% PLOT S22
figure;
plot(f/1e9,S22_dB,'LineWidth',2);
grid on;
xlabel('Frequency (GHz)');
ylabel('|S_{22}| (dB)');
title('Output Reflection Coefficient S_{22}');

%% DISPLAY VALUES
fprintf('=====================================\n');
fprintf('MICROWAVE TWO-PORT S-PARAMETER ANALYSIS\n');
fprintf('=====================================\n');

fprintf('Characteristic Impedance = %.2f Ohm\n',Z0);
fprintf('Load Impedance = %.2f Ohm\n',ZL);
fprintf('Transmission Line Length = %.2f m\n',L);

fprintf('\nReflection Coefficient = %.3f\n',abs(Gamma_L));

fprintf('\nS-Parameter Results:\n');
fprintf('|S11| = %.3f\n',abs(S11(1)));
fprintf('|S21| = %.3f\n',abs(S21(1)));
fprintf('|S12| = %.3f\n',abs(S12(1)));
fprintf('|S22| = %.3f\n',abs(S22(1)));

fprintf('=====================================\n');