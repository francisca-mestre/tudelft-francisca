function z = getRandomZ(transitionMatrix,x)

global N_peak maxPeak minPeak N_Z minZ maxZ
pointsPeak = linspace(minPeak,maxPeak,N_peak);
pointsZ = linspace(minZ,maxZ,N_Z);
% pointsZ = linspace(-0.3157,0.3875,N_Z);

[~,i] = min(abs(x(3)-pointsPeak));
trans = transitionMatrix(i,:);
transCumulativeSum = cumsum(trans);

r = rand;
idx = sum(r>transCumulativeSum)+1;
z = pointsZ(idx);

end