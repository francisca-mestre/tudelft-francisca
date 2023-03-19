% Forward step
day_demand = day_patterns(day, :);
optimal_action = zeros(1,T);
epsilon = 1e-1;
l = zeros(1,T+1); l(1) = day_demand(1);
x0 = [0.3, l(1), l(1)];
x = zeros(3,T+1); x(:,1) = x0(:);
x_eps = zeros(3,T+1); x_eps(:,1) = x0(:);
x_zhat = zeros(3,T+1); x_zhat(:,1) = x0(:);
x_zmax = zeros(3,T+1); x_zmax(:,1) = x0(:);
realtime_time = zeros(T,1);
for t = 1:T
    start = tic;
    z = day_demand(t+1)-day_demand(t);
    cube1 = uPolicy{t};
    u = getOptimalAction(x(:,t),cube1);
    optimal_action(t) = u;
    z_db = zeros(1,n-1); ix = 1;
    for i = 1:n
        if i ~= day
            z_db(ix) = day_patterns(i, t+1)-day_patterns(i, t);
            ix = ix+1;
        end
    end
    z_estimate = sum((1/(n-1))*z_db);

    % Compute state at t+1
    x(1,t+1) = systemDynamics{1}(x(1,t),x(2,t),x(3,t),u,z);
    x(2,t+1) = systemDynamics{2}(x(1,t),x(2,t),x(3,t),u,z);
    x(3,t+1) = systemDynamics{3}(x(1,t),x(2,t),x(3,t),u,z);
    l(t+1) = x(3,t+1)+u;
    
    x_aux = x(:,t)+[0, -epsilon, 0];
    u_eps = getOptimalAction(x_aux,cube1);
    u_zhat = u;
    if x_zhat(3,t) + z_estimate + u > x_zhat(2,t) && u > 0 && t ~= 1
        u_zhat = 0;
    end
    u_zmax = u;
    if x_zmax(3,t) + maxZ + u > x_zmax(2,t) && u > 0 && t ~= 1
        u_zmax = 0;
    end
    
    x(1,t+1) = systemDynamics{1}(x(1,t),x(2,t),x(3,t),u,z);
    x(2,t+1) = systemDynamics{2}(x(1,t),x(2,t),x(3,t),u,z);
    x(3,t+1) = systemDynamics{3}(x(1,t),x(2,t),x(3,t),u,z);
    
    x_eps(1,t+1) = systemDynamics{1}(x_eps(1,t),x_eps(2,t),x_eps(3,t),u_eps,z);
    x_eps(2,t+1) = systemDynamics{2}(x_eps(1,t),x_eps(2,t),x_eps(3,t),u_eps,z);
    x_eps(3,t+1) = systemDynamics{3}(x_eps(1,t),x_eps(2,t),x_eps(3,t),u_eps,z);
    
    x_zhat(1,t+1) = systemDynamics{1}(x_zhat(1,t),x_zhat(2,t),x_zhat(3,t),u_zhat,z);
    x_zhat(2,t+1) = systemDynamics{2}(x_zhat(1,t),x_zhat(2,t),x_zhat(3,t),u_zhat,z);
    x_zhat(3,t+1) = systemDynamics{3}(x_zhat(1,t),x_zhat(2,t),x_zhat(3,t),u_zhat,z);
    
    x_zmax(1,t+1) = systemDynamics{1}(x_zmax(1,t),x_zmax(2,t),x_zmax(3,t),u_zmax,z);
    x_zmax(2,t+1) = systemDynamics{2}(x_zmax(1,t),x_zmax(2,t),x_zmax(3,t),u_zmax,z);
    x_zmax(3,t+1) = systemDynamics{3}(x_zmax(1,t),x_zmax(2,t),x_zmax(3,t),u_zmax,z);
    
    l(t+1) = x(3,t+1)+u;
    realtime_time(t) = toc(start);
end
peak_shaving(day) = (max(x(3,:))-max(x(2,:)))/max(x(3,:))*100;
peak_shaving_eps(day) = (max(x_eps(3,:))-max(x_eps(2,:)))/max(x_eps(3,:))*100;
peak_shaving_zhat(day) = (max(x_zhat(3,:))-max(x_zhat(2,:)))/max(x_zhat(3,:))*100;
peak_shaving_zmax(day) = (max(x_zmax(3,:))-max(x_zmax(2,:)))/max(x_zmax(3,:))*100;

% figure, plot(time, x(3,:), 'LineWidth', 6), hold on, plot(time,l, 'LineWidth',6), hold on, plot(time, x(2,:),'LineWidth',6)
% set(gca,'FontSize',20)
% legend('Demand', 'Load', 'Peak')
% ylabel('Power')
% xlabel('Time')
% figure, plot(time, x(1,:),'LineWidth',6)
% set(gca,'FontSize',20)
% ylabel('SoC')
% xlabel('Time')
% figure, bar(time(1:end-1), optimal_action)
% set(gca,'FontSize',20)
% ylabel('Power')
% xlabel('Time')