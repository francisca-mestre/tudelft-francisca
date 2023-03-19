%% Exercise 1 
%% (a)
%Strategy A
e = 1:3;
t = 1:4;
z = [0 0 1 0; 0.1 0 0 0.9; 0.2 0.1 0 0];
pA = zeros(length(e), length(t)); pA(:, 1) = 1/3;
L = zeros(length(e), 1);
for s = 2:length(t)
    for i = 1:length(e)
        L(i) = L(i) + z(i, s-1);
    end
    [val, b] = min(L);
    pA(:, s) = zeros(length(e), 1); pA(b, s) = 1;
end

%Strategy B
pB = zeros(length(e), length(t)); pB(:, 1) = 1/3;
L = zeros(length(e), 1);
for s = 2:length(t)
    for i = 1:length(e)
        L(i) = L(i) + z(i, s-1);
    end
    C = sum(exp(-L));
    pB(:, s) = exp(-L)/C;
end

%% (b)
t_mixlossA = 0; t_mixlossB = 0;
for s = 1:length(t)
   t_mixlossA = t_mixlossA - log(sum(pA(:,s).*exp(-z(:,s))));
   t_mixlossB = t_mixlossB - log(sum(pB(:,s).*exp(-z(:,s))));
end

%% (c)
e_regretA = t_mixlossA - min(sum(z,2));
e_regretB = t_mixlossB - min(sum(z,2));
