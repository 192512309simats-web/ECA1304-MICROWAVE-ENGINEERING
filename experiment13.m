
clc;
clear;
close all;

% INPUT PARAMETERS
fstart = 8e9;        % Start frequency = 8 GHz
fstop = 12e9;        % Stop frequency = 12 GHz
Z0 = 50;             % Reference impedance = 50 ohms
df = 0.01e9;         % Frequency step = 0.01 GHz

% DUT: 50-ohm transmission line
c = 3e8;
Zline = 50;
L = 25e-3;            % Line length = 25 mm

% FREQUENCY SWEEP
f = fstart:df:fstop;
beta = 2*pi*f/c;

% S-PARAMETERS OF LOSSLESS TRANSMISSION LINE
S11 = zeros(size(f));
S22 = zeros(size(f));
S21 = exp(-1j*beta*L);
S12 = S21;

% MAGNITUDE IN dB
S11dB = 20*log10(max(abs(S11),1e-10));
S22dB = 20*log10(max(abs(S22),1e-10));
S21dB = 20*log10(abs(S21));
S12dB = 20*log10(abs(S12));

% DISPLAY INPUTS
fprintf('MICROWAVE TWO-PORT NETWORK ANALYSIS\n');
fprintf('----------------------------------\n');
fprintf('Start Frequency = %.2f GHz\n',fstart/1e9);
fprintf('Stop Frequency  = %.2f GHz\n',fstop/1e9);
fprintf('Reference Z0    = %.1f Ohms\n',Z0);
fprintf('Frequency Step  = %.2f GHz\n',df/1e9);
fprintf('Number of Points = %d\n',length(f));

% DISPLAY SAMPLE RESULTS AT 10 GHz
[~,idx] = min(abs(f-10e9));

fprintf('\nResults at %.2f GHz:\n',f(idx)/1e9);
fprintf('S11 = %.4f dB\n',S11dB(idx));
fprintf('S21 = %.4f dB\n',S21dB(idx));
fprintf('S12 = %.4f dB\n',S12dB(idx));
fprintf('S22 = %.4f dB\n',S22dB(idx));

% PLOT 1: REFLECTION PARAMETERS
figure(1);
plot(f/1e9,S11dB,'LineWidth',2);
hold on;
plot(f/1e9,S22dB,'--','LineWidth',2);
grid on;
xlabel('Frequency (GHz)');
ylabel('Magnitude (dB)');
title('Reflection Parameters of Two-Port DUT');
legend('S11','S22');

% PLOT 2: TRANSMISSION PARAMETERS
figure(2);
plot(f/1e9,S21dB,'LineWidth',2);
hold on;
plot(f/1e9,S12dB,'--','LineWidth',2);
grid on;
xlabel('Frequency (GHz)');
ylabel('Magnitude (dB)');
title('Transmission Parameters of Two-Port DUT');
legend('S21','S12');

% PLOT 3: TRANSMISSION PHASE
figure(3);
plot(f/1e9,unwrap(angle(S21))*180/pi,'LineWidth',2);
grid on;
xlabel('Frequency (GHz)');
ylabel('Phase (degrees)');
title('S21 Phase Response');

fprintf('\nSimulation completed successfully.\n');
