%BATTERY MANAGEMENT PROBLEM - THE "DP" ALGORITHM
clear, clc
load('demand_per_day_2018.mat')
for d = 1:length(demand_per_day)
   demand_per_day(d, :) = demand_per_day(d, :); 
end
%% Initialization
global rateDischarge rateCharge N_SoC maxSoC N_peak maxPeak minPeak N_u minU maxU N_Z maxZ minZ

T = 96;
time = 0000:0025:2400;

% Model parameters
E = 1.2; eta = 0.95;
rateCharge = eta/(4*E);  % 0.22;
rateDischarge = 1/(4*E*eta);  % 0.24;

% Definition of the grid
N_SoC = 5; maxSoC = 1;
N_peak = 11; minPeak = 0; maxPeak = 4.4;
N_u = 11; minU = -1.2; maxU = 1.2;
N_Z = 21; minZ = -0.6; maxZ = 0.6;

% System dynamics
[dynSoC,dynPeak,dynLoad] = dynamicsEquations;
systemDynamics = {dynSoC,dynPeak,dynLoad};

% Cost
[~, costTerminal] = costFunctions;

% Initialize the value function for all t
J = cell(1,T+1); uPolicy = cell(1,T);
for t = 1:T+1
    J{t} = zeros(N_SoC,N_peak,N_peak);
end
for t = 1:T
    uPolicy{t} = zeros(N_SoC,N_peak,N_peak);
end

% Backward dynamic programming with aggregation and approximate expectation
n = size(demand_per_day , 1);
set_data_SL = zeros(96*n , 3);
set_label_SL = zeros(96*n , 1);
peakReduction_detDP = zeros(n , 1);
optimal_policies = cell(n , 1);
peaks_after_DP = zeros(n , 1);
idx = 1;
for day = 1:n
    tic
    fprintf('DAY %d. \n', day)
    dayLoad = demand_per_day(day , :);
    
    % Deterministic "uncertainty" values
    Z = zeros(T,1);
    for t = 1:T
        Z(t) = dayLoad(t+1)-dayLoad(t);
    end
    
    % Calculate J_T
    t = T+1;
    fprintf('This is time step %d. \n', t);
    for C = 1:N_SoC
        for P = 1:N_peak
            for L = 1:N_peak
                [c,p,l] = mapping(C,P,L); xT = [c,p,l];
                J{t}(C,P,L) = costTerminal(xT);
            end
        end
    end
    
    % Calculate J_t
    for i = 1:T
        t = T-i+1;
        fprintf('This is time step %d. \n', t);
        z = Z(t);
        [J{t},uPolicy{t}] = computeValueFunctionAndPolicy(J{t+1},z,systemDynamics);
    end
    optimal_policies{day} = uPolicy;
    toc
end

