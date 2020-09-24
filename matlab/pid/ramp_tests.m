
[x, v , a, j, t] = aramp_d(1, 0.001, 0, 0, 0, 4);
[x2, v2, a2, t2] = vramp_d(1, 0.001, x(end), v(end), a(end));
[x3, v3, a3, j3, t3] = aramp_d(1, 0.001, x2(end), v2(end), a2(end), -4);


subplot(3,1,1);
hold on
plot(t, x, 'r')
plot(t2 + t(end), x2, 'g')
plot(t3 + t(end) + t2(end), x3, 'r')
hold off

subplot(3,1,2);
hold on
plot(t, v, 'r')
plot(t2 + t(end), v2, 'g')
plot(t3 + t(end) + t2(end), v3, 'r')
hold off

subplot(3,1,3);
hold on
plot(t, a, 'r')
plot(t2 + t(end), a2, 'g')
plot(t3 + t(end) + t2(end), a3, 'r')
hold off


function [x, v, a, t] = vramp_c(ta, dt, x0, v0, a_max)
    x = [];
    v = [];
    a = [];

    t = 0:dt:ta;
    
    for i = 1:size(t, 2)
        x(i) = x0 + v0 * t(i) + 0.5 * a_max * t(i)^2;
        v(i) = v0 + a_max * t(i);
        a(i) = a_max;
    end
end

function [x, v, a, t] = vramp_d(ta, dt, x0, v0, a_max)
    % recurrent
    % pos, vel, accel
    
    x = [];
    v = [];
    a = [];

    t = 0:dt:ta;
    
    xk_last = x0;
    vk_last = v0;
    for i = 1:size(t, 2)
        
        xk = xk_last + vk_last * dt + 0.5 * a_max * dt^2;
        vk = vk_last + a_max * dt;
        ak = a_max;
        
        xk_last = xk;
        vk_last = vk;

        x(i) = xk;
        v(i) = vk;
        a(i) = ak;
    end
end

function [x, v, a, j, t] = aramp_c(ta, dt, x0, v0, a0, j_max)
    % pos, vel, accel, jerk
    x = [];
    v = [];
    a = [];
    j = [];

    t = 0:dt:ta;
    for i = 1:size(t, 2)
        x(i) = x0 + v0 * t(i) + 0.5 * a0 * t(i)^2 + 0.1667 * j_max * t(i)^3;
        v(i) = v0 + a0 * t(i) + 0.5 * j_max * t(i)^2;
        a(i) = a0 + j_max * t(i);
        j(i) = j_max;
    end
end


function [x, v, a, j, t] = aramp_d(ta, dt, x0, v0, a0, j_max)
    % pos, vel, accel, jerk
    x = [];
    v = [];
    a = [];
    j = [];

    t = 0:dt:ta;
    xk_last = x0;
    vk_last = v0;
    ak_last = a0;
    for i = 1:size(t, 2)
        xk = xk_last + vk_last * dt + 0.5 * ak_last * dt^2 + 0.1667 * j_max * dt^3;
        vk = vk_last + ak_last * dt + 0.5 * j_max * dt^2;
        ak = ak_last + j_max * dt;
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


























