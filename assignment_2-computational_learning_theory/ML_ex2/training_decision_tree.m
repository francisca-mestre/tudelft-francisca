function [f_optimal, theta_optimal, min_error, side] = training_decision_tree(dataset, examples_plus, examples_minus, w_plus, w_minus)
% This function is used for training the decision stumps
% INPUTS:   dataset - all examples ...
%           examples_plus - examples from class 1 of the dataset
%           examples_minus - examples from class 2 of the dataset
%           w_plus - weights of the examples from class 1
%           w_minus - weights of the examples from class 2
% OUTPUTS:  f_optimal - optimal feature
%           theta_optimal - optimal threshold
%           min_error - training error
%           side - most accurate partition of the classes

N_features = size(dataset, 2); N_examples = size(dataset, 1);
theta = zeros(N_examples, N_features); error = zeros(N_examples, N_features);
side_m = zeros(N_examples, N_features);
aux = zeros(N_examples, N_features); aux_i = zeros(N_examples, N_features);

for f = 1:N_features
    [aux(:,f), aux_i(:,f)] = sort(dataset(:,f));
    for ex = 1:N_examples
        if ex == 1
            theta(ex, f) = -10 + (aux(ex, f)+10)*rand;
        elseif ex ~= 1
            theta(ex, f) = aux(ex-1, f) + (aux(ex, f)-aux(ex-1, f))*rand;
        end
        R_plus = []; L_plus = []; R_minus = []; L_minus = [];
        rp = 0; rm = 0; lp = 0; lm = 0; wR_plus = []; wL_plus = []; wR_minus = []; wL_minus = [];
        for p = 1:size(examples_plus, 1)
            if examples_plus(p, f) >= theta(ex, f)
                rp = rp+1;
                R_plus(rp,:) = examples_plus(p,:);
                wR_plus(rp,:) = w_plus(p);
            else
                lp = lp+1;
                L_plus(lp,:) = examples_plus(p,:);
                wL_plus(lp,:) = w_plus(p);
            end
        end
        for m = 1:size(examples_minus, 1)
            if examples_minus(m, f) >= theta(ex, f)
                rm = rm+1;
                R_minus(rm,:) = examples_minus(m,:);
                wR_minus(rm,:) = w_minus(m);
            else
                lm = lm+1;
                L_minus(lm,:) = examples_minus(m, :);
                wL_minus(lm,:) = w_minus(m);
            end
        end
        error1 = sum(wL_plus)+sum(wR_minus); %if Right is class p and Left is class m
        error2 = sum(wR_plus)+sum(wL_minus); %if Right is class m and Left is class p
        [error(ex, f), side_m(ex, f)] = min([error1, error2]);
    end
end

min_error = min(min(error));
[line_m, f_optimal_m] = find(error == min_error);
f_optimal = f_optimal_m(1);
example = aux_i(line_m(1));
side = side_m(example, f_optimal);
theta_optimal_m = theta(line_m, f_optimal_m);
theta_optimal = theta_optimal_m(1, 1);
end