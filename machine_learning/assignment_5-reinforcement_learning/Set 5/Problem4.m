iterations = 100:300000;
%P4
[normQlearning_mean, normQlearning_var] = Qlearning;

[normQlambda_mean, normQlambda_var] = Qlambda;

[normQdecay_mean, normQdecay_var] = decay_greedy;

save normQlearning_mean
save normQlearning_var
save normQlambda_mean
save normQlambda_var
save normQdecay_mean
save normQdecay_var

figure
errorbar(iterations, normQlearning_mean, normQlearning_var), hold on
errorbar(iterations, normQlambda_mean, normQlambda_var), hold on
errorbar(iterations, normQdecay_mean, normQdecay_var), hold off
legend('Q-learning', 'Q(\lambda)', 'Decaying \epsilon-greedy')
xlabel('Number of interactions with the environment'), ylabel('2-norm')

idx = 100:10000:300000;
varlearning = zeros(size(iterations)); varlearning(idx) = normQlearning_var(idx);
varlambda = zeros(size(iterations)); varlambda(idx) = normQlambda_var(idx);
vardecay= zeros(size(iterations)); vardecay(idx) = normQdecay_var(idx);

figure
errorbar(iterations, normQlearning_mean, varlearning), hold on
errorbar(iterations, normQlambda_mean, varlambda), hold on
errorbar(iterations, normQdecay_mean, vardecay), hold off
legend('Q-learning', 'Q(\lambda)', 'Decaying \epsilon-greedy')
xlabel('Number of interactions with the environment'), ylabel('2-norm')