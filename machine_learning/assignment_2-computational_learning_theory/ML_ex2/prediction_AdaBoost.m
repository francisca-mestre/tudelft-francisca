function [label] = prediction_AdaBoost(dataset, weak_h)
% This function is used to predict labels with AdaBoost
% INPUT:    dataset - complete set of examples to predict
%           weak_h - structure containing optimal feature, threshold, side
%           and weights of all T weak hypothesis
% OUTPUT:   label - assigned labels of all examples in the dataset

a = weak_h.a/sum(weak_h.a);
T = length(a);
hypothesis = zeros(size(dataset,1), T);
w = 1/size(dataset,1)*ones(1, size(dataset,1));
for t = 1:T
    f = weak_h.f_optimal(t); theta = weak_h.theta_optimal(t); side = weak_h.side(t);
    [hypothesis(:, t)] = decision_tree(dataset, f, theta, w, side);
end
label = zeros(size(dataset,1), 1);
for e = 1:size(dataset,1)
    aux_h = hypothesis(e, :);
    aux_h(aux_h==0) = -1;
    aux = a*aux_h';
    if aux >= 0
        label(e) = 1;
    elseif aux < 0
        label(e) = 0;
    end
end
end