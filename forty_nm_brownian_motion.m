function msd = forty_nm_brownian_motion()

% Calculate msd for particle

% Random walk
N = 100; % N number of steps, depends on length of video
position = zeros(2,N); % particle starts at origin(0,0)
R = displacement_probability(N); % generate random displacement values

for j = 2:N
    position(:,j) = position(:,j-1) + R(:,j);    
end

X = position(1,:);
Y = position(2,:);
%plot(X,Y)

% Create time vector component
tau = 0.2; % time step (s)
t = zeros(1,N);

for i = 2:N
    t(:,i) = t(:,i-1) + tau;
end

% Calculate and plot MSD
msd = mean_squared_displacement(t,X,Y);
msd_average = msd(:,1);
tau = msd(:,4);
%plot(tau,msd_average,'o')
