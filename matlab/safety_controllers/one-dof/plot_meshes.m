

[X,Y] = meshgrid(-1.:0.1:1., -1.:0.1:1.);

k0 = 1;
b0 = 0.2;

E_max = 0.5;
P_max = 0.5;

Z = [];
Z1 = [];
ZZ = [];
ZZ1 = [];

for i = 1: length(X)
    for j = 1: length(Y)
         Z(i, j) = 0.5 * m_R * X(i,j).^2 + 0.5 * k0 * Y(i,j).^2;
         
         
         ZZ(i, j) = (E_max - 0.5 * m_R *X(i, j)^2) / (0.5 * Y(i, j)^2);
%          if ZZ(i, j) < 0
%              ZZ(i, j) = 0;
%          end
         
         Z1(i, j) = (ZZ(i, j) * Y(i, j) - b0 * X(i, j)) * X(i, j);
         
         ZZ1(i, j) = (ZZ(i, j)* Y(i, j) * X(i, j) - P_max) / X(i, j)^2;
         
    
         
%          if ZZ1(i, j) < 0
%              ZZ1(i, j) = -999999;
%          end
    end
end
% 
% figure 
% surf(X,Y,ZZ)
% xlabel("$\dot{x}_R$", 'Interpreter','latex', 'FontSize', 18)
% ylabel("$x_V - x_R$", 'Interpreter','latex', 'FontSize', 18)
% zlabel("$k$", 'Interpreter','latex', 'FontSize', 18)


subplot(2,2,1)
hold on
% s = surf(X,Y,ones(length(X))*E_max); % 'FaceAlpha',0.5)
s = surf(X,Y,ones(length(X))*E_max,'FaceAlpha',0.3)

surf(X,Y,Z)
xlabel("$\dot{x}_R$", 'Interpreter','latex', 'FontSize', 18)
ylabel("$x_V - x_R$", 'Interpreter','latex', 'FontSize', 18)
zlabel("$E_{tot}$", 'Interpreter','latex', 'FontSize', 18)


subplot(2,2,2)
hold on
% s = surf(X,Y,ones(length(X))*P_max); % 'FaceAlpha',0.5)
s = surf(X,Y,ones(length(X))*P_max, 'FaceAlpha',0.3)

surf(X,Y,Z1)
xlabel("$\dot{x}_R$", 'Interpreter','latex', 'FontSize', 18)
ylabel("$x_V - x_R$", 'Interpreter','latex', 'FontSize', 18)
zlabel("$P_c$", 'Interpreter','latex', 'FontSize', 18)

subplot(2,2,3)
surf(X,Y,ZZ)
xlabel("$\dot{x}_R$", 'Interpreter','latex', 'FontSize', 18)
ylabel("$x_V - x_R$", 'Interpreter','latex', 'FontSize', 18)
zlabel("$k$", 'Interpreter','latex', 'FontSize', 18)


subplot(2,2,4)
surf(X,Y,ZZ1)
xlabel("$\dot{x}_R$", 'Interpreter','latex', 'FontSize', 18)
ylabel("$x_V - x_R$", 'Interpreter','latex', 'FontSize', 18)
zlabel("$b$", 'Interpreter','latex', 'FontSize', 18)