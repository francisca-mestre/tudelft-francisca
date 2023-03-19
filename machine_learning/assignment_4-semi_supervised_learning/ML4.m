% ML - Assignment 4

%% TWO GAUSSIANS
dataset = dlmread('twoGaussians.txt');
d = 11; l = 8; % 8 training (labeled) examples per class
dataset_p = dataset(1:5000,1:d); y_p = dataset(1:5000,12);
dataset_m = dataset(5001:end,1:d); y_m = dataset(5001:end,12);
usize = [0 8 16 32 64 128 256 512]; % unlabeled examples
idxp = randperm(size(dataset_p,1),l);
trainingset_p = dataset_p(idxp,:); trainingy_p = y_p(idxp);
idxm = randperm(size(dataset_m,1),l);
trainingset_m = dataset_m(idxm,:); trainingy_m = y_m(idxm);
lset = [trainingset_p, trainingy_p; trainingset_m, trainingy_m];
dataset4test = dataset; dataset4test([idxp 5000+idxm],:) = [];


%% DATASET 1 - FINISHED
% r1x_p = normrnd(0, 0.2, 4500, 1); r1y_p = normrnd(0,0.2,4500,1);
% r2x_p = normrnd(0.5,1, 250, 1); r2y_p = normrnd(0,0.2,250,1);
% r3x_p = normrnd(-0.5, 1, 250, 1); r3y_p = normrnd(0,0.2,250,1);
% r1x_m = normrnd(2.5, 0.2, 5000, 1); r1y_m = normrnd(0,0.1,5000,1);
% dataset1_p = [r1x_p r1y_p ones(4500,1); r2x_p r2y_p ones(250,1); r3x_p r3y_p ones(250,1)];
% dataset1_m = [r1x_m r1y_m -ones(5000,1)];
% d = size(dataset1_p,2)-1;
% usize = 527;
% idxp = randperm(size(dataset1_p,1),2);
% trainingset_p = dataset1_p(idxp,1:d); trainingy_p = dataset1_p(idxp,d+1);
% idxm = randperm(size(dataset1_m,1),2);
% trainingset_m = dataset1_m(idxm,1:d); trainingy_m = dataset1_m(idxm,d+1);
% lset = [trainingset_p, trainingy_p; trainingset_m, trainingy_m];
% dataset4test = [dataset1_p; dataset1_m]; dataset4test([idxp 5000+idxm],:) = [];
% 
% figure, plot(dataset1_p(:,1), dataset1_p(:,2), 'o'), hold on
% plot(dataset1_m(:,1), dataset1_m(:,2), 'o'), hold off
% xlabel('Feature 1'), ylabel('Feature 2'), axis equal
% 
% l = 2; % 2 training (labeled) examples per class

%% 
% r1x_p = normrnd(0, 0.2, 3000, 1); r1y_p = normrnd(0,0.2,3000,1);
% r2x_p = normrnd(0.5,1, 1000, 1); r2y_p = normrnd(0,0.2,1000,1);
% r3x_p = normrnd(-0.5, 1, 500, 1); r3y_p = normrnd(0,0.2,500,1);
% r1x_m = normrnd(3, 0.2, 5000, 1); r1y_m = normrnd(0,0.1,5000,1);
% % r2x_m = normrnd(0.2, 0.5, 2500, 1); r2y_m = normrnd(0,0.5,2500,1);
% % rx_m = normrnd(2, 0.2, 5000, 1); ry_m = normrnd(1.5,0.2,2500,1);
% dataset1_p = [r1x_p r1y_p ones(4000,1); r2x_p r2y_p ones(500,1); r3x_p r3y_p ones(500,1)];
% dataset1_m = [r1x_m r1y_m -ones(5000,1)]; %r2x_m r2y_m -ones(2500,1)];
% d = size(dataset1_p,2)-1;
% usize = 527;
% idxp = randperm(size(dataset1_p,1),2);
% trainingset_p = dataset1_p(idxp,1:d); trainingy_p = dataset1_p(idxp,d+1);
% idxm = randperm(size(dataset1_m,1),2);
% trainingset_m = dataset1_m(idxm,1:d); trainingy_m = dataset1_m(idxm,d+1);
% lset = [trainingset_p, trainingy_p; trainingset_m, trainingy_m];
% dataset4test = [dataset1_p; dataset1_m]; dataset4test([idxp 5000+idxm],:) = [];
% 
% figure, plot(dataset1_p(:,1), dataset1_p(:,2), 'o'), hold on
% plot(dataset1_m(:,1), dataset1_m(:,2), 'o'), hold off
% xlabel('Feature 1'), ylabel('Feature 2'), axis equal

