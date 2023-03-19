%BATTERY MANAGEMENT PROBLEM - THE "DP" ALGORITHM
% profile on
clear, clc
%% Initialization
for exp = 1:6
    global rateDischarge rateCharge N_SoC maxSoC N_peak maxPeak minPeak N_u minU maxU N_Z minZ maxZ
    
    T = 96;
    time = 0000:0025:2400;
    
    % Model parameters
    E = 1.2; eta = 0.95;
    rateDischarge = 1/(4*E*eta);
    rateCharge = eta/(4*E);
    NSOC = [5, 5, 5, 7, 7, 11];
    NLOAD = [5, 11, 11, 11, 15, 21];
    NACTION = [11, 11, 11, 11, 15, 21];
    NZ = [11, 11, 21, 21, 25, 31];
    input_name = strcat('disturbance_model_jan16_60days_G',num2str(exp),'.mat');
    output_name = strcat('results_jan16_60days_G',num2str(exp),'.mat');
    %     load('disturbance_model_july27_G1.mat')
    load(input_name)
    load('day_patterns.mat')
    n = size(day_patterns , 1);
    
    % Definition of the grid
    N_SoC = NSOC(exp); maxSoC = 1;
    N_peak = NLOAD(exp); maxPeak = 4.4; minPeak = 0;
    N_u = NACTION(exp); minU = -1.2; maxU = 1.2;
    N_Z = NZ(exp); minZ = -0.8; maxZ = 1.2;
    
    % System dynamics
    [dynSoC,dynPeak,dynLoad] = dynamicsEquations;
    systemDynamics = {dynSoC,dynPeak,dynLoad};
    
    % Cost
    [~, costTerminal] = costFunctions;
    
    peak_shaving = zeros(n, 1);
    peak_shaving_eps = zeros(n, 1);
    peak_shaving_zhat = zeros(n, 1);
    peak_shaving_zmax = zeros(n, 1);
    recursion_time = zeros(n, 1);
    realtime_time = zeros(n*(T-1), 1);
    for day = 16:16
        initial_time = tic;
        %     transitions = treat_python_data(transitions);
        transitions = disturbance_models{1};
        %% DP recursion
        % Initialize the value function for all t
        J = cell(1,T+1); uPolicy = cell(1,T);
        for t = 1:T+1
            J{t} = zeros(N_SoC,N_peak,N_peak);
            uPolicy{t} = zeros(N_SoC,N_peak,N_peak);
        end
        uPolicy{T+1} = [];
        
        % Recursion
        for t = T+1
            fprintf('This is time step %d. \n', t);
            for C = 1:N_SoC
                for P = 1:N_peak
                    for L = 1:N_peak
                        [c,p,l] = mapping(C,P,L); xT = [c,p,l];
                        J{t}(C,P,L) = costTerminal(xT);
                    end
                end
            end
        end
        for i = 1:T
            t = T-i+1;
            fprintf('This is time step %d. \n', t);
            transitionMatrix = transitions{t};
            [J{t},uPolicy{t}] = computeValueFunctionAndPolicy(J{t+1},systemDynamics,transitionMatrix);
        end
        recursion_time(day) = toc(initial_time);
        stochastic_dp_test
        realtime_time = mean(realtime_time);
    end
    save(output_name)
%     clear, clc
end