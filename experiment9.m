clc;
clear;
close all;

% INPUT PARAMETERS
f0 = 10e9;              % Design frequency: 10 GHz
Z0 = 50;                % Reference impedance: 50 ohms
ZL = 75 + 1j*25;        % Load impedance: 75 + j25 ohms
fc = 10e9;               % Filter cutoff frequency: 10 GHz

fstart = 8e9;            % Start frequency: 8 GHz
fstop = 12e9;             % Stop frequency: 12 GHz

f = linspace(fstart,fstop,1000);

% IMPEDANCE MATCHING
GammaL = (ZL-Z0)/(ZL+Z0);
VSWR = (1+abs(GammaL))/(1-abs(GammaL));

% Ideal matching-network response at design frequency
Gamma_match = 0;

% FREQUENCY-SELECTIVE LOW-PASS FILTER
H = 1./sqrt(1+(f/fc).^4);
H_dB = 20*log10(H);

% Reflection coefficient before matching
S11_before = abs(GammaL)*ones(size(f));

% Ideal matched condition
S11_after = zeros(size(f));

% DISPLAY RESULTS
fprintf('MICROWAVE MATCHING AND FILTER DESIGN\n');
fprintf('-----------------------------------\n');
fprintf('Design Frequency = %.2f GHz\n',f0/1e9);
fprintf('Reference Impedance = %.2f Ohms\n',Z0);
fprintf('Load Impedance = %.2f + j%.2f Ohms\n',real(ZL),imag(ZL));
fprintf('Filter Cutoff Frequency = %.2f GHz\n',fc/1e9);
fprintf('Frequency Sweep = %.2f to %.2f GHz\n',fstart/1e9,fstop/1e9);
fprintf('Input Reflection Coefficient = %.3f\n',abs(GammaL));
fprintf('VSWR before matching = %.3f\n',VSWR);

% PLOT 1: INPUT REFLECTION
figure(1);
plot(f/1e9,20*log10(S11_before),'r','LineWidth',2);
hold on;
plot(f/1e9,20*log10(max(S11_after,1e-6)),'b--','LineWidth',2);
grid on;
xlabel('Frequency (GHz)');
ylabel('S11 (dB)');
title('Impedance Matching Performance');
legend('Before Matching','Ideal Matched Condition');

% PLOT 2: FILTER RESPONSE
figure(2);
plot(f/1e9,H_dB,'LineWidth',2);
hold on;
xline(fc/1e9,'r--','Cutoff Frequency');
grid on;
xlabel('Frequency (GHz)');
ylabel('Magnitude (dB)');
title('Low-Pass Filter Frequency Response');

% PLOT 3: LOAD IMPEDANCE
figure(3);
plot(real(ZL),imag(ZL),'ro','MarkerSize',10,'LineWidth',2);
grid on;
xlabel('Resistance (Ohms)');
ylabel('Reactance (Ohms)');
title('Load Impedance on Complex Plane');

fprintf('\nSimulation completed successfully.\n');