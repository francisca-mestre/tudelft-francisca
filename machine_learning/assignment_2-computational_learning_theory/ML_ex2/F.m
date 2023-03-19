%Implementation of AdaBoost on the simple dataset

load('simple_dataset.mat');
e_plus_t = examples_plus; e_minus_t = examples_minus;
w_plus = 1/size(dataset_t, 1)*ones(size(examples_plus, 1),1);
w_minus = 1/size(dataset_t, 1)*ones(size(examples_minus, 1),1);
y1 = ones(size(e_plus_t,1), 1); %class 1
y2 = zeros(size(e_minus_t,1), 1); %class 0
y = [y1; y2]; T = 100;

[hf, weights_f, ~] = training_AdaBoost(dataset_t, e_plus_t, e_minus_t, w_plus, w_minus, y, T);