%% DATASET 2
% % load('dataset2_p.mat'); load('dataset2_m.mat');
% r1x_p = normrnd(0.5, 0.5, 500, 1); r1y_p = normrnd(0,0.5,500,1); %SAVE THIS DATASET
% r2x_p = normrnd(0.5, 0.2, 4500, 1); r2y_p = normrnd(2.5,0.2,4500,1);
% rx_m = normrnd(2, 0.2, 5000, 1); ry_m = normrnd(1.5,0.2,5000,1);
% dataset2_p = [r1x_p r1y_p ones(500,1); r2x_p r2y_p ones(4500,1)];
% dataset2_m = [rx_m ry_m -ones(5000,1)];
% d = size(dataset2_p,2)-1;
% usize = 527;
% idxp = randperm(size(dataset2_p,1),2);
% trainingset_p = dataset2_p(idxp,1:1:d); trainingy_p = dataset2_p(idxp,d+1);
% idxm = randperm(size(dataset2_m,1),2);
% trainingset_m = dataset2_m(idxm,1:1:d); trainingy_m = dataset2_m(idxm,d+1);
% lset = [trainingset_p, trainingy_p; trainingset_m, trainingy_m];
% dataset4test = [dataset2_p; dataset2_m]; dataset4test([idxp 5000+idxm],:) = [];
% 
% figure, plot(dataset2_p(:,1), dataset2_p(:,2), 'o'), hold on
% plot(dataset2_m(:,1), dataset2_m(:,2), 'o'), hold off
% xlabel('Feature 1'), ylabel('Feature 2'), axis equal
% 
% l = 2; % 2 training (labeled) examples per class
%% 
T = 100;
error_aux_sup = zeros(T,length(usize));
error_aux_tsvm = zeros(T, length(usize));
error_aux_em = zeros(T,length(usize));
loss_aux_sup = zeros(T,length(usize));
loss_aux_tsvm = zeros(T,length(usize));
loss_aux_em = zeros(T,length(usize));

%% Supervised setting
disp('Supervised setting')
% minimizing the objective function (training)
J_sup = @(o_vector) 0;
for i = 1:2*l
    J_sup = @(o_vector)(J_sup(o_vector) + (1/(2*l))*(dot(o_vector(1:d),lset(i,1:d)) + o_vector(d+1) - lset(i,d+1))^2);
end
initial_cond = (1+1)*rand(d+1,1);
options = optimoptions('fminunc','MaxFunctionEvaluations',30000);
[x_optimal, ~, flag] = fminunc(J_sup, initial_cond);
w = x_optimal(1:d); w0 = x_optimal(d+1);

%   testing
for t = 1:T
    disp(t)
    for m = 1:length(usize)
        u = usize(m);
        idx = randperm(size(dataset4test,1),u);
        uset = dataset4test(idx,:);
        classfy = zeros(1, size(uset,1));
        for i = 1:size(uset,1)
            classfy(i) = sign(dot(w,uset(i,1:d))+w0);
        end
        misclassf1 = uset(:,d+1) - classfy';
        misclassf1(misclassf1~=0) = 1;
        error_aux_sup(t, m) = mean(misclassf1);
        loss_aux_sup(t, m) = (1/size(uset,1))*sum((misclassf1).^2);
    end
end


%% Semi-supervised setting - TSVM Low-density separation assumption
disp('TSVM')
J_tsvm_l = @(o_vector) 0; labeld = 2*l;
for i = 1:labeld
    J_tsvm_l = @(o_vector)(J_tsvm_l(o_vector) + ((1/(labeld))*(dot(o_vector(1:d),lset(i,1:d)) + o_vector(d+1) - lset(i,d+1))^2));
end

