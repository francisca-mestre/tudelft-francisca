function [v_hat,u] = retrieveJAndU(x,J1,systemDynamics,transitionVectorL)

global  N_u minU maxU rateCharge rateDischarge
pointsU = linspace(minU,maxU,N_u);

% if x(1) == 1
%     possible_u = pointsU(pointsU >= (-x(1)/rateDischarge) & pointsU <= 0);
%     value_u = zeros(1,length(possible_u));
%     for i = 1:length(possible_u)
%         u = possible_u(i);
%         [expectation] = computeExpectation(x,J1,systemDynamics,u,transitionVectorL);
%         value_u(i) = expectation;
%     end
%
% elseif x(1) == 0
%     possible_u = pointsU(pointsU >= 0 & pointsU <= ((1-x(1))/rateCharge));
%     value_u = zeros(1,length(possible_u));
%     for i = 1:length(possible_u)
%         u = possible_u(i);
%         [expectation] = computeExpectation(x,J1,systemDynamics,u,transitionVectorL);
%         value_u(i) = expectation;
%     end
%
% else
possible_u = pointsU(pointsU >= (-x(1)/rateDischarge) & pointsU <= ((1-x(1))/rateCharge));
value_u = zeros(1,length(possible_u));
for i = 1:length(possible_u)
    u = possible_u(i);
    [expectation] = computeExpectation(x,J1,systemDynamics,u,transitionVectorL);
    value_u(i) = expectation;
end
% end

v_hat = min(value_u); % find minimum value from all possible actions
% idx_set = value_u == v_hat; % all indexes of actions that yield the minimum value
% u_list_reduced = possible_u(idx_set);
% u = max(u_list_reduced);
u = max(possible_u(value_u == v_hat));
end