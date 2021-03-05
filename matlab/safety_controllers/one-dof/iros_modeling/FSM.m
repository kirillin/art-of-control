classdef FSM < matlab.System
    %     states = [
    %       0 -- idle (initialisation) 
    %       1 -- stage 1
    %       2 -- stage 2
    %       3 -- stage 3
    %     ]
    
    % Public, tunable properties
    properties
        t_init = 0 % init time
        F_I_delta = 0
        d_delta = 0
        k0 = 100;
        b0 = 20;
    end

    properties(DiscreteState)
        current_state
        k
        b
    end

    % Pre-computed constants
    properties(Access = private)

    end

    methods(Access = protected)
        function setupImpl(obj)
            % Perform one-time calculations, such as computing constants
        end

        function [k_, b_, stage] = stepImpl(obj, k1, b1, k2, b2, k3, b3, t, d, F_I)
            % `s_i = [ki, bi]` is parameters of imedance controller 
                
            if t > obj.t_init                   % time for initislization
                if d > obj.d_delta              % stage 1
                    obj.current_state = 1;
                    obj.k = k1; obj.b = b1;
                else                            % stage 2 or stage 3 -- `d <= 0`
                    if abs(F_I) > obj.F_I_delta	% stage 3 
                        obj.current_state = 3;
                        obj.k = k3; obj.b = b3;
                    else                        % stage 2
                        obj.current_state = 2;
                        obj.k = k2; obj.b = b2;
                    end
                end
            else 
                obj.current_state = 0;
                obj.k = obj.k0; obj.b = obj.b0;
            end
            
            stage = obj.current_state;
            k_ = obj.k;
            b_ = obj.b;
        end

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
            obj.current_state = 0;
            obj.k = obj.k0;
            obj.b = obj.b0;
        end
    end
end
