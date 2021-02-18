clc

Cmax = 0.1;
d = 0.1;

alpha = 1000;

a = Cmax;
b = Cmax * alpha * d;
c = - alpha * d;

D = b^2 - 4 * a * c;

beta1 = (- b + sqrt(D)) / (2 * a)
gama1 = - 1 / (alpha * d + beta1)
 
% beta2 = (- b - sqrt(D)) / (2 * a)
% gama2 = - 1 / (alpha * d + beta2)



% x \in [x0, x1]
% s \in [0, 1]
x0 = 1.2;
x1 = 2;


s = (1.4 - x0) / (x1 - x0)
