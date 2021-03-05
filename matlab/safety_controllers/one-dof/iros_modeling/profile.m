clc

syms dt1 dt2 dt3
syms jm am
syms a0 v0

d0 = 0;

a1 = a0 - jm * dt1; % a1 = am
v1 = v0 + a0 * dt1 - 0.5  * jm * dt1^2;
d1 = d0 + v0 * dt1 + 0.5 * a0 * dt1^2 - jm * dt1^3 / 6;

a2 = -am
v2 = v1 - am * dt2;
%d2 = d1 + v1 * dt2 - 0.5 * am * dt2^2;
d2 = d1 + 0.5 * (v1 + v2) * dt2;

a3 = a2 + jm * dt3;
v3 = v2 + a2 * dt3 + 0.5 * jm * dt3^2;
d3 = d2 + v2 * dt3 + 0.5 * a2 * dt3^2 + jm * dt3^3 / 6;



dt1 = solve(a1 + am, dt1)
dt2 = solve(v3, dt2)
dt3 = solve(a3, dt3)
% 
% t2 = expand( solve(v2-v20, t2))

% (
% 
% (jm*dt3^2)/2 - am*dt3 + v0 + a0*dt1 - (dt1^2*jm)/2
% 
% )/am