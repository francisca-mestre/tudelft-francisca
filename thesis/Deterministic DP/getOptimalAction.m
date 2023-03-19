function u = getOptimalAction(x, u_cube)

global N_SoC maxSoC N_peak maxPeak minPeak
pointsSoC = linspace(0,maxSoC,N_SoC);
pointsPeak = linspace(minPeak,maxPeak,N_peak);

c = x(1); p = x(2); l = x(3);
if c < 0
    c = 0;
end
if c > 1
    c = 1;
end
if p < 0
    p = 0;
end
if p > maxPeak
    p = maxPeak;
end
if l < 0
    l = 0;
end
if l > maxPeak
    l = maxPeak;
end

u = interpn(pointsSoC,pointsPeak,pointsPeak,u_cube,c,p,l,'linear',Inf);

end