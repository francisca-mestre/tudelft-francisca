run scenario
run Qiteration
close

% Q-learning

gamma = 0.9;
% alpha = 0.5; epsilons = [0.1 0.3 0.5 0.7 0.9];
epsilon = 0.5; alphas = [0.1 0.4 0.9];
X = 100;
maxSteps = 100; %maxInteractions_vector = [1000 10000 100000 200000 300000 400000];
maxIt = 300000;
iterations = 100:maxIt;
normval_fixede = zeros(length(alphas),maxIt);
for eps = 1:length(alphas)
    normval2 = zeros(X, maxIt);
    alpha = alphas(eps);
    for x = 1:X
        Q = zeros(n,4);
        for in = 1:maxIt
            i = 0;
            episode = true;
            s = S;
            while episode
                i = i+1;
                if i <= maxSteps && s~=G
                    [~,a] = max(Q(s,:));
                    prob = rand;
                    if prob < epsilon
                        a = randperm(4,1);
                    end
                    if a == 1
                        next_s = ssl_left(2,s);
                        if next_s == G
                            r = R_left(s,next_s);
                            Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
                            s = next_s;
                        elseif next_s == s
                            
                        else
                            r = R_left(s,next_s);
                            Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
                            s = next_s;
                        end
                    elseif a == 2
                        next_s = ssl_right(2,s);
                        if next_s == G
                            r = R_right(s,next_s);
                            Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
                            s = next_s;
                        elseif next_s == s
                            
                        else
                            r = R_right(s,next_s);
                            Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
                            s = next_s;
                        end
                    elseif a == 3
                        next_s = ssl_up(2,s);
                        if next_s == G
                            r = R_up(s,next_s);
                            Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
                            s = next_s;
                        elseif next_s == s
                            
                        else
                            r = R_up(s,next_s);
                            Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
                            s = next_s;
                        end
                    elseif a == 4
                        next_s = ssl_down(2,s);
                        if next_s == G
                            r = R_down(s,next_s);
                            Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
                            s = next_s;
                        elseif next_s == s
                            
                        else
                            r = R_down(s,next_s);
                            Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
                            s = next_s;
                        end
                    end
                else
                    episode = false;
                end
                %                 if in <= maxInteractions
                %
                %                 else
                %                     iterations = false;
                %                     episode = false;
                %                 end
            end
            [V3, ~] = max(Q,[],2);
            normval2(x,in) = norm(V3-V,2);
        end
    end
    normval_fixede(eps,:) = mean(normval2);
end
normval_fixede = normval_fixede(:,100:end);
save normval_fixede
figure
plot(iterations,normval_fixede)
xlabel('Number of interactions with the environment'), ylabel('2-norm')
legend('\alpha = 0.1','\alpha = 0.4','\alpha = 0.9')
hold off
%%
gamma = 0.9;
alpha = 0.5; epsilons = [0.1 0.4 0.9];
% epsilon = 0.5; alphas = [0.1 0.3 0.5 0.7 0.9];
normval_fixeda = zeros(length(epsilons),maxIt);
maxSteps = 100; %maxInteractions_vector = [1000 2000];%[1000 10000 100000 200000 300000 400000];
figure
for eps = 1:length(epsilons)
    epsilon = epsilons(eps);
    normval2 = zeros(X, maxIt);
    for x = 1:X
        Q = zeros(n,4);
        for in = 1:maxIt
            i = 0;
            episode = true;
            s = S;
            while episode
                i = i+1;
                if i <= maxSteps && s~=G
                    [~,a] = max(Q(s,:));
                    prob = rand;
                    if prob < epsilon
                        a = randperm(4,1);
                    end
                    if a == 1
                        next_s = ssl_left(2,s);
                        if next_s == G
                            r = R_left(s,next_s);
                            Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
                            s = next_s;
                        elseif next_s == s
                            
                        else
                            r = R_left(s,next_s);
                            Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
                            s = next_s;
                        end
                    elseif a == 2
                        next_s = ssl_right(2,s);
                        if next_s == G
                            r = R_right(s,next_s);
                            Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
                            s = next_s;
                        elseif next_s == s
                            
                        else
                            r = R_right(s,next_s);
                            Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
                            s = next_s;
                        end
                    elseif a == 3
                        next_s = ssl_up(2,s);
                        if next_s == G
                            r = R_up(s,next_s);
                            Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
                            s = next_s;
                        elseif next_s == s
                            
                        else
                            r = R_up(s,next_s);
                            Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
                            s = next_s;
                        end
                    elseif a == 4
                        next_s = ssl_down(2,s);
                        if next_s == G
                            r = R_down(s,next_s);
                            Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
                            s = next_s;
                        elseif next_s == s
                            
                        else
                            r = R_down(s,next_s);
                            Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
                            s = next_s;
                        end
                    end
                else
                    episode = false;
                end
                %                 if in <= maxInteractions
                %
                %                 else
                %                     iterations = false;
                %                     episode = false;
                %                 end
            end
            [V3, ~] = max(Q,[],2);
            normval2(x,in) = norm(V3-V,2);
        end
    end
    normval_fixeda(eps,:) = mean(normval2);
