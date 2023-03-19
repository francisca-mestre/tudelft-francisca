function [ExpectedValue] = computeExpectation(x,J1,systemDynamics,u,transitionVectorL)

global  N_SoC maxSoC N_peak maxPeak minPeak N_Z minZ maxZ
pointsSoC = linspace(0,maxSoC,N_SoC);
pointsPeak = linspace(minPeak,maxPeak,N_peak);
pointsZ = linspace(minZ,maxZ,N_Z);

F = griddedInterpolant({pointsSoC, pointsPeak, pointsPeak}, J1);

ExpectedValue = 0;
for i = 1:N_Z
    z = pointsZ(i);
    next_c = systemDynamics{1}(x(1),x(2),x(3),u,z);
    next_p = systemDynamics{2}(x(1),x(2),x(3),u,z);
    next_l = systemDynamics{3}(x(1),x(2),x(3),u,z);
%     expct = interpn(pointsSoC,pointsPeak,pointsPeak,J1,next_c,next_p,next_l,'linear',Inf);
    expct = F(next_c, next_p, next_l);
    ExpectedValue = ExpectedValue+expct*transitionVectorL(i);
end

end