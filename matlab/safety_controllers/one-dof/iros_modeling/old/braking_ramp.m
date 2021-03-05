function [x, v, a, j, t] = braking_ramp(t, x0, v0, a0, j_max)
    x = x0 + v0 * t + 0.5 * a0 * t^2 - 0.1667 * j_max * t^3;
    v = v0 + a0 * t - 0.5 * j_max * t^2;
    a = a0 - j_max * t;
    j = -j_max;
end
























