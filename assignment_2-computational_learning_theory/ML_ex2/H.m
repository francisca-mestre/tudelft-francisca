n = [2 4 6 10 15 20];
dataset_t = dlmread('fashion57_train.txt');
e_plus_t = dataset_t(1:32,:);
e_minus_t = dataset_t(33:end,:);
dataset_v = dlmread('fashion57_test.txt');
e_plus_v = dataset_v(1:195,:);
e_minus_v = dataset_v(196:end,:);
y1 = ones(size(e_plus_v, 1), 1); y2 = zeros(size(e_minus_v, 1), 1); y_v = [y1; y2];
T = 10;

accuracy = zeros(1, length(n));
for i = 1:length(n)
    idx1 = randperm(size(e_plus_t,1),n(i));
    idx2 = randperm(size(e_minus_t,1),n(i));
    data_plus = e_plus_t(idx1, :);
    data_minus = e_minus_t(idx2, :);
    dataset = [data_plus; data_minus];
    w_plus = ones(size(data_plus,1)); w_minus = ones(size(data_minus,1));
    y = [ones(n(i),1);zeros(n(i),1)];
    [hf, weights_f, weak_h] = training_AdaBoost(dataset, data_plus, data_minus, w_plus, w_minus, y, T);
    [label] = prediction_AdaBoost(dataset_v, weak_h);
    error =  sum(abs(label - y_v))/size(dataset_v, 1);
    accuracy(i) = 1-error;
end
figure, plot(n, accuracy, '-o')
xlabel('Number of examples per class'), ylabel('Accuracy')