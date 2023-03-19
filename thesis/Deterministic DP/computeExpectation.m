function [expectation] = computeExpectation(x,J1,z,systemDynamics,u)

global  N_SoC maxSoC N_peak maxPeak minPeak
pointsSoC = linspace(0,maxSoC,N_SoC);
pointsPeak = linspace(minPeak,maxPeak,N_peak);

F = griddedInterpolant({pointsSoC, pointsPeak, pointsPeak}, J1);

next_c = systemDynamics{1}(x(1),x(2),x(3),u,z);
next_p = systemDynamics{2}(x(1),x(2),x(3),u,z);
next_l = systemDynamics{3}(x(1),x(2),x(3),u,z);

expectation = F(next_c, next_p, next_l);

end