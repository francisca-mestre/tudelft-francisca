for I = 1:length(maxInteractions_vector)
    maxInteractions = maxInteractions_vector(I);
    in = 0;
    iterations = true;
    while iterations
        in = in+1;
        if in <= maxInteractions
            i = 0;
            episode = true;
            s = S;
            %             s = 52;
            while episode
                i = i+1;
                if i <= maxSteps && s~=G
                    Q = [Q_left(s),Q_right(s),Q_up(s),Q_down(s)];
                    [vali,a] = max(Q);
                    prob = rand;
                    if prob < epsilon
                        a = randperm(4,1);
                    end
                    if a == 1
                        next_s = ssl_left(2,s);
                        if next_s == G
                            r = R_left(s,next_s);
                            Q_left(s) = Q_left(s) + alpha*(r+gamma*(max([Q_left(next_s), Q_right(next_s), Q_up(next_s), Q_down(next_s)]))-Q_left(s));
                            %                             episode = false;
                            s = next_s;
                        elseif next_s == s
                            
                        else
                            r = R_left(s,next_s);
                            Q_left(s) = Q_left(s) + alpha*(r+gamma*(max([Q_left(next_s), Q_right(next_s), Q_up(next_s), Q_down(next_s)]))-Q_left(s));
                            s = next_s;
                        end
                    elseif a == 2
                        next_s = ssl_right(2,s);
                        if next_s == G
                            r = R_right(s,next_s);
                            Q_right(s) = Q_right(s) + alpha*(r+gamma*(max([Q_left(next_s), Q_right(next_s), Q_up(next_s), Q_down(next_s)]))-Q_right(s));
                            %                             episode = false;
                            s = next_s;
                        elseif next_s == s
                            
                        else
                            r = R_right(s,next_s);
                            Q_right(s) = Q_right(s) + alpha*(r+gamma*(max([Q_left(next_s), Q_right(next_s), Q_up(next_s), Q_down(next_s)]))-Q_right(s));
                            s = next_s;
                        end
                    elseif a == 3
                        next_s = ssl_up(2,s);
                        if next_s == G
                            r = R_up(s,next_s);
                            Q_up(s) = Q_up(s) + alpha*(r+gamma*(max([Q_left(next_s), Q_right(next_s), Q_up(next_s), Q_down(next_s)]))-Q_up(s));
                            %                             episode = false;
                            s = next_s;
                        elseif next_s == s
                            
                        else
                            r = R_up(s,next_s);
                            Q_up(s) = Q_up(s) + alpha*(r+gamma*(max([Q_left(next_s), Q_right(next_s), Q_up(next_s), Q_down(next_s)]))-Q_up(s));
                            s = next_s;
                        end
                    elseif a == 4
                        next_s = ssl_down(2,s);
                        if next_s == G
                            r = R_down(s,next_s);
                            Q_down(s) = Q_down(s) + alpha*(r+gamma*(max([Q_left(next_s), Q_right(next_s), Q_up(next_s), Q_down(next_s)]))-Q_down(s));
                            %                             episode = false;
                            s = next_s;
                        elseif next_s == s
                            
                        else
                            r = R_down(s,next_s);
                            Q_down(s) = Q_down(s) + alpha*(r+gamma*(max([Q_left(next_s), Q_right(next_s), Q_up(next_s), Q_down(next_s)]))-Q_down(s));
                            s = next_s;
                        end
                    end
                else
                    episode = false;
                end
            end
        else
            iterations = false;
        end
    end
    V3 = zeros(n,1); pi = zeros(n,1);
    for s = 1:n
        [V3(s), pi(s)] = max([Q_left(s), Q_right(s), Q_up(s), Q_down(s)]);
    end
    %     maze_figure(V3)
    normval2(x,I) = norm(V3-V,2);
    
end