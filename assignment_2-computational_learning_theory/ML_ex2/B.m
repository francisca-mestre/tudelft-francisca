% Find optimal feature and threshold theta

%generating dataset
examples_plus = [normrnd(0,1,4,1), normrnd(0,1,4,1)];
examples_minus = [normrnd(2,1,3,1), normrnd(0,1,3,1)];
dataset_t = [examples_plus; examples_minus];
N_features = size(dataset_t, 2);
N_examples = size(dataset_t, 1);
size_o_vector = size(examples_plus, 2) + size(examples_minus, 2) + 1;

figure %scatter dataset
plot(examples_plus(:, 1), examples_plus(:,2), 'bo')
hold on
plot(examples_minus(:, 1), examples_minus(:,2), 'ro')
gini0 = 1-((size(examples_plus, 1)/size(dataset_t, 1))^2+(size(examples_minus, 1)/size(dataset_t, 1))^2);

theta = zeros(N_examples, N_features);
info_gain = zeros(N_examples, N_features);
avg_impurity = zeros(N_examples, N_features);
for f = 1:N_features
    for ex = 1:N_examples
        if ex == 1
            theta(ex, f) = -10 + (dataset_t(ex, f)+10)*rand;
        elseif ex ~= 1
            theta(ex, f) = dataset_t(ex-1, f) + (dataset_t(ex, f)-dataset_t(ex-1, f))*rand;
        end
        
        R_plus = []; L_plus = []; R_minus = []; L_minus = [];
        rp = 0; rm = 0; lp = 0; lm = 0;
        for p = 1:size(examples_plus, 1)
            if examples_plus(p, f) >= theta(ex, f)
                rp = rp+1;
                R_plus(rp,:) = examples_plus(p,:);
            else
                lp = lp+1;
                L_plus(lp,:) = examples_plus(p,:);
            end
        end
        for m = 1:size(examples_minus, 1)
            if examples_minus(m, f) >= theta(ex, f)
                rm = rm+1;
                R_minus(rm,:) = examples_minus(m, :);
            else
                lm = lm+1;
                L_minus(lm,:) = examples_minus(m, :);
            end
        end
        
        giniR = 0; giniL = 0;
        r = rp + rm;
        l = lp + lm;
        if r ~= 0
            giniR = 1-((rp/r)^2+(rm/r)^2);
        end
        if l~= 0
            giniL = 1-((lp/l)^2+(lm/l)^2);
        end
        avg_impurity(ex, f) = (r/N_examples)*giniR + (l/N_examples)*giniL;
        info_gain(ex, f) = gini0 - avg_impurity(ex,f);
    end
end
max_ig = max(max(info_gain));
[example, f_optimal] = find(info_gain == max_ig);
f_optimal = f_optimal(1);
theta_optimal = theta(example(1), f_optimal);
