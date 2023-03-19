function [error, hypothesis] = decision_tree2(dataset, examples_plus, examples_minus, f_optimal, theta_optimal, w_plus, w_minus, side)
R_plus = []; L_plus = []; R_minus = []; L_minus = [];
rp = 0; rm = 0; lp = 0; lm = 0; wR_plus = []; wL_plus = []; wR_minus = []; wL_minus = [];
c = 0; classf1 = zeros(size(dataset,1), 1); classf2 = zeros(size(dataset,1), 1);

%training
% [f_optimal, theta_optimal, min_error] = training_decision_tree(dataset, examples_plus, examples_minus, w_plus, w_minus);
for e = 1:size(examples_plus, 1)
    if examples_plus(e, f_optimal) >= theta_optimal
        rp = rp+1; c = c+1;
        R_plus(rp,:) = examples_plus(e,:);
        wR_plus(rp,:) = w_plus(e);
        classf1(c) = 1; %classified 1
        classf2(c) = 0; %classified 2
    else
        lp = lp+1; c = c+1;
        L_plus(lp,:) = examples_plus(e,:);
        wL_plus(lp,:) = w_plus(e);
        classf1(c) = 0; %classified 2
        classf2(c) = 1; %classified 1
    end
end
for e = 1:size(examples_minus, 1)
    if examples_minus(e, f_optimal) >= theta_optimal
        rm = rm+1; c=c+1;
        R_minus(rm,:) = examples_minus(e, :);
        wR_minus(rm,:) = w_minus(e);
        classf1(c) = 1; %classified 1
        classf2(c) = 0; %classified 2
    else
        lm = lm+1; c=c+1;
        L_minus(lm,:) = examples_minus(e, :);
        wL_minus(lm,:) = w_minus(e);
        classf1(c) = 0; %classified 2
        classf2(c) = 1; %classified 1
    end
end
% for e = 1:size(dataset, 1)
%     if dataset(e, f_optimal) >= theta_optimal
%         rp = rp+1; c = c+1;
%         R_plus(rp,:) = dataset(e,:);
%         wR_plus(rp,:) = w_plus(e);
%         classf1(c) = 1; %classified 1
%         classf2(c) = 0; %classified 2
%     else
%         lp = lp+1; c = c+1;
%         L_plus(lp,:) = dataset(e,:);
%         wL_plus(lp,:) = w_plus(e);
%         classf1(c) = 0; %classified 2
%         classf2(c) = 1; %classified 1
%     end
% end
if side == 1 %if Right is class p and Left is class m
    hypothesis = classf1;
    error = sum(wL_plus)+sum(wR_minus);
elseif side == 2 %if Right is class n and Left is class p
    hypothesis= classf2;
    error = sum(wR_plus)+sum(wL_minus);
end

end