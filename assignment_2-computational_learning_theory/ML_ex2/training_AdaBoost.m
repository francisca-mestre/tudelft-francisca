function [hf, weights_f, weak_h] = training_AdaBoost(dataset_t, e_plus_t, e_minus_t, w_plus, w_minus, y, T)
% This function is used for training the AdaBoost algorithm, i.e., finding the hypothesis weights
% INPUTS:   dataset_t - complete training set of examples
%           e_plus_t - set of training examples from Class 1
%           e_minus_t - set of training examples from Class 2
%           w_plus - weights of the examples from Class 1
%           e_minus - weights of the examples from Class 2
%           y - known lables of the training set
%           T - number of iterations
% OUTPUTS:  hf - final hypothesis
%           weights_f - final sample weights
%           weak_h - structure containing optimal feature, threshold, side
%           and weights of all T weak hypothesis

B = zeros(1, T);
h = zeros(size(dataset_t,1), T);
p = zeros(size(dataset_t,1), T);
%training the decision tree
w = [w_plus; w_minus];
weak_h.f_optimal = zeros(1, T); weak_h.theta_optimal = zeros(1, T);
weak_h.a = zeros(1,T); weak_h.side = zeros(1, T);
for t = 1:T
    p(:, t) = w/(sum(w));
    p_plus = p(1:size(e_plus_t, 1),t);
    p_minus = p(size(e_plus_t, 1)+1:end,t);
    %call WeakLearn
    [f, theta, ~, side] = training_decision_tree(dataset_t, e_plus_t, e_minus_t, p_plus, p_minus);
    [h(:,t)] = decision_tree(dataset_t, f, theta, w, side);
    error = sum(p(:,t).*abs(h(:,t)-y));
    B(t) = error/(1-error);
    w = w.*(B(t).^(1-abs(h(:,t)-y)));
    weak_h.f_optimal(t) = f; weak_h.theta_optimal(t) = theta;
    weak_h.a(t) = (1/2)*log(1/B(t));  weak_h.side(t) = side;
end

hf = zeros(size(dataset_t,1), 1);
for e = 1:size(dataset_t,1)
    if sum((log10((1./B)).*h(e,:))) >= (1/2)*sum(log10(1./B))
        hf(e) = 1;
    else
        hf(e) = 0;
    end
end
weights_f = p(:,T);
end