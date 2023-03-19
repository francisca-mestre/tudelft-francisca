function [hypothesis] = decision_tree(dataset, f_optimal, theta_optimal, w, side)
R_plus = []; L_plus = [];
r = 0; l = 0; wR = []; wL = [];
c = 0; classf1 = zeros(size(dataset,1), 1); classf2 = zeros(size(dataset,1), 1);

%training
% [f_optimal, theta_optimal, min_error] = training_decision_tree(dataset, examples_plus, examples_minus, w_plus, w_minus);

for e = 1:size(dataset, 1)
    if dataset(e, f_optimal) >= theta_optimal
        r = r+1; c = c+1;
        R_plus(r,:) = dataset(e,:);
        wR(r,:) = w(e);
        classf1(c) = 1; %classified 1
        classf2(c) = 0; %classified 2
    else
        l = l+1; c = c+1;
        L_plus(l,:) = dataset(e,:);
        wL(l,:) = w(e);
        classf1(c) = 0; %classified 2
        classf2(c) = 1; %classified 1
    end
end
if side == 1 %if Right is class p and Left is class m
    hypothesis = classf1;
%     error = sum(wL_plus)+sum(wR_minus);
elseif side == 2 %if Right is class n and Left is class p
    hypothesis= classf2;
%     error = sum(wR_plus)+sum(wL_minus);
end

end