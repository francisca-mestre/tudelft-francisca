function u = getOptimalAction(x, u_cube)

global N_SoC maxSoC N_peak maxPeak minPeak
pointsSoC = linspace(0,maxSoC,N_SoC);
pointsPeak = linspace(minPeak,maxPeak,N_peak);

c = x(1); p = x(2); l = x(3);
F = griddedInterpolant({pointsSoC, pointsPeak, pointsPeak}, u_cube);
u = F(c, p, l);
% u = interpn(pointsSoC,pointsPeak,pointsPeak,u_cube,c,p,l,'linear',Inf);
% u = round(u, 1);

end