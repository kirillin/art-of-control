classdef stage_II_subsystem < matlab.System
    
    % Public, tunable properties
    properties
        m_R = 1
        T_R = 0.001
        a_max = 3
        j_max = 30
    end

    properties(DiscreteState)

    end

    % Pre-computed constants
    properties(Access = private)
        
    end

    methods(Access = protected)
        function setupImpl(obj)
            % Perform one-time calculations, such as computing constants
            
        end
        
        function [d_b, t_b] = what_about_some_braking(obj, v0, a0)
            % I part of the profile
            b = -2 * a0 / obj.j_max; c = -2 * v0 / obj.j_max; D = b^2 - 4 * c;
            t1 = (-b + sqrt(D)) / 2; t2 = (-b - sqrt(D)) / 2;
            t1 = max([t1, t2]);

            % II part of the profile
            dt1 = (obj.a_max + a0) / obj.j_max;
            dt2 = v0 / obj.a_max + (a0^2 - obj.a_max^2) / (2 * obj.a_max * obj.j_max);

            % Check if a robot can braking in I part of profile
            if t1 < dt1
                dt1 = t1;
                dt2 = 0;
            end

            % disrete intervals: hi = ni T_R
            h1 = ceil(dt1 / obj.T_R) * obj.T_R;
            h2 = ceil(dt2 / obj.T_R) * obj.T_R;

            % braking distance
            d_b = v0 * h1 + 0.5 * a0 * h1^2 - obj.j_max * h1^3 / 6 + (v0 + a0 * h1 - 0.5 * obj.j_max * h1^2) * h2 - 0.5 * obj.a_max * h2^2;

            % braking time
            t_b = h1 + h2;
        end

        function [k_SII, b_SII] = stepImpl(obj, k_SI, b_SI, x_R, dx_R, ddx_R, x_V, d_S, dot_d_S, d_P, d_O)
            k_SII = 0;
            b_SII = 0;
            
%             % MONITORING THE ROBOT BRAKING DISTANCE AND TIME
%             [d_b, t_b] = obj.what_about_some_braking(dx_R, ddx_R);
%             
%             % MONITORING SAFETY BUBBLES
%             % robot safety bubble w.r.t. relative velocity 
%             dx_O = dx_R - dot_d_S;
%             d_R = d_b - dx_O * t_b;
% 
%             % `switching` distance
%             d = min([d_S, d_P]) - (d_R + d_O);
%             
%             if d <= 0
%                 Etot = 0.5 * obj.m_R * dx_R^2 + 0.5 * k_SII * (x_V - x_R);
%                 if (isInit) % fix values
%                     v0 = dx_R;
%                     a0 = ddx_R;
%                     Etotb0 = Etot;
%                 end
%                 
% 
%             end
            
        end

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
            
        end
    end
end
