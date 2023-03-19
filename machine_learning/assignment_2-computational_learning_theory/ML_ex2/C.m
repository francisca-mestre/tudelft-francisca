% Find optimal feature and threshold theta

%generating dataset
% examples_plus = [normrnd(0,1,4,1), normrnd(0,1,4,1)];
% examples_minus = [normrnd(2,1,3,1), normrnd(0,1,3,1)];
% dataset_t = [examples_plus; examples_minus];
load('simple_dataset.mat');
w_plus = 1/size(dataset_t, 1)*ones(size(examples_plus, 1),1);
w_minus = 1/size(dataset_t, 1)*ones(size(examples_minus, 1),1);

figure %scatterplot of the dataset
scatter(examples_plus(:,1), examples_plus(:,2));
c = string(1:size(examples_plus,1));
dx = - 0.1; dy = 0.1; % displacement so the text does not overlay the data points
text(examples_plus(:,1)+dx, examples_plus(:,2)+dy, c, 'Fontsize', 8);
hold on
scatter(examples_minus(:,1), examples_minus(:,2));
c = string(size(examples_plus,1)+1:size(dataset_t,1));
dx = -0.1; dy = 0.1; % displacement so the text does not overlay the data points
text(examples_minus(:,1)+dx, examples_minus(:,2)+dy, c, 'Fontsize', 8);
legend('Class 1', 'Class 2')
xlabel('Feature 1'), ylabel('Feature 2')
hold off

%training the decision stump
[f_optimal, theta_optimal, min_error, side] = training_decision_tree(dataset_t, examples_plus, examples_minus, w_plus, w_minus);