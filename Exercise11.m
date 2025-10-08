% ============================================================
% Exercise 11 – FIR Types I–IV (Magnitude, Phase, Zeros)
% tags: DSP, FIR, freqz, unwrap, zplane, pole-zero, symmetry
% Author: Juan Rodriguez Esteban
% ============================================================
clear; clc; close all;

% -----------------------------
% Given impulse responses (FIR)
% -----------------------------
h1 = [1 2 3 4 4 3 2 1];     % Type I  (M even, symmetric)
h2 = [1 2 3 4 3 2 1];       % Type II (M odd,  symmetric)
h3 = [-1 -2 -3 -4 3 3 2 1]; % Type III(M even, antisymmetric)
h4 = [-1 -2 -3 0  3 2 1];   % Type IV (M odd,  antisymmetric)

Hs = {h1,h2,h3,h4};
names = {'FIR1','FIR2','FIR3','FIR4'};
nfft  = 512;

% Pre-compute frequency responses and zero locations
W = cell(1,4); MAG = cell(1,4); PH = cell(1,4);
Zc = cell(1,4); Pc = cell(1,4);
for k = 1:4
    [Hk, wk] = safe_freqz(Hs{k}, 1, nfft);
    W{k}   = wk;
    MAG{k} = abs(Hk);
    PH{k}  = unwrap(angle(Hk));
    [zk, pk] = safe_tf2zpk(Hs{k}, 1);
    Zc{k} = zk; Pc{k} = pk;
end

% ============================================================
%                       P L O T S
% ============================================================
figure('Name','Exercise 11 – Results','Color','w','Position',[100 100 1200 800]);

for r = 1:4
    base = (r-1)*3;

    % --- Magnitude (left) ---
    subplot(4,3,base+1);
    plot(W{r}/pi, MAG{r}, 'LineWidth', 1.25); grid on;
    if r == 1, title('Magnitude |H(e^{j\omega})|'); end
    if r == 4, xlabel('\omega/\pi'); end
    ylabel(names{r}); xlim([0 1]);

    % --- Phase unwrapped (middle) ---
    subplot(4,3,base+2);
    plot(W{r}/pi, PH{r}, 'LineWidth', 1.1); grid on;
    if r == 1, title('Unwrapped Phase \angle H(e^{j\omega})'); end
    if r == 4, xlabel('\omega/\pi'); end
    xlim([0 1]);

    % --- Zero plot (right) ---
    subplot(4,3,base+3);
    safe_zplane(Zc{r}, Pc{r});
    if r == 1, title('Pole–Zero Diagram'); end
end

% Optional overall title
sgtitle('Exercise 11 – FIR Types I–IV (Magnitude • Phase • Zeros)');

% ============================================================
% Helper functions (toolbox-free fallbacks)
% ============================================================
function [H, w] = safe_freqz(b, a, n)
% Use built-in freqz if available; else evaluate H(e^{jw}) directly.
    if exist('freqz','file') == 2
        [H, w] = freqz(b, a, n);
        return;
    end
    if nargin < 3, n = 512; end
    w = linspace(0, pi, n).';
    kb = 0:numel(b)-1;    Ba = exp(-1j*w*kb) * b(:);
    ka = 0:numel(a)-1;    Aa = exp(-1j*w*ka) * a(:);
    H = Ba ./ Aa;
end

function [z, p, k] = safe_tf2zpk(b, a)
% Use tf2zpk if available; else compute with roots.
    if exist('tf2zpk','file') == 2
        [z, p, k] = tf2zpk(b, a);
        return;
    end
    z = roots(b(:).');   % zeros of numerator
    p = roots(a(:).');   % zeros of denominator (poles)
    if isempty(a), a = 1; end
    k = b(1)/a(1); 
end

function safe_zplane(z, p)
% Use zplane if available; else draw a simple pole–zero diagram.
    if exist('zplane','file') == 2
        zplane(z, p); grid on; axis equal;
        xlabel('Real Part'); ylabel('Imaginary Part');
        xlim([-1.5 1.5]); ylim([-1.5 1.5]);
        return;
    end
    th = linspace(0, 2*pi, 512);
    plot(cos(th), sin(th), 'k:'); hold on; axis equal;
    plot(real(z), imag(z), 'o', 'MarkerSize', 6, 'LineWidth', 1.1);
    plot(real(p), imag(p), 'x', 'MarkerSize', 7, 'LineWidth', 1.1);
    grid on; xlabel('Real Part'); ylabel('Imaginary Part');
    xlim([-1.5 1.5]); ylim([-1.5 1.5]); hold off;
end
