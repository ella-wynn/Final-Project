% integration coding demo
clear all; close all;
% define bounds
a = 1.2;
b = 6;
% params
n = 10;
dx = (b - a)/n;

% do it in a for loop 
I = 0; 
for i = 0:n-1
    x = a + ((2*i+1)/2)*dx;
    out = fxn(x);
    I = I + (out * dx);
end

disp(['for-looped: ' num2str(I)])

% do it with vector operations 
I = 0;
i = 0:n-1;
x = a + ((2.*i+1)/2)*dx;
out = fxn(x);
I = sum(out * dx);

disp(['vectorized: ' num2str(I)])

% check error
I = 0;
I_exact = (1/3)*(b^3 - a^3);
ns = round(logspace(1, 6, 1e3)); % 10^1 to 10^6, 1000 of them 
error = nan.*ones(size(ns));
q = 0;
for q = 1:length(ns)
    n = ns(q);
    dx = (b - a)/n;
    ii = 0:n-1;
    x = a + ((2*ii+1)/2)*dx;
    y = fxn(x);
    I = sum(y*dx);
    error(q) = abs(I - I_exact);
end

figure();
loglog(ns, error, 'k.', 'markersize', 5);

% this shows that error is proportional to delta x ^ 2 
% truncation error

function out = fxn(x)
    out = x.^2;
end