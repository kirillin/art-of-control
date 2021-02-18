

[k,b] = meshgrid(-1:0.1:1., -1:0.1:1.);
% [k,b] = meshgrid(0:0.1:1., 0:0.1:1.);

k0 = 1;
b0 = 0.2;

E_max = 0.5;
P_max = 0.5;

Z = [];
Z1 = [];
ZZ = [];
ZZ1 = [];

for i = 1: length(k)
    for j = 1: length(b)

        ZZ(i, j) = k(i, j)^2 / (b(i, j))^2;
    
    end
end
% 
figure 
surf(k,b,ZZ)
xlabel("$k$", 'Interpreter','latex', 'FontSize', 18)
ylabel("$b$", 'Interpreter','latex', 'FontSize', 18)
zlabel("$k$", 'Interpreter','latex', 'FontSize', 18)
% 
% 
% subplot(2,2,1)
% hold on
% % s = surf(X,Y,ones(length(X))*E_max); % 'FaceAlpha',0.5)
% s = surf(X,Y,ones(length(X))*E_max,'FaceAlpha',0.3)
% 
% surf(X,Y,Z)
% xlabel("$\dot{x}_R$", 'Interpreter','latex', 'FontSize', 18)
% ylabel("$x_V - x_R$", 'Interpreter','latex', 'FontSize', 18)
% zlabel("$E_{tot}$", 'Interpreter','latex', 'FontSize', 18)
% 
% 
% subplot(2,2,2)
% hold on
% % s = surf(X,Y,ones(length(X))*P_max); % 'FaceAlpha',0.5)
% s = surf(X,Y,ones(length(X))*P_max, 'FaceAlpha',0.3)
% 
% surf(X,Y,Z1)
% xlabel("$\dot{x}_R$", 'Interpreter','latex', 'FontSize', 18)
% ylabel("$x_V - x_R$", 'Interpreter','latex', 'FontSize', 18)
% zlabel("$P_c$", 'Interpreter','latex', 'FontSize', 18)
% 
% subplot(2,2,3)
% surf(X,Y,ZZ)
% xlabel("$\dot{x}_R$", 'Interpreter','latex', 'FontSize', 18)
% ylabel("$x_V - x_R$", 'Interpreter','latex', 'FontSize', 18)
% zlabel("$k$", 'Interpreter','latex', 'FontSize', 18)
% 
% 
% subplot(2,2,4)
% surf(X,Y,ZZ1)
% xlabel("$\dot{x}_R$", 'Interpreter','latex', 'FontSize', 18)
% ylabel("$x_V - x_R$", 'Interpreter','latex', 'FontSize', 18)
zlabel("$b$", 'Interpreter','latex', 'FontSize', 18)