clc
format LONGG
%% WARN: Если v0 < dt, то не работает
dt = 0.001;

d0 = 0;
v0 = 1;
a0 = 0;

F_max = 10; % maximum output of object
a_max = F_max / m_R;
j_max = 300;

if v0 ~= 0
    a_max = sign(v0) * F_max / m_R;
    j_max = sign(v0) * 300;
end



% 
% % v3 = 0;
% % t3 = abs(v3 - v0) / a_max * 1.5
% 
% 
% %% I part
% b = -2 * a0 / j_max;
% c = -2 * v0 / j_max;
% D = b^2 - 4 * c;
% t1 = (-b + sqrt(D)) / 2;
% t2 = (-b - sqrt(D)) / 2;
% t1 = max([t1, t2]);
% 
% %% II part
% dt1 = (a_max + a0) / j_max;
% dt2 = v0 / a_max + (a0^2 - a_max^2) / (2 * a_max * j_max);
% dt3 = a_max / j_max;
% 
% %% Check part I and prat II
% if t1 < dt1
%     dt1 = t1;
%     dt2 = 0;
%     dt3 = 0;
% end
% 
% T_R = dt;
% h1 = ceil(dt1 / T_R) * T_R;
% h2 = ceil(dt2 / T_R) * T_R;
% h3 = ceil(dt3 / T_R) * T_R;
% % 
% % d_b = d0 + v0 * h1 + 0.5 * a0 * h1^2 - j_max * h1^3 / 6 + (v0 + a0 * h1 - 0.5 * j_max * h1^2) * h2 - 0.5 * a_max * h2^2;
% % 
% % d_bj = d0 + v0 * h1 + 0.5 * a0 * h1^2 - j_max * h1^3 / 6;

am = a_max;
jm = j_max;
dt1 = (a0 + am)/jm;
dt3 = am/jm;
dt2 = ((jm*dt3^2)/2 - am*dt3 + v0 + a0*dt1 - (dt1^2*jm)/2)/am;

d_b = dt1*v0 + dt3*(v0 + a0*dt1 - am*dt2 - (dt1^2*jm)/2) + dt2*(v0 + a0*dt1 - (am*dt2)/2 - (dt1^2*jm)/2) + (a0*dt1^2)/2 - (am*dt3^2)/2 - (dt1^3*jm)/6 + (dt3^3*jm)/6;
d_bj = - (jm*dt1^3)/6 + (a0*dt1^2)/2 + v0*dt1;


[x, v , a, j, t] = aramp_d(dt1, dt, 0, v0, a0, j_max);
[x2, v2, a2, j2, t2] = aramp_c(dt2, dt, x(end), v(end), a(end), 0);
[x3, v3, a3, j3, t3] = aramp_c(dt3, dt, x2(end), v2(end), a2(end), -j_max);

subplot(4,1,1);
hold on
plot(t, x, 'r')
plot(t2 + t(end), x2, 'g')
plot(t3 + t(end) + t2(end), x3, 'r')
plot([t, t2 + t(end), t3 + t2(end)+ t(end)], ones(length([[t, t2 + t(end), t3 + t2(end)+ t(end)]]),1) * d_b, 'b')
plot([t, t2 + t(end), t3 + t2(end)+ t(end)], ones(length([[t, t2 + t(end), t3 + t2(end)+ t(end)]]),1) * d_bj, 'g')

grid()
hold off

subplot(4,1,2);
hold on
plot(t, v, 'r')
plot(t2 + t(end), v2, 'g')
plot(t3 + t(end) + t2(end), v3, 'r')
grid
hold off

subplot(4,1,3);
hold on
plot(t, a, 'r')
plot(t2 + t(end), a2, 'g')
plot(t3 + t(end) + t2(end), a3, 'r')
grid()
% hold off

subplot(4,1,4);
hold on
plot(t, j, 'r')
plot(t2 + t(end), j2, 'g')
plot(t3 + t(end) + t2(end), j3, 'r')
grid()
% hold off


function [x, v, a, j, t] = aramp_c(ta, dt, x0, v0, a0, j_max)
    % pos, vel, accel, jerk
    x = [];
    v = [];
    a = [];
    j = [];

    t = 0:dt:ta;
    for i = 1:size(t, 2)
%         x(i) = x0 + v0 * t(i) + 0.5 * a0 * t(i)^2 + 0.1667 * j_max * t(i)^3;
%         v(i) = v0 + a0 * t(i) + 0.5 * j_max * t(i)^2;
%         a(i) = a0 + j_max * t(i);
%         j(i) = j_max;

        x(i) = x0 + v0 * t(i) + 0.5 * a0 * t(i)^2 - 0.1667 * j_max * t(i)^3;
        v(i) = v0 + a0 * t(i) - 0.5 * j_max * t(i)^2;
        a(i) = a0 - j_max * t(i);
        j(i) = -j_max;
        
    end
end


function [x, v, a, j, t] = aramp_d(ta, dt, x0, v0, a0, j_max)
    % pos, vel, accel, jerk
    x = [];
    v = [];
    a = [];
    j = [];

    t = 0:dt:ta - dt;
%     disp(length(t))
    xk_last = x0;
    vk_last = v0;
    ak_last = a0;
    for i = 1:size(t, 2)
%         xk = xk_last + vk_last * dt + 0.5 * ak_last * dt^2 + 0.1667 * j_max * dt^3;
%         vk = vk_last + ak_last * dt + 0.5 * j_max * dt^2;
%         ak = ak_last + j_max * dt;
%         jk = j_max;

        xk = xk_last + vk_last * dt + 0.5 * ak_last * dt^2 - j_max * dt^3 / 6;
        vk = vk_last + ak_last * dt - 0.5 * j_max * dt^2;
        ak = ak_last - j_max * dt;
        jk = j_max;
        
        xk_last = xk;
        vk_last = vk;
        ak_last = ak;
        
        x(i) = xk;
        v(i) = vk;
        a(i) = ak;
        j(i) = jk;

    end
end


























