optimalAction = zeros(1,T);
l = zeros(1,T+1); l(1) = dayLoad(1);
x0 = [0.3, l(1), l(1)];
x = zeros(3,T+1); x(:,1) = x0(:);
for t = 1:T
    z = Z(t);
    cube1 = uPolicy{t};
    u = getOptimalAction(x(:,t),cube1);
    optimalAction(t) = u;
    
    % Compute state at t+1
    x(1,t+1) = systemDynamics{1}(x(1,t),x(2,t),x(3,t),u,z);
    x(2,t+1) = systemDynamics{2}(x(1,t),x(2,t),x(3,t),u,z);
    x(3,t+1) = systemDynamics{3}(x(1,t),x(2,t),x(3,t),u,z);
    l(t+1) = x(3,t+1)+u;
end
figure, plot(time, x(3,:), 'LineWidth', 6), hold on, plot(time,l, 'LineWidth',6), hold on, plot(time, x(2,:),'LineWidth',6)
set(gca,'FontSize',20)
legend('Demand', 'Load', 'Peak')
ylabel('Power')
xlabel('Time')
figure, plot(time, x(1,:),'LineWidth',6)
set(gca,'FontSize',20)
ylabel('SoC')
xlabel('Time')
figure, bar(time(1:end-1), optimalAction)
set(gca,'FontSize',20)
ylabel('Power')
xlabel('Time')
peakReduction = (max(x(3,:))-max(l))/max(x(3,:))*100;