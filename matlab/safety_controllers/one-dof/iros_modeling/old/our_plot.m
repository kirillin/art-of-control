
t = out.our.Time;

x_O = out.our.Data(:, 1);
x_V = out.our.Data(:, 2);
x_R = out.our.Data(:, 3);
dx_R = out.our.Data(:, 4);

Fc = out.our.Data(:, 5);
FI = out.our.Data(:, 6);

Pc = out.our.Data(:, 7);
Etot = out.our.Data(:, 8);
dEtot = out.our.Data(:, 9);

d_S = out.our.Data(:, 10);
d_R = out.our.Data(:, 11);
d = out.our.Data(:, 12);
d_R0 = out.our.Data(:, 13);

F = out.our.Data(:, 14);

k = out.our.Data(:, 15);
b = out.our.Data(:, 16);

f = figure;
s1 = subplot(9, 1, 1);
plot(t, [x_O, dx_R, x_V, x_R])
legend('$x_O$ is the obstacle position', ...
    '$\dot{x}_R$ is the robot velocity', ...
    '$x_V$ is the reference trajectory', ...
    '$x_R$ is the robot position', ...
    'Interpreter','latex', 'Location', 'northeastoutside');
s1.FontSize = 14;
grid()

s2 = subplot(9, 1, 2);
plot(t, [Fc])

legend('$F_C$ is the controller output', ...
    'Interpreter','latex', 'Location', 'northeastoutside');
s2.FontSize = 14;
grid()

s3 = subplot(9, 1, 3);
plot(t, [FI])
legend('$F_I$ is the interaction force', ...
    'Interpreter','latex', 'Location', 'northeastoutside');
s3.FontSize = 14;
grid()

s4 = subplot(9, 1, 4);
plot(t, [Pc])
legend('$P_C$ is the contoller power', ...
    'Interpreter','latex', 'Location', 'northeastoutside');
s4.FontSize = 14;
grid()

s5 = subplot(9, 1, 5);
plot(t, [dEtot, Etot])
legend('$\Delta{E}_{tot} = E_{tot, 0} - E_{tot, f}$', ...
    '$E_{tot}$ is the total energy of system', ...
    'Interpreter','latex', 'Location', 'northeastoutside');
s5.FontSize = 14;
grid()


s6 = subplot(9, 1, 6);
% plot(t, [d, d_S, d_R, d_R0])
% legend('$d = d_S - (d_R + d_O)$', ...
%     '$d_S$ is the distance measuarments', ...
%     '$d_R$ is the dimention of safety-bubble of the robot', ...    
%     '$d_R0$ is the safety-bubble of the robot during braking', ...
%     'Interpreter','latex', 'Location', 'northeastoutside');
plot(t, [d_R, d_R0])
legend('$d_R$ is the dimention of safety-bubble of the robot', ...    
    '$d_{R0}$ is the safety-bubble of the robot during braking', ...
    'Interpreter','latex', 'Location', 'northeastoutside');
s6.FontSize = 14;
grid()

s7 = subplot(9, 1, 7);
plot(t, [F])
legend('$F(t)$ is the force profile', ...
    'Interpreter','latex', 'Location', 'northeastoutside');
s7.FontSize = 14;
grid()

s8 = subplot(9, 1, 8);
plot(t, [k])
legend('$k(t)$ is the stiffness of the controller', ...
    'Interpreter','latex', 'Location', 'northeastoutside');
s8.FontSize = 14;
grid()

s9 = subplot(9, 1, 9);
% s9 = subplot(1, 1, 1);
plot(t, [b])
legend('$b(t)$ is the damping of the controller', ...
    'Interpreter','latex', 'Location', 'northeastoutside');
s9.FontSize = 14;
xlabel('$t, sec$', 'Interpreter','latex');
grid()
s9.YScale = 'log';

for i = 1:length(f.Children)
    if mod(i, 2) == 0
        f.Children(i).Position(1) = 0.05;
        f.Children(i).Position(3) = 0.65;
        f.Children(i).LineWidth = 0.2;
        
        a = f.Children(i).YLim;
%         if a(1) == 0 && a(2) > 0
%             a(1) = -a(2)/100;
%         end
% 
%         if a(2) == 0 && a(1) < 0
%             a(1) = a(1)/100;
%         end
%         

        
        f.Children(i).YLim = 1.5 .* a;
        if i > 2
            f.Children(i).XAxis.Visible = 'off';
        end
        
%         f.Children(i).OuterPosition(4) = 1.00001 * f.Children(i).OuterPosition(4);

        
        
        for j = 1:length(f.Children(i).Children)
            f.Children(i).Children(j).LineWidth = 1;
            
        end
        
        %         f.Children(i).Position(2) = f.Children(i).Position(2) * 1.1;
%         f.Children(i).Position(4) = f.Children(i).Position(4) * 1.1;        

    end
end









% %% force profile
% figure
% st = 0.4;
% ed = 0.9;
% 
% d_S = [];
% F = [];
% 
% k = 1;
% for i = 1:length(out.fdx.Data)
%     if out.fdx.Time(i) > st && out.fdx.Time(i) < ed
%         d_S(k) = out.fdx.Data(i,1);
%         F(k) = out.fdx.Data(i,2);
%         k = k + 1;
%     end
% end
% 
% plot(d_S, F);