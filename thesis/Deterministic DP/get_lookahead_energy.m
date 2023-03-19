function Q = get_lookahead_energy (profile, peak)

% load_0 = profile(1);  % Starting point
% condition = true;
delta_t = 900;  % 15 minutes * 60
% i = 2;
Q = 0;

%% Energy = sum(load_i-peak_0)*delta_t
for t = 1 : length(profile)-1
   Q = Q + (profile(t) - peak)*delta_t; 
end

% if profile(2) >= load_0 && profile(2) > peak  % If profile rises
%     tf = find(profile(2, :) < peak);
%     if isempty(tf)
%         tf = length(profile)-1;
%     else
%         tf = tf(1)-1;
%     end
%     for t = 1 : tf
%         Q = Q + (profile(t)-peak)*delta_t;
%     end
% %     if load_0 > peak
% %         for t = 1 : tf
% %             Q = Q + (profile(t)-peak)*delta_t;
% %         end
% %     else
% %         for t = 2 : tf
% %             Q = Q + (profile(t)-peak)*delta_t;
% %         end
% %     end
%     
% elseif profile(2) > load_0 && profile(2) < peak  % If profile rises
%     tf = find(profile > peak);
%     if isempty(tf)
%         tf = length(profile)-1;
%     else
%         tf = tf(1)-1;
%     end
%     for t = 1 : tf
%         Q = Q + (profile(t)-peak)*delta_t;
%     end
% elseif profile(2) < load_0 && profile(2) < peak
%     tf = find(profile > peak);
%     if isempty(tf)
%         tf = length(profile)-1;
%     else
%         tf = tf(1)-1;
%     end
%     for t = 1 : tf
%         Q = Q + (profile(t)-peak)*delta_t;
%     end
% %     if load_0 >= peak
% %         for t = 2 : tf
% %             Q = Q + (profile(t)-peak)*delta_t;
% %         end
% %     else
% %         for t = 1 : tf
% %             Q = Q + (profile(t)-peak)*delta_t;
% %         end
% %     end
% elseif profile(2) < load_0 && profile(2) > peak
%     tf = find(profile < peak);
%     if isempty(tf)
%         tf = length(profile)-1;
%     else
%         tf = tf(1)-1;
%     end
%     for t = 1 : tf
%         Q = Q + (profile(t)-peak)*delta_t;
%     end
% end

%% Energy = sum(load_i-load_0)*delta_t
% if profile(2) <= load_0
%     tf = find(profile > load_0);
%     if isempty(tf)
%         tf = length(profile)-1;
%     else
%         tf = tf(1)-1;
%     end
%     for t = 1 : tf
%         Q = Q + (profile(t)-load_0)*delta_t;
%     end
% elseif profile(2) > load_0
%     tf = find(profile < load_0);
%     if isempty(tf)
%         tf = length(profile)-1;
%     else
%         tf = tf(1)-1;
%     end
%     for t = 1 : tf
%         Q = Q + (profile(t)-load_0)*delta_t;
%     end
% end
end