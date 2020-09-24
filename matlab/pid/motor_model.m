
% motor parameters
J = 0.0023;
R = 7.5;
b = 0.1;    % viscous friction
K = 0.5;
L = 0.5;

% Let Km == Ke == K
% Km = 0.5;
% Ke = 0.5;

Umax = 8;


A = [-b/J   K/J
    -K/L   -R/L];
B = [0
    1/L];
C = [1   0];
D = 0;
motor_ss = ss(A,B,C,D);


% sample time
dt = 0.05;


% transfer function in discrete time
s = tf('s');
P_motor = K/((J*s+b)*(L*s+R)+K^2);



