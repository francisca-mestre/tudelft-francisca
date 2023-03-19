function [v_hat,u] = retrieveJAndU(x,J1,z,systemDynamics)

global  N_u minU maxU rateCharge rateDischarge
pointsU = linspace(minU,maxU,N_u);

possible_u = pointsU(pointsU >= (-x(1)/rateDischarge) & pointsU <= ((1-x(1))/rateCharge));
value_u = zeros(1,length(possible_u));
for i = 1:length(possible_u)
    u = possible_u(i);
    [expectation] = computeExpectation(x,J1,z,systemDynamics,u);
    value_u(i) = expectation;
end

v_hat = min(value_u); % find minimum value from all possible actions
idx_set = value_u == v_hat; % all indexes of actions that yield the minimum value
u_list_reduced = possible_u(idx_set);
u = max(u_list_reduced);

end