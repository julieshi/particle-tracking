function msd = mean_squared_displacement(t,X,Y)

% Inputs:
%   t = time (s)
%   X = x-positions (pixel)
%   Y = y-positions (pixel)

data = [t; X; Y];
data = transpose(data);
nData = size(data,1); %# number of data points
numberOfdeltaT = floor(nData/4); %# for MSD, dt should be up to 1/4 of number of data points

msd = zeros(numberOfdeltaT,3); %# We'll store [mean, std, n, tau]

%# calculate msd for all deltaT's

for dt = 1:numberOfdeltaT
   deltaCoords = data(1+dt:end,2:3) - data(1:end-dt,2:3);
   squaredDisplacement = sum(deltaCoords.^2,2); %# dx^2+dy^2

   msd(dt,1) = mean(squaredDisplacement); %# average
   msd(dt,2) = std(squaredDisplacement); %# std
   msd(dt,3) = length(squaredDisplacement); %# n
end

msd(:,4) = t(2:numberOfdeltaT+1); % tau
