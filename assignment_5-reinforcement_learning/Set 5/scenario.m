% STATE SPACE
n = 63; % number of states
nrows = 9; ncol = 7;
S = 13; % start state
G = 53; % goal state
grey_states = [1:7, 8, 14, 15, 17, 18, 20, 21, 22, 28, 29, 31:33, 35, 36, 42, 43, 45, 46, 48, 49, 50, 56, 57:63];
n_activestates = n-length(grey_states);

% TRANSITIONS - DETERMINISTIC
ssl_left = zeros(2,n); ssl_right = zeros(2,n); ssl_up = zeros(2,n); ssl_down = zeros(2,n);

P_left = zeros(63); P_right = zeros(63); P_up = zeros(63); P_down = zeros(63);

% action - left(1)
for i = 1:nrows %go over all rows
    for s = 1+(i-1)*ncol:7+(i-1)*ncol % s = current state
        if ismember(s, grey_states)
            next_s = s;
        else
            next_s = s-1;
            if ~ismember(s, grey_states) && ~ismember(next_s, grey_states)
                P_left(s, next_s) = 1;
            elseif ~ismember(s, grey_states) && ismember(next_s, grey_states)
                P_left(s, s) = 1;
                next_s = s;
            end
        end
        ssl_left(:,s) = [s; next_s];
    end
end
P_left(G,:) = zeros(1,size(P_left,2));

% action - right(2)
for i = 1:nrows %go over all rows
    for s = 1+(i-1)*ncol:7+(i-1)*ncol % s = current state
        if ismember(s, grey_states)
            next_s = s;
        else
            next_s = s+1;
            if ~ismember(s, grey_states) && ~ismember(next_s, grey_states)
                P_right(s, next_s) = 1;
            elseif ~ismember(s, grey_states) && ismember(next_s, grey_states)
                P_right(s, s) = 1;
                next_s = s;
            end
        end
        ssl_right(:,s) = [s; next_s];
    end
end
P_right(G,:) = zeros(1,size(P_right,2));

% action - up(3)
for i = 1:nrows %go over all rows
    for s = 1+(i-1)*ncol:7+(i-1)*ncol % s = current state
        if ismember(s, grey_states)
            next_s = s;
        else
            next_s = s+ncol;
            if ~ismember(s, grey_states) && ~ismember(next_s, grey_states)
                P_up(s, next_s) = 1;
            elseif ~ismember(s, grey_states) && ismember(next_s, grey_states)
                P_up(s, s) = 1;
                next_s = s;
            end
        end
        ssl_up(:,s) = [s; next_s];
    end
end
P_up(G,:) = zeros(1,size(P_up,2));

% action - down(4)
for i = 1:nrows %go over all rows
    for s = 1+(i-1)*ncol:7+(i-1)*ncol % s = current state
        if ismember(s, grey_states)
            next_s = s;
        else
            next_s = s-ncol;
            if ~ismember(s, grey_states) && ~ismember(next_s, grey_states)
                P_down(s, next_s) = 1;
            elseif ~ismember(s, grey_states) && ismember(next_s, grey_states)
                P_down(s, s) = 1;
                next_s = s;
            end
        end
        ssl_down(:,s) = [s; next_s];
    end
end
P_down(G,:) = zeros(1,size(P_down,2));

% REWARDS
R_left = zeros(63); R_right = zeros(63); R_up = zeros(63); R_down = zeros(63);
R_left(:,G) = ones(n,1); R_right(:,G) = ones(n,1); R_up(:,G) = ones(n,1); R_down(:,G) = ones(n,1);
R_left(G,G) = 0; R_right(G,G) = 0; R_up(G,G) = 0; R_down(G,G) = 0;