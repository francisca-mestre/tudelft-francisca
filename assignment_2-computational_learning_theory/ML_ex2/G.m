%Implementation of AdaBoost on the Fashion NIST dataset

dataset_t = dlmread('fashion57_train.txt');
dataset_v = dlmread('fashion57_test.txt');
e_plus_t = dataset_t(1:32,:);
e_minus_t = dataset_t(33:end,:);
e_plus_v = dataset_v(1:195,:);
e_minus_v = dataset_v(196:end,:);
w_plus_t = 1/size(dataset_t, 1)*ones(size(e_plus_t, 1),1);
w_minus_t = 1/size(dataset_t, 1)*ones(size(e_minus_t, 1),1);
y1 = ones(size(e_plus_t, 1), 1); y2 = zeros(size(e_minus_t, 1), 1); y_t = [y1; y2];
y1 = ones(size(e_plus_v, 1), 1); y2 = zeros(size(e_minus_v, 1), 1); y_v = [y1; y2];
T = 40; %10:10:60; 
error_app = zeros(1, length(T)); error_true = zeros(1, length(T));
for t = 1:length(T)
[hf, weights_f, weak_h] = training_AdaBoost(dataset_t, e_plus_t, e_minus_t, w_plus_t, w_minus_t, y_t, T(t));
%apparent error
[label_app] = prediction_AdaBoost(dataset_t, weak_h);
error_app(t) = sum(abs(label_app - y_t))/size(dataset_t, 1);

%true error
[label_true] = prediction_AdaBoost(dataset_v, weak_h);
error_true(t) = sum(abs(label_true - y_v))/size(dataset_v, 1);
end