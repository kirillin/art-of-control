classdef test < matlab.System
    % untitled4 Add summary here
    %
    % This template includes the minimum set of functions required
    % to define a System object with discrete state.

    % Public, tunable properties
    properties

    end

    properties(DiscreteState)
        state
    end

    % Pre-computed constants
    properties(Access = private)

    end

    methods(Access = protected)
        function setupImpl(obj)
            % Perform one-time calculations, such as computing constants
            obj.state = 0;
        end

        function [y, state] = stepImpl(obj,u)
            % Implement algorithm. Calculate y as a function of input u and
            % discrete states.
            y = u * obj.state;
            obj.state = obj.state + 1;
            state = obj.state;
        end

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
            obj.state = 0;
        end
    end
end