aux_h = [-1, 1];
% lambda = 1e-2;
for t = 1:T
    disp(t)
    for m = 1:length(usize)
        u = usize(m); lambda = 1/u;
        idx = randperm(size(dataset4test,1),u);
        uset = dataset4test(idx,:); %wholeset = [lset; uset];
        
        J_tsvm_u = @(o_vector) 0;
        if u ~= 0
            count_u = 0;
            for i = labeld+1:labeld+u
                count_u = count_u+1;
                J_tsvm_u = @(o_vector)(J_tsvm_u(o_vector) + (dot(o_vector(1:d),uset(count_u,1:d)) + o_vector(d+1) - aux_h(o_vector(d+1+count_u)))^2);
            end
            J_tsvm = @(o_vector)(J_tsvm_l(o_vector) + lambda*J_tsvm_u(o_vector));
            nvars = d+1+u;
            IntCon = d+2:d+1+u;
            lb = [-10*ones(d+1,1); ones(u,1)]; ub = [10*ones(d+1,1); 2*ones(u,1)];
        else
            J_tsvm = @(o_vector)(J_tsvm_l(o_vector));
            nvars = d+1;
            IntCon = [];
            lb = -10*ones(d+1,1); ub = -lb;
        end
        options = optimoptions('ga','MaxGenerations',300*nvars);
        [x_optimal, fval, exitflag] = ga(J_tsvm,nvars,[],[],[],[],lb,ub,[],IntCon, options);
        w = x_optimal(1:d); w0 = x_optimal(d+1); h = aux_h(x_optimal(d+2:d+1+u));
        classfy = zeros(size(uset,1),1);
        %         for i = 1:size(uset,1)
        %             classfy(i) = sign(dot(w,uset(i,1:d))+w0);
        %         end
        misclassf = uset(:,d+1) - h';
        misclassf(misclassf~=0) = 1;
        error_aux_tsvm(t,m) = mean(misclassf);
        loss_aux_tsvm(t, m) = (1/size(uset,1))*sum((misclassf).^2);
    end
end

%% Semi-supervised setting - EM Cluster assumption
disp('EM')
for t = 1:T
    disp(t)
    for m = 1:length(usize)
        u = usize(m); labeld = size(lset,1);
        idx = randperm(size(dataset4test,1),u);
        uset = dataset4test(idx,:); luset  = [];
        classfy = zeros(1,u);
        
        J_em1 = @(o_vector) 0;
        for i = 1:labeld
            J_em1 = @(o_vector)(J_em1(o_vector) + ((dot(o_vector(1:d),lset(i,1:d)) + o_vector(d+1) - lset(i,d+1))^2));
        end
        J_em = @(o_vector) ((1/(2*l))*J_em1(o_vector));
        initial_cond = (1+1)*rand(d+1,1);
        options = optimoptions('fminunc','MaxFunctionEvaluations',30000);
        [x_optimal, ~, flag] = fminunc(J_em, initial_cond);
        w = x_optimal(1:d); w0 = x_optimal(d+1);
        for n = 1:u
            u_ex = uset(n,1:d);
            classfy2 = sign(dot(w,u_ex)+w0);
            if classfy2 == 1
                luset = [luset; u_ex 1];
            else
                luset = [luset; u_ex -1];
            end
            ulabeld = size(luset,1);
            J_em = @(o_vector) (1/(2*l+size(luset,1)))*(J_em1(o_vector) + (dot(o_vector(1:d),luset(n,1:d)) + o_vector(d+1) - luset(n,d+1))^2);
            initial_cond = (1+1)*rand(d+1,1);
            options = optimoptions('fminunc','MaxFunctionEvaluations',30000);
            [x_optimal, ~, flag] = fminunc(J_em, initial_cond);
            w = x_optimal(1:d); w0 = x_optimal(d+1);
        end
        for i = 1:size(luset,1)
            classfy(i) = sign(dot(w,luset(i,1:d))+w0);
        end
        if ~isempty(luset)
            misclassf2 = uset(:,d+1) - luset(:,d+1);
        else
            misclassf2 = uset(:,d+1) - [];
        end
        misclassf2(misclassf2~=0) = 1;
        error_aux_em(t, m) = mean(misclassf2);
        loss_aux_em(t, m) = (1/u)*sum((misclassf2).^2);
    end
end

%% 
error_sup = mean(error_aux_sup); loss_sup = mean(loss_aux_sup);
error_tsvm = mean(error_aux_tsvm); loss_tsvm = mean(loss_aux_tsvm);
error_em = mean(error_aux_em); loss_em = mean(loss_aux_em);
figure, plot(usize, error_sup,'-o'), hold on, plot(usize, error_tsvm,'-o'), plot(usize, error_em, '-o')
legend('Supervised learning', 'Semi-supervised 1 - TSVM', 'Semi-supervised 2 - EM')
xlabel('Nº of unlabeled samples'), ylabel('Error')
figure, plot(usize, loss_sup,'-o'), hold on, plot(usize, loss_tsvm,'-o'), plot(usize, loss_em, '-o')
legend('Supervised learning', 'TSVM - Low-density separation', 'EM - Cluster assumption')
xlabel('Nº of unlabeled samples'), ylabel('Expected square loss')