end
normval_fixeda = normval_fixeda(:,100:end);
save normval_fixeda
figure
plot(iterations,normval_fixeda), hold on
xlabel('Number of interactions with the environment'), ylabel('2-norm')
legend('\epsilon = 0.1','\epsilon = 0.4','\epsilon = 0.9')
hold off

% run scenario
% run Qiteration
%
% % Q-learning
%
% gamma = 0.9;
% % alpha = 0.5; epsilons = [0.1 0.3 0.5 0.7 0.9];
% epsilon = 0.5; alphas = [0.1 0.3 0.5 0.7 0.9];
%
% maxSteps = 100; maxInteractions_vector = [1000 10000 100000 200000 300000 400000];
% normval2 = zeros(100, length(maxInteractions_vector));
% figure
% for eps = 1:length(alphas)
%     alpha = alphas(eps);
%     for x = 1:100
%         Q = zeros(n,4);
%         in = 0;
%         for I = 1:length(maxInteractions_vector)
%             maxInteractions = maxInteractions_vector(I);
%             iterations = true;
%             while iterations
%                 i = 0;
%                 episode = true;
%                 s = S;
%                 while episode
%                     i = i+1; in = in+1;
%                     if i <= maxSteps && s~=G
%                         [vali,a] = max(Q(s,:));
%                         prob = rand;
%                         if prob < epsilon
%                             a = randperm(4,1);
%                         end
%                         if a == 1
%                             next_s = ssl_left(2,s);
%                             if next_s == G
%                                 r = R_left(s,next_s);
%                                 Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
%                                 s = next_s;
%                             elseif next_s == s
%
%                             else
%                                 r = R_left(s,next_s);
%                                 Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
%                                 s = next_s;
%                             end
%                         elseif a == 2
%                             next_s = ssl_right(2,s);
%                             if next_s == G
%                                 r = R_right(s,next_s);
%                                 Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
%                                 s = next_s;
%                             elseif next_s == s
%
%                             else
%                                 r = R_right(s,next_s);
%                                 Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
%                                 s = next_s;
%                             end
%                         elseif a == 3
%                             next_s = ssl_up(2,s);
%                             if next_s == G
%                                 r = R_up(s,next_s);
%                                 Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
%                                 s = next_s;
%                             elseif next_s == s
%
%                             else
%                                 r = R_up(s,next_s);
%                                 Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
%                                 s = next_s;
%                             end
%                         elseif a == 4
%                             next_s = ssl_down(2,s);
%                             if next_s == G
%                                 r = R_down(s,next_s);
%                                 Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
%                                 s = next_s;
%                             elseif next_s == s
%
%                             else
%                                 r = R_down(s,next_s);
%                                 Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
%                                 s = next_s;
%                             end
%                         end
%                     else
%                         episode = false;
%                     end
%                     if in <= maxInteractions
%
%                     else
%                         iterations = false;
%                         episode = false;
%                     end
%                 end
%
%             end
%             [V3, pi] = max(Q,[],2);
%             normval2(x,I) = norm(V3-V,2);
%
%         end
%     end
%     normval2 = mean(normval2);
%     % figure
%     plot(maxInteractions_vector,normval2,'-o'), hold on
% end
% xlabel('Number of interactions with the environment'), ylabel('2-norm')
% legend('\alpha = 0.1','\alpha = 0.3','\alpha = 0.5','\alpha = 0.7','\alpha = 0.9')
%
% %%
% gamma = 0.9;
% alpha = 0.5; epsilons = [0.1 0.3 0.5 0.7 0.9];
% % epsilon = 0.5; alphas = [0.1 0.3 0.5 0.7 0.9];
%
% maxSteps = 100; maxInteractions_vector = [1000 2000];%[1000 10000 100000 200000 300000 400000];
% normval2 = zeros(2, length(maxInteractions_vector));
% figure
% for eps = 1:length(alphas)
%     alpha = alphas(eps);
%     for x = 1:2
%         Q = zeros(n,4);
%         in = 0;
%         for I = 1:length(maxInteractions_vector)
%             maxInteractions = maxInteractions_vector(I);
%             iterations = true;
%             while iterations
%                 i = 0;
%                 episode = true;
%                 s = S;
%                 while episode
%                     i = i+1; in = in+1;
%                     if i <= maxSteps && s~=G
%                         [vali,a] = max(Q(s,:));
%                         prob = rand;
%                         if prob < epsilon
%                             a = randperm(4,1);
%                         end
%                         if a == 1
%                             next_s = ssl_left(2,s);
%                             if next_s == G
%                                 r = R_left(s,next_s);
%                                 Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
%                                 s = next_s;
%                             elseif next_s == s
%
%                             else
%                                 r = R_left(s,next_s);
%                                 Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
%                                 s = next_s;
%                             end
%                         elseif a == 2
%                             next_s = ssl_right(2,s);
%                             if next_s == G
%                                 r = R_right(s,next_s);
%                                 Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
%                                 s = next_s;
%                             elseif next_s == s
%
%                             else
%                                 r = R_right(s,next_s);
%                                 Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
%                                 s = next_s;
%                             end
%                         elseif a == 3
%                             next_s = ssl_up(2,s);
%                             if next_s == G
%                                 r = R_up(s,next_s);
%                                 Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
%                                 s = next_s;
%                             elseif next_s == s
%
%                             else
%                                 r = R_up(s,next_s);
%                                 Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
%                                 s = next_s;
%                             end
%                         elseif a == 4
%                             next_s = ssl_down(2,s);
%                             if next_s == G
%                                 r = R_down(s,next_s);
%                                 Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
%                                 s = next_s;
%                             elseif next_s == s
%
%                             else
%                                 r = R_down(s,next_s);
%                                 Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
%                                 s = next_s;
%                             end
%                         end
%                     else
%                         episode = false;
%                     end
%                     if in <= maxInteractions
%
%                     else
%                         iterations = false;
%                         episode = false;
%                     end
%                 end
%
%             end
%             [V3, pi] = max(Q,[],2);
%             normval2(x,I) = norm(V3-V,2);
%
%         end
%     end
%     normval2 = mean(normval2);
%     % figure
%     plot(maxInteractions_vector,normval2,'-o'), hold on
% end
% xlabel('Number of interactions with the environment'), ylabel('2-norm')
% legend('\epsilon = 0.1','\epsilon = 0.3','\epsilon = 0.5','\epsilon = 0.7','\epsilon = 0.9')