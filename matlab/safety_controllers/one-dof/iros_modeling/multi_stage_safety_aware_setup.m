clear; clc;

x_V0 = -1; % SEE TO ME

t_init = 0;

T_R = 0.001;
T_S = 0.03;

x0 = 0;
v0 = 1;
m_R = 1;
F_max = 10; % maximum output of object
a_max = F_max / m_R;
j_max = 300;

km = 100;   % serias of materials of a robot and an obstacle

k0 = 100;
b0 = 2 * sqrt(m_R * k0);

x_O = 1.5;
x_R = 0;

%% Stage I
E_max = 100;
P_max = 100;
s0 = 5;


%% Stage II
is_some_noise = false;
l = 10; % window length of moving SD


%% Stage III
E_SAFE = 1;
P_SAFE = 0.5;

