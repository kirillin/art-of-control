classdef braking_memory_trapezoid < matlab.System


    properties
        a_max
        j_max
        T_R
        x0_
        v0_

        k0
        b0
    end

    properties(DiscreteState)
        prev_trig
        d_b
        d_b_j
        t_b
        h2
        h1
        h3
        
        x_V0
        
        x0
        v0
        a0
        
        t0
        
        k_prev
        b_prev
    end

    % Pre-computed constants
    properties(Access = private)

    end

    methods(Access = protected)
        function setupImpl(obj)
            % Perform one-time calculations, such as computing constants
            
        end
        
        function [d_b, d_b_j, t_b, h1, h2] = what_about_some_braking(obj, v0, a0)
            
            % I part of the profile
            b = -2 * (a0) / obj.j_max; c = -2 * (v0) / obj.j_max; D = b^2 - 4 * c;
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
%             h1 = dt1;
%             h2 = dt2;

            % braking distance
            d_b = v0 * h1 + 0.5 * a0 * h1^2 - obj.j_max * h1^3 / 6 + (v0 + a0 * h1 - 0.5 * obj.j_max * h1^2) * h2 - 0.5 * obj.a_max * h2^2;
            
            d_b_j = v0 * h1 + 0.5 * a0 * h1^2 - obj.j_max * h1^3 / 6;

            % braking time
            t_b = h1 + h2;
        end        

        function [d_b, d_b_j, t_b, h1, h2, h3] = what_about_some_braking2(obj, v0, a0)
            
            % I part of the profile
            b = -2 * (a0) / obj.j_max; c = -2 * (v0) / obj.j_max; D = b^2 - 4 * c;
            t1 = 99;
            if D >= 0
                t1 = (-b + sqrt(D)) / 2; t2 = (-b - sqrt(D)) / 2;
                t1 = max([t1, t2]);
            end
            % II and III parts of the profile
            am = obj.a_max;
            jm = obj.j_max;
            dt1 = (a0 + am)/jm;
            dt3 = am/jm;
            dt2 = ((jm*dt3^2)/2 - am*dt3 + v0 + a0*dt1 - (dt1^2*jm)/2)/am;

            % Check if a robot can braking in I part of profile
            if t1 < dt1
                dt1 = t1;
                dt2 = 0;
                dt3 = 0;
            end

            % disrete intervals: hi = ni T_R
            h1 = ceil(dt1 / obj.T_R) * obj.T_R;
            h2 = ceil(dt2 / obj.T_R) * obj.T_R;
            h3 = ceil(dt3 / obj.T_R) * obj.T_R;

            
            % braking distance
            d_b = dt1*v0 + dt3*(v0 + a0*dt1 - am*dt2 - (dt1^2*jm)/2) + dt2*(v0 + a0*dt1 - (am*dt2)/2 - (dt1^2*jm)/2) + (a0*dt1^2)/2 - (am*dt3^2)/2 - (dt1^3*jm)/6 + (dt3^3*jm)/6;
            d_b_j = - (jm*dt1^3)/6 + (a0*dt1^2)/2 + v0*dt1;

            % braking time
            t_b = h1 + h2 + h3;
        end                
        
        function [d_b0, d_b_j0, t_b0, h10, h20, h30, x0, v0, a0, t0, k0, b0] = stepImpl(obj, trig, t, x, dx, ddx, x_V0, k_prev, b_prev)
            obj.x_V0 = x_V0;
            
            if (obj.prev_trig == 0 && trig == 1)
                obj.prev_trig = 1;
                
                obj.a0 = obj.k0 * (obj.x_V0 - obj.x0_) - obj.b0 * obj.v0_;
%                 [d_b, d_b_j, t_b, h1, h2] = obj.what_about_some_braking(abs(dx), (ddx));
%                 h3 = 0;
                [d_b, d_b_j, t_b, h1, h2, h3] = obj.what_about_some_braking2((dx), ddx);
                obj.d_b = d_b;
                obj.d_b_j = d_b_j;
                obj.t_b = t_b;
                obj.h1 = h1; 
                obj.h2 = h2;
                obj.h3 = h3;
                
                obj.x0 = x;
                obj.v0 = dx;
                obj.a0 = ddx;
                obj.t0 = t;
                
                obj.k_prev = k_prev;
                obj.b_prev = b_prev;
            end
            
            if trig == 0
                obj.prev_trig = 0;
            end

            
            d_b0 = obj.d_b;
            d_b_j0 = obj.d_b_j;
            t_b0 = obj.t_b;
            h10 = obj.h1;
            h20 = obj.h2;
            h30 = obj.h3;

            x0 = obj.x0;
            v0 = obj.v0;
            a0 = obj.a0;
            
            t0 = obj.t0;
            
            k0 = obj.k_prev;
            b0 = obj.b_prev;

        end

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
            obj.d_b = 0;
            obj.d_b_j = 0;
            obj.t_b = 0;
            obj.h1 = 0;
            obj.h2 = 0;
            obj.h3 = 0;
            obj.a0 = 0;
            obj.x0 = obj.x0_;
            obj.v0 = obj.v0_;
            obj.t0 = 0;
            
            obj.prev_trig = 0;

            obj.k_prev = 0;
            obj.b_prev = 0;
            
        end
    end
end
