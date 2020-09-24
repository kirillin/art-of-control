classdef PID < matlab.System
    % untitled Add summary here
    %
    % This template includes the minimum set of functions required
    % to define a System object with discrete state.

    % Public, tunable properties
    
    
    % position/velocity/
    % 0: trapezoidal, 1: s-curve
    
    
    properties
        dt = 0.001;
        feedback_nature = 1;
        kp = 1;
        ki = 0.1;
        kd = 10;

        u_max = 10;
        u_min = -10;
        input_clip = false;
        output_clip = false;
        
        ramp = false;
        velocity_profile_type = 0;     
        x0 = 0;
        v0 = 0;
        a0 = 0;

        x_range = [-pi, pi];
        v_max = pi;
        a_max = pi;
        j_max = 0;

        antiwindup = false;
        kt = 0;
    end
    
    properties(DiscreteState)

    end

    % Pre-computed constants
    properties(Access = private)
        ei = 0;
        et = 0;
        ed = 0;
        e_last = 0;
        u_last = 0;
        is_first_step = true;
        in_des_last = 0;
        xk = 0;
        vk = 0;
        ak = 0;
    end

    methods(Access = protected)
    
        function setupImpl(obj)
            % Perform one-time calculations, such as computing constants
            obj.ei = 0;
            obj.et = 0;
            obj.ed = 0;
            obj.e_last = 0;
            obj.u_last = 0;
            obj.is_first_step = true;
            
            obj.in_des_last = 0;    % may be initial from in_state?
            
            obj.xk = obj.x0;
            obj.vk = obj.v0;
            obj.ak = obj.a0;
        end

        function y = sat(obj, u, max, min)
            y = u;        
            if u > max
                y = max;
            elseif u < min
                y = min;
            end
        end
        
        function [out, e] = stepImpl(obj, in_des, in_state)
            dt = obj.dt;
   
            % Clip input
            if obj.input_clip == true
                % TODO non-symetric saturation 
                % for position range
                in_des = obj.sat(in_des, obj.v_max, -obj.v_max);
            end

            % Check direction
            direction = 0;              
            if (in_des - obj.in_des_last) > eps
                direction = 1;
            elseif (in_des - obj.in_des_last) < -eps
                direction = -1;
            end


            % Select velocity profile
            % and eval it!!
            switch (obj.velocity_profile_type)
                case 0  % trapezoidal
                    obj.xk = obj.xk  + obj.vk * dt + 0.5 * direction * obj.a_max * dt^2;
                    obj.vk = obj.vk  + direction * obj.a_max * dt;
                    obj.ak = direction * obj.a_max;

                case 1  % s-curve
                        % TODO s-curve profile
                    fprintf('Profile doesnt exists!!! \n' );
                otherwise   % Do not use any profiles
                    obj.xk = in_des;
                    obj.vk = in_des;
                    %fprintf('RAMP disable\n' );
            end

            % Select feedback nature (position/velocity)
            switch obj.feedback_nature
                case 0 % 'position'
                    in_des = obj.xk;
                case 1 % 'velocity'
                    in_des = obj.vk;
                otherwise
                    % RAMP is not using
            end
            
            obj.in_des_last = in_des; % it likes to be right here!
            
            % Control computations
            e = in_des - in_state;
            
            obj.ei = obj.ei + e * dt;
            % TODO Clip integral part
            
            if obj.is_first_step ~= true
                obj.ed = (e - obj.e_last) / dt;
            else
                obj.is_first_step = false;
            end
            obj.e_last = e;
            
            u = obj.kp * e + obj.ki * obj.ei + obj.kd * obj.ed;

            % Check if antiwindup should be used
            u_aw = 0;
            if obj.antiwindup == true
                obj.et = obj.et + (obj.sat(obj.u_last, obj.u_max, obj.u_min) - obj.u_last) * dt;
                u_aw = obj.kt * obj.et;
            end
            
            out = u + u_aw;
            
            if obj.output_clip == true
                out = obj.sat(out, obj.u_max, obj.u_min);
            end
            
            obj.u_last = out;
        end

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
            obj.ei = 0;
            obj.et = 0;
            obj.ed = 0;
            obj.e_last = 0;
            obj.u_last = 0;
            obj.is_first_step = true;
            
            obj.in_des_last = 0;    % may be initial from in_state?
            
            obj.xk = obj.x0;
            obj.vk = obj.v0;
            obj.ak = obj.a0;
        end
    end
end

