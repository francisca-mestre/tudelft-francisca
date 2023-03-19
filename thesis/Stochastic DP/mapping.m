function [c,p,l] = mapping(C,P,L)

global N_SoC maxSoC N_peak maxPeak minPeak
pointsSoC = linspace(0,maxSoC,N_SoC);
pointsPeak = linspace(minPeak,maxPeak,N_peak);

c = pointsSoC(C);
p = pointsPeak(P);
l = pointsPeak(L);

end