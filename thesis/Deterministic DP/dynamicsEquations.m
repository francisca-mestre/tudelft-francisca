function [dynSoC,dynPeak,dynLoad] = dynamicsEquations
%RECURSION - Computes the optimal policy and value function at time step t
%
%Syntax: [dynSoC,dynPeak,dynLoad] = dynamicsEquations
%
%Inputs:
%
%Outputs:
%   dynSoC     - Dynamics of the state of charge of the system
%   dynPeak    - Dynamics of the peak load of the system
%   dynLoad    - Dynamics of the load of the system

%% SoC and peak load anonymous functions
global rateCharge rateDischarge maxPeak minPeak

dynSoC = @(s1,s2,s3,u,z) s1+max(u,0)*rateCharge+min(u,0)*rateDischarge;
dynPeak = @(s1,s2,s3,u,z) max(minPeak, min(maxPeak,max(0,max(s2,(s3+z+u)))));
dynLoad = @(s1,s2,s3,u,z) s3+z;  % min(maxPeak,max(0,s3+z));

end

