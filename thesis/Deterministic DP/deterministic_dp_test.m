% load('demand_per_day.mat');
% load('RESULTS_deterministic_2018.mat')
n = size(demand_per_day,1);
delta = 16;
n_close = n-1;
epsilon = 1e-1;
database_og = reshape(demand_per_day(:, 1:end-1)',[],1);

peak_shaving = zeros(n, 1);
peak_shaving_eps = zeros(n, 1);
peak_shaving_zhat = zeros(n, 1);
peak_shaving_zmax = zeros(n, 1);
peaks = zeros(n, 1);
for d = 208:208
    tic
    day = demand_per_day(d, :);
    z_db = zeros(n-1, 1);
    Z = zeros(T,1);
    for t = 1:T
        Z(t) = day(t+1)-day(t);
    end
    
    if d == 1
        previous_day_idx = 365;
    else
        previous_day_idx = d-1;
    end
    previous_day = demand_per_day(previous_day_idx,:);
    if d == 365
        next_day_idx = 1;
    else
        next_day_idx = d+1;
    end
    
    optimalAction = zeros(1,T-1);
    l = zeros(1,T+1); l(1) = day(1);
    x0 = [0.3, l(1), l(1)];
    x = zeros(3,T+1); x(:,1) = x0(:);
    x_eps = zeros(3,T+1); x_eps(:,1) = x0(:);
    x_zhat = zeros(3,T+1); x_zhat(:,1) = x0(:);
    x_zmax = zeros(3,T+1); x_zmax(:,1) = x0(:);
    for t = 1 : T
        if t < delta
            window = [previous_day(end-(delta-t):end-1), day(1:t)];
        else
            window = day(t-delta+1:t);
        end
        dist = zeros(n_close, 1);
        dist_idx = zeros(n_close, 1);
        pieces = zeros(delta, n_close);
        peaks_db = zeros(delta, n_close);
        i = 1;
        for d2 = 1 : n
            day2 = demand_per_day(d2,:);
            if d2 ~= d  
                z_db(i) = day2(t+1)-day2(t);
                if d2 == 1
                    previous_day2_idx = 365;
                else
                    previous_day2_idx = d2-1;
                end
                previous_day2 = demand_per_day(previous_day2_idx,:);
                if t < delta
                    aux = delta-t;
                    piece = [previous_day2(end-aux:end-1), day2(1:t)];
                else
                    piece = day2(t-delta+1:t);
                end
                pieces(:, i) = piece;
                dist(i) = norm(window-piece, 1 );
                dist_idx(i) = d2;
                i = i + 1;
            end
        end
        % p_norm solution
                coeff = 1./dist;
                coeff = coeff./sum(coeff);
        % Least squares
%         Q = pieces;
%         y = window;
%         y = y(:);
%         H = Q'*Q;
%         f = -2*Q'*y;
%         A = -eye(n_close);
%         b = zeros(n_close, 1);
%         Aeq = ones(1, n_close);
%         beq = 1;
%         coeff = quadprog(H,f,A,b,Aeq,beq);
%         coeff = quadprog(H,f);
        u = 0;  
        z_estimate = 0;
        optimal_policy2 = zeros(N_SoC, N_peak, N_peak);
        x_aux = x(:,t)+[0; -epsilon; 0];
        for i = 1 : n_close
            j = dist_idx(i);
            cube1 = optimal_policies{j}{t};
            u = u + coeff(i)*getOptimalAction(x(:,t),cube1);
            optimal_policy2 = optimal_policy2 + coeff(i)*cube1;
            z_estimate = z_estimate + coeff(i)*z_db(i);
        end
        u = max((-x(1,t)/rateDischarge), min(u, ((1-x(1,t))/rateCharge)));
        u_eps = getOptimalAction(x_aux,optimal_policy2);
        u_zhat = u;
        if x_zhat(3,t) + z_estimate + u > x_zhat(2,t) && u > 0 && t ~= 1
            u_zhat = 0;
        end
        u_zmax = u;
        if x_zmax(3,t) + maxZ + u > x_zmax(2,t) && u > 0 && t ~= 1
            u_zmax = 0;
        end
        optimalAction(t) = u;
        
        z = Z(t);
        
        x(1,t+1) = systemDynamics{1}(x(1,t),x(2,t),x(3,t),u,z);
        x(2,t+1) = systemDynamics{2}(x(1,t),x(2,t),x(3,t),u,z);
        x(3,t+1) = systemDynamics{3}(x(1,t),x(2,t),x(3,t),u,z);
        
%         x_eps(1,t+1) = systemDynamics{1}(x_eps(1,t),x_eps(2,t),x_eps(3,t),u_eps,z);
%         x_eps(2,t+1) = systemDynamics{2}(x_eps(1,t),x_eps(2,t),x_eps(3,t),u_eps,z);
%         x_eps(3,t+1) = systemDynamics{3}(x_eps(1,t),x_eps(2,t),x_eps(3,t),u_eps,z);
%         
%         x_zhat(1,t+1) = systemDynamics{1}(x_zhat(1,t),x_zhat(2,t),x_zhat(3,t),u_zhat,z);
%         x_zhat(2,t+1) = systemDynamics{2}(x_zhat(1,t),x_zhat(2,t),x_zhat(3,t),u_zhat,z);
%         x_zhat(3,t+1) = systemDynamics{3}(x_zhat(1,t),x_zhat(2,t),x_zhat(3,t),u_zhat,z);
%         
%         x_zmax(1,t+1) = systemDynamics{1}(x_zmax(1,t),x_zmax(2,t),x_zmax(3,t),u_zmax,z);
%         x_zmax(2,t+1) = systemDynamics{2}(x_zmax(1,t),x_zmax(2,t),x_zmax(3,t),u_zmax,z);
%         x_zmax(3,t+1) = systemDynamics{3}(x_zmax(1,t),x_zmax(2,t),x_zmax(3,t),u_zmax,z);
        
        l(t+1) = x(3,t+1)+u;
        
    end
    peak_shaving(d) = (max(x(3,:))-max(x(2,:)))/max(x(3,:))*100;
    peak_shaving_eps(d) = (max(x_eps(3,:))-max(x_eps(2,:)))/max(x_eps(3,:))*100;
    peak_shaving_zhat(d) = (max(x_zhat(3,:))-max(x_zhat(2,:)))/max(x_zhat(3,:))*100;
    peak_shaving_zmax(d) = (max(x_zmax(3,:))-max(x_zmax(2,:)))/max(x_zmax(3,:))*100;
    toc
    %     figure, plot(time, x(3,:)), hold on, plot(time,l), hold on, plot(time, x(2,:))
    %     figure, plot(time, x(1,:))
    %     figure, bar(time(1:end-1), optimalAction)
end
