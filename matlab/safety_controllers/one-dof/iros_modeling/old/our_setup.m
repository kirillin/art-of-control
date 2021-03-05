clear; clc;

t_collision = 0;
t_init = 1;

T = 1/30;
sigma = 0;
F_cmax = 5; % maximum output of object
C_max = 0.2;
alpha = 2;

km = 100;

m_R = 1;

x_O = 1;
x_O2 = -2;
x_R = 0;

k0 = 100;
b0 = 2 * sqrt(100);


% 
% t = out.compliance_adjusting_data.Time;
% d = out.compliance_adjusting_data.Data(:, 5);
% d_SAFE = out.compliance_adjusting_data.Data(:, 6);
% k = out.compliance_adjusting_data.Data(:, 7);
% b = out.compliance_adjusting_data.Data(:, 8);
% 
% subplot(2,1,1)
% plot(d,k)
% ylabel('k(d)', 'FontSize', 18)
% % axis padded
% axis([0, 0.2, 0, k0+0.1*k0])
% grid()
% subplot(2,1,2)
% plot(d,b)
% ylabel('b(d)', 'FontSize', 18)
% axis([0, 0.2, 0, b0+0.1*b0])
% grid()
% xlabel('d, m', 'FontSize', 18)

