
clc;
clear;
close all;

%% Electromagnetic Simulation and S-Parameter Characterization
% Microwave Directional Coupler and Two-Way Power Divider
% Idealized transmission-line model

f0 = 2.4e9;                 % Design frequency: 2.4 GHz
f = linspace(1.5e9, 3.3e9, 501);
fn = f/f0;                  % Normalized frequency
freqGHz = f/1e9;

%% PART 1: MICROWAVE DIRECTIONAL COUPLER

% Design parameters
Coupling_dB = 10;           % Coupling level
Directivity_dB = 25;        % Directivity

k0 = 10^(-Coupling_dB/20);
isolation0 = 10^(-(Coupling_dB + Directivity_dB)/20);

% Frequency-dependent coupled-wave model
theta = (pi/2)*fn;
k = k0 .* sin(theta);
k = min(abs(k), 0.99);

% Through and coupled port amplitudes
S31 = k;
S21 = sqrt(1 - k.^2);

% Simplified reflection and isolation models
S11 = 0.03 .* abs(fn - 1);
S41 = isolation0 .* ones(size(f));

% Convert magnitudes into dB
S11_dB = 20*log10(max(S11, 1e-6));
S21_dB = 20*log10(max(S21, 1e-6));
S31_dB = 20*log10(max(S31, 1e-6));
S41_dB = 20*log10(max(S41, 1e-6));

figure('Name','Directional Coupler S-Parameters');

plot(freqGHz,S11_dB,'LineWidth',1.8);
hold on;
plot(freqGHz,S21_dB,'LineWidth',1.8);
plot(freqGHz,S31_dB,'LineWidth',1.8);
plot(freqGHz,S41_dB,'LineWidth',1.8);
grid on;

xlabel('Frequency (GHz)');
ylabel('Magnitude (dB)');
title('Directional Coupler S-Parameter Response');
legend('S11 - Reflection','S21 - Through',...
       'S31 - Coupled','S41 - Isolated',...
       'Location','best');
ylim([-60 5]);

%% PART 2: TWO-WAY POWER DIVIDER

% Ideal equal-split Wilkinson-type divider
% Simplified frequency response around the design frequency

x = fn - 1;

% Input reflection coefficient (illustrative model)
S11_div = 0.02 + 0.12*abs(x);

% Equal power division at the design frequency
split = (1/sqrt(2))*abs(cos((pi/2)*x));

% Output transmission coefficients
S21_div = split;
S31_div = split;

% Simplified output-to-output isolation model
S23_div = 0.03 + 0.10*abs(x);

% Convert to dB
S11_div_dB = 20*log10(max(S11_div,1e-6));
S21_div_dB = 20*log10(max(S21_div,1e-6));
S31_div_dB = 20*log10(max(S31_div,1e-6));
S23_div_dB = 20*log10(max(S23_div,1e-6));

figure('Name','Two-Way Power Divider S-Parameters');

plot(freqGHz,S11_div_dB,'LineWidth',1.8);
hold on;
plot(freqGHz,S21_div_dB,'LineWidth',1.8);
plot(freqGHz,S31_div_dB,'LineWidth',1.8);
plot(freqGHz,S23_div_dB,'LineWidth',1.8);
grid on;

xlabel('Frequency (GHz)');
ylabel('Magnitude (dB)');
title('Two-Way Power Divider S-Parameter Response');
legend('S11 - Input Reflection','S21 - Output 1',...
       'S31 - Output 2','S23 - Output Isolation',...
       'Location','best');
ylim([-60 5]);

%% PART 3: RESULTS AT DESIGN FREQUENCY

[~,idx] = min(abs(f-f0));

fprintf('\nDIRECTIONAL COUPLER at %.2f GHz\n',f(idx)/1e9);
fprintf('S11 = %.2f dB\n',S11_dB(idx));
fprintf('S21 = %.2f dB\n',S21_dB(idx));
fprintf('S31 = %.2f dB\n',S31_dB(idx));
fprintf('S41 = %.2f dB\n',S41_dB(idx));

fprintf('\nTWO-WAY POWER DIVIDER at %.2f GHz\n',f(idx)/1e9);
fprintf('S11 = %.2f dB\n',S11_div_dB(idx));
fprintf('S21 = %.2f dB\n',S21_div_dB(idx));
fprintf('S31 = %.2f dB\n',S31_div_dB(idx));
fprintf('S23 = %.2f dB\n',S23_div_dB(idx));
