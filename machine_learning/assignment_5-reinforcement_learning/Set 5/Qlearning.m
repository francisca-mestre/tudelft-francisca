function [normQlearning_mean, normQlearning_var] = Qlearning
run scenario
run Qiteration
close

gamma = 0.9;
alpha = 0.7; epsilon = 0.4;
maxSteps = 100; %maxInteractions_vector = [1000 10000 100000 200000 300000 400000];
maxIt = 300000;
X = 70;
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
normQlearning_mean = mean(normval2); normQlearning_mean = normQlearning_mean(100:end);
normQlearning_var = var(normval2);normQlearning_var = normQlearning_var(100:end);
end

% maxSteps = 100; maxI= 100000;
% in = 0;
% iterations = true;
% while iterations
%     in = in+1;
%     i = 0;
%     episode = true;
%     s = S;
%     while episode
%         i = i+1;
%         if i <= maxSteps && s~=G
%             [vali,a] = max(Q(s,:));
%             prob = rand;
%             if prob < epsilon
%                 a = randperm(4,1);
%             end
%             if a == 1
%                 next_s = ssl_left(2,s);
%                 if next_s == G
%                     r = R_left(s,next_s);
%                     Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
%                     s = next_s;
%                 elseif next_s == s
%
%                 else
%                     r = R_left(s,next_s);
%                     Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
%                     s = next_s;
%                 end
%             elseif a == 2
%                 next_s = ssl_right(2,s);
%                 if next_s == G
%                     r = R_right(s,next_s);
%                     Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
%                     s = next_s;
%                 elseif next_s == s
%
%                 else
%                     r = R_right(s,next_s);
%                     Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
%                     s = next_s;
%                 end
%             elseif a == 3
%                 next_s = ssl_up(2,s);
%                 if next_s == G
%                     r = R_up(s,next_s);
%                     Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
%                     s = next_s;
%                 elseif next_s == s
%
%                 else
%                     r = R_up(s,next_s);
%                     Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
%                     s = next_s;
%                 end
%             elseif a == 4
%                 next_s = ssl_down(2,s);
%                 if next_s == G
%                     r = R_down(s,next_s);
%                     Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
%                     s = next_s;
%                 elseif next_s == s
%
%                 else
%                     r = R_down(s,next_s);
%                     Q(s,a) = Q(s,a) + alpha*(r+gamma*(max(Q(next_s,:)))-Q(s,a));
%                     s = next_s;
%                 end
%             end
%         else
%             episode = false;
%         end
%     end
%     Qstar = max(Q,[],2);
%     if ~isequal(Q,zeros(size(Q))) && norm(Qstar-V) < 0.001
%         iterations = false;
%     end
% end
