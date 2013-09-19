function data = calculate_MSD_RC(filename,particle_ID, startIndex)

% Input the filename and particle_ID (in separate sheets)
% Output the MSD structured array, which includes RC_short and RC_long

data_count = 0;

for j = 1:length(particle_ID)
    particle_ID_str = int2str(particle_ID(j));
    time = xlsread(filename,particle_ID_str, ['G' int2str(startIndex) ':G' int2str(96 + startIndex)]); % parse out data from spreadsheet
    position = xlsread(filename,particle_ID_str,['K' int2str(startIndex) ':L' int2str(96 + startIndex)]);
    X = position(:,1); 
    Y = position(:,2);
    
    if length(X) < 97
        continue
    end
    
    data_count = data_count + 1;
    
    % Calculate MSD
    msd = mean_squared_displacement(transpose(time),transpose(X),transpose(Y)); % returns a matrix, msd = [MSD_avg, MSD_stdev, n, tau]
    
    % Store data in a structured array
    data(data_count).tau = msd(:,4);
    data(data_count).MSD = msd(:,1);
    
    % Calculate RC values
    data(data_count).shortRC = calculate_RC(msd,data(data_count).tau(1),data(data_count).tau(5));
    data(data_count).longRC = calculate_RC(msd,data(data_count).tau(5),data(data_count).tau(24));
end