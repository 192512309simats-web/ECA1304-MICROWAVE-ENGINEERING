clc;
clear;
close all;

% Microwave mixer parameters
fRF = 10e9;       % RF frequency = 10 GHz
fLO = 8e9;        % Local oscillator = 8 GHz
fs = 100e9;       % Sampling frequency
T = 10e-9;        % Simulation time

t = 0:1/fs:T-1/fs;

% Input signals
RF = cos(2*pi*fRF*t);
LO = cos(2*pi*fLO*t);

% Mixer output
% Multiplication models ideal frequency mixing
IF = RF .* LO;

% Frequency spectrum
N = length(IF);
Y = fft(IF);
P = abs(Y)/N;
P = P(1:N/2+1);
P(2:end-1) = 2*P(2:end-1);

f = (0:N/2)*fs/N;

% Plot RF signal
figure(1);
plot(t*1e9, RF);
xlabel('Time (ns)');
ylabel('Amplitude');
title('RF Input Signal (10 GHz)');
grid on;

% Plot LO signal
figure(2);
plot(t*1e9, LO);
xlabel('Time (ns)');
ylabel('Amplitude');
title('Local Oscillator Signal (8 GHz)');
grid on;

% Plot mixer output
figure(3);
plot(t*1e9, IF);
xlabel('Time (ns)');
ylabel('Amplitude');
title('Microwave Mixer Output');
grid on;

% Plot frequency spectrum
figure(4);
plot(f/1e9, P);
xlabel('Frequency (GHz)');
ylabel('Magnitude');
title('Frequency Spectrum of Mixer Output');
xlim([0 25]);
grid on;

% Calculate output frequencies
fIF = abs(fRF-fLO);
fSum = fRF+fLO;

% Display results
fprintf('\nMICROWAVE MIXER SIMULATION\n');
fprintf('--------------------------\n');
fprintf('RF Frequency = %.2f GHz\n', fRF/1e9);
fprintf('LO Frequency = %.2f GHz\n', fLO/1e9);
fprintf('IF Frequency = %.2f GHz\n', fIF/1e9);
fprintf('Sum Frequency = %.2f GHz\n', fSum/1e9);
fprintf('Simulation completed successfully.\n');