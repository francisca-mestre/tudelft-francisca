% Find optimal feature and threshold theta

dataset_t = dlmread('fashion57_train.txt');
dataset_v = dlmread('fashion57_test.txt');
examples_plus_t = dataset_t(1:32,:);
examples_minus_t = dataset_t(33:end,:);
examples_plus_v = dataset_v(1:195,:);
examples_minus_v = dataset_v(196:end,:);

% training
w_plus = 1/size(dataset_t, 1)*ones(size(examples_plus_t, 1), 1);
w_minus = 1/size(dataset_t, 1)*ones(size(examples_minus_t, 1), 1);
[f_optimal, theta_optimal, min_error, side] = training_decision_tree(dataset_t, examples_plus_t, examples_minus_t, w_plus, w_minus);
% validation with test set
w_plus = 1/size(dataset_v, 1)*ones(size(examples_plus_v, 1), 1);
w_minus = 1/size(dataset_v, 1)*ones(size(examples_minus_v, 1), 1);
w = [w_plus; w_minus]; y = [ones(size(examples_plus_v,1),1); zeros(size(examples_minus_v,1),1)];
% [error_test, ~] = decision_tree(dataset_v, examples_plus_v, examples_minus_v, f_optimal, theta_optimal, w_plus, w_minus, side);
[h] = decision_tree2(dataset_v, f_optimal, theta_optimal, w, side);
error_test = sum(abs(h-y))/size(dataset_v,1);