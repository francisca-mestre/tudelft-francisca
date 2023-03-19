function [costStage, costTerminal] = costFunctions
%STAGE_TERMINAL_COST - Outputs stage cost and terminal cost functions
%
%Syntax: [costStage, costTerminal] = costStageTerminal
%
%Inputs:
%
%Outputs:
%   costStage    - Stage cost anonymous function
%   costTerminal - Terminal cost anonymous function

%% Stage and terminal cost anonymous functions

costStage = @(x,u) 0;
costTerminal = @(x) x(2);

end

