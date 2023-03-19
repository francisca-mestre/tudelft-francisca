% -------------------3.----------------------
% m_minus = 1;
% m_plus = 2;
% a = -10:0.1:10;
% y = abs(m_plus-m_minus+a);
% plot(a, y), xlabel('a'), ylabel('||m+ - m- + a||')

% ------------------4.----------------------
fid = fopen('digits.txt', 'r');
i = 0;
dataset = zeros(20000, 21);
while ~feof(fid)
    i = i+1;
    tline = fgetl(fid);
    temporary = str2double(strsplit(tline,','));
    dataset(i, :) = temporary;
end
fclose(fid);
class_plus_data = dataset(1:10000,:);
class_minus_data = dataset(10001:20000, :);

lambda = [0 1 10 100 1000 10000];     %user defined
n_exp = 100; %number of experiments
aux_error_true = zeros(1,n_exp);
aux_error_ap = zeros(1, n_exp);
error_avg_true = zeros(1, length(lambda));
error_avg_ap = zeros(1, length(lambda));
fval = zeros(n_exp, length(lambda));
m_plus = zeros(n_exp, 21);
m_minus = zeros(n_exp, 21);
avg_m_plus = zeros(length(lambda), 21);
avg_m_minus = zeros(length(lambda), 21);
sd_m_plus = zeros(length(lambda), 21);
sd_m_minus = zeros(length(lambda), 21);
for k = 1:length(lambda)
    for j = 1:n_exp
        
        %training
        N_plus = 1000; %size(class_plus_data, 1);
        N_minus = 1000; %size(class_minus_data, 1);
        initial_cond = (2+2)*rand(1, 43);
        a = zeros(1, length(lambda));
        training_plus_data = class_plus_data(randperm(size(class_plus_data, 1), N_plus), :);
        training_minus_data = class_minus_data(randperm(size(class_minus_data, 1), N_minus), :);
        
        J_plus = @(o_vector) 0;
        for i = 1:N_plus
            J_plus = @(o_vector)(J_plus(o_vector) + norm((training_plus_data(i,:) - o_vector(1:21)), 1));
        end
        
        J_minus = @(o_vector) 0;
        for i = 1:N_minus
            J_minus = @(o_vector)(J_minus(o_vector) + norm((training_minus_data(i,:) - o_vector(22:42)), 1));
        end
        J = @(o_vector)(J_plus(o_vector) + J_minus(o_vector) + lambda(k).*norm((o_vector(1:21) - o_vector(22:42) + o_vector(43)), 1));
        options = optimoptions('fminunc','MaxFunctionEvaluations',30000);
        [x_optimal, fval(j, k), flag] = fminunc(J, initial_cond, options);
        m_plus(j, :) = x_optimal(1:21);
        m_minus(j, :) = x_optimal(22:42);
        a(k) = x_optimal(43);
        
        
        %validation
        N_plus_val = 1000;
        N_minus_val = 1000;
        val_plus_data_t = class_plus_data(randperm(size(class_plus_data, 1), N_plus_val), :);
        val_minus_data_t = class_minus_data(randperm(size(class_minus_data, 1), N_minus_val), :);
        val_plus_data_ap = training_plus_data;
        val_minus_data_ap = training_minus_data;
        classf_plus = zeros(1, N_plus_val);
        classf_minus = zeros(1, N_minus_val);
        aux_error = zeros(1, n_exp);
        
        %true error
        for i = 1:N_plus_val
            aux_plus = norm(m_plus(j, :) - val_plus_data_t(i,:), 1);
            aux_minus = norm(m_minus(j, :) - val_plus_data_t(i,:), 1);
            if aux_plus < aux_minus
                classf_plus(i) = 1;
            else
                classf_plus(i) = 0;
            end
        end
        for i = 1:N_minus_val
            aux_plus = norm(m_plus(j, :) - val_minus_data_t(i,:), 1);
            aux_minus = norm(m_minus(j, :) - val_minus_data_t(i,:), 1);
            if aux_minus < aux_plus
                classf_minus(i) = 0;
            else
                classf_minus(i) = 1;
            end
        end
        TP = sum(classf_plus == 1);
        FN = sum(classf_plus == 0);
        TN = sum(classf_minus == 0);
        FP = sum(classf_minus == 1);
        aux_error_true(j) = (FP+FN)/(TP+FN+TN+FP);
        
        %aparent error
        for i = 1:N_plus_val
            aux_plus = norm(m_plus(j, :) - val_plus_data_ap(i,:), 1);
            aux_minus = norm(m_minus(j, :) - val_plus_data_ap(i,:), 1);
            if aux_plus < aux_minus
                classf_plus(i) = 1;
            else
                classf_plus(i) = 0;
            end
        end
        for i = 1:N_minus_val
            aux_plus = norm(m_plus(j, :) - val_minus_data_ap(i,:), 1);
            aux_minus = norm(m_minus(j, :) - val_minus_data_ap(i,:), 1);
            if aux_minus < aux_plus
                classf_minus(i) = 0;
            else
                classf_minus(i) = 1;
            end
        end
        TP = sum(classf_plus == 1);
        FN = sum(classf_plus == 0);
        TN = sum(classf_minus == 0);
        FP = sum(classf_minus == 1);
        aux_error_ap(j) = (FP+FN)/(TP+FN+TN+FP);
    end
    error_avg_true(k) = mean(aux_error_true);
    error_avg_ap(k) = mean(aux_error_ap);
    avg_m_plus(k, :) = mean(m_plus);
    avg_m_minus(k, :) = mean(m_minus);
    sd_m_plus(k, :) = std(m_plus);
    sd_m_minus(k, :) = std(m_minus);
end

lambda_aux = [1, 10, 100, 1000, 10000, 100000];
% plot errors
figure
semilogx(lambda_aux, error_avg_ap, '-o', lambda_aux, error_avg_true, '-o')
xlabel('\lambda'), ylabel('Error')
xticklabels({'0','1','10','100','1000','10000'})
legend('Apparent error', 'Estimated true error'), hold off

% plot fval
fval_min = min(fval);
figure
semilogx(lambda_aux, fval_min, '-o')
xticklabels({'0','1','10','100','1000','10000'})
xlabel('\lambda'), ylabel('Function value')

%plot average medians and standard deviations
% lambda = 0
figure
subplot(2, 1, 1)
plot(avg_m_plus(1, :), '-o'), hold on
plot(avg_m_minus(1, :), '-o')
xlabel('Dimensions'), xlim([1 21])
ylabel('Average medians')
legend('m_+', 'm_-')
subplot(2, 1, 2)
plot(sd_m_plus(1, :), '-o'), hold on
plot(sd_m_minus(1, :), '-o')
xlabel('Dimensions'), xlim([1 21])
ylabel('Standard deviation')
legend('m_+', 'm_-')
% lambda = 10000
figure
subplot(2, 1, 1)
plot(avg_m_plus(6, :), '-o'), hold on
plot(avg_m_minus(6, :), '-o')
xlabel('Dimensions'), xlim([1 21])
ylabel('Average medians')
legend('m_+', 'm_-')
subplot(2, 1, 2)
plot(sd_m_plus(6, :), '-o'), hold on
plot(sd_m_minus(6, :), '-o')
xlabel('Dimensions'), xlim([1 21])
ylabel('Standard deviation')
legend('m_+', 'm_-')