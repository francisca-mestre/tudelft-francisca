run scenario

I = 100; % nº of max iterations
Q_left = zeros(n,I+1); Q_right = zeros(n,I+1); Q_up = zeros(n,I+1); Q_down = zeros(n,I+1);
g = [0 0.1 0.5 1];

% s = S; % initial state
for k = 1:length(g)
    gamma = g(k);
    for i = 1:I
        % action - left(1)
        for s = 1:n
            next_s = ssl_left(2,s);
            [vali,a] = max([Q_left(next_s,i),Q_right(next_s,i),Q_up(next_s,i),Q_down(next_s,i)]);
            Q_left(s,i+1) =  P_left(s,next_s)*(R_left(s, next_s) + gamma*vali);
        end
        
        % action - right(2)
        for s = 1:n
            next_s = ssl_right(2,s);
            [vali,a] = max([Q_left(next_s,i),Q_right(next_s,i),Q_up(next_s,i),Q_down(next_s,i)]);
            Q_right(s,i+1) =  P_right(s,next_s)*(R_right(s, next_s) + gamma*vali);
        end
        
        % action - up(3)
        for s = 1:n
            next_s = ssl_up(2,s);
            [vali,a] = max([Q_left(next_s,i),Q_right(next_s,i),Q_up(next_s,i),Q_down(next_s,i)]);
            Q_up(s,i+1) =  P_up(s,next_s)*(R_up(s, next_s) + gamma*vali);
        end
        
        % action - down(4)
        for s = 1:n
            next_s = ssl_down(2,s);
            [vali,a] = max([Q_left(next_s,i),Q_right(next_s,i),Q_up(next_s,i),Q_down(next_s,i)]);
            Q_down(s,i+1) = P_down(s,next_s)*(R_down(s, next_s) + gamma*vali);
        end
    end
    
    V2 = zeros(n,1); pi = zeros(n,1);
    for s = 1:n
        [V2(s), pi(s)] = max([Q_left(s,end), Q_right(s,end), Q_up(s,end), Q_down(s,end)]);
    end
    maze_figure(V2)
end