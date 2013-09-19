% OBJECTIVES
% Obtain:
% 1. MSD vs tau plots for polyplex trafficking
% 2. Histogram of RC values
% 3. Percentage of hindered, diffusive, actively transported particles
% 4. Average Deff and velocity

% Input filename (xlsx format) and sheet names/particle ID
clear
filename = 'pHK10 30 min cell 1 data.xlsx'; % input as string
particle_ID = [3471 3569 3667 3765 3863 3961 4059 4157 4255 4353 4451 4549 4647 4745 4843 4941 5039 5137 5235 5333 5965 6047 6186 5469 6257 5784]; % input as string
filename2 = 'pHK10 30 min cell 4 data.xlsx';
particle_ID2 = [5134 5232 5330 5428 5526 5624 5722 5918 6016 6114 6212 6310 6408 6506 6604 6702 6800 6898 6996 7094 7192 7290 7388 7486 7682 7780 7878 7976 8074 8172 8270 8368 8796 8458 8545 8618 9186];
filename3 = 'pHK10 30 min cell 9 data.xlsx';
particle_ID3 = [7835 7933 8031 8129 8227 8325 8423 8521 8619 8717 8815 8913 9011 9109 9207 9305 9403 9501 9599 9697 9795 9893 9991 10089 10187 10285 10383 10481 10579 10677 10775 10873 10971 11069 11167 11265 11363 11461 11559 11657 11755 11853 11951 12049 12147 12245 12343 12441 12539 12633 13345 12720 13546 13631 13793 13997 12795 13920 12869 12943];
filename4 = 'pHK10 30 min cell 7.xlsx';
particle_ID4 = [4589 4687 4785 4883 4981 5079 5177 5275 5373 5471 5569 5667 5765 5863 5961 6059 6157 6255 6353 6451 6549 6632];
filename5 = 'pHK10 30 min cell 3.xlsx';
particle_ID5 = [4140 4238 4336 4434 4532 4630 4728 4826 4924 5022 5120 5218 5316 5414 5512 5610 5708 5806 5904 6002 6100 6198 6296 6394 6492 6590 6688 6773];

data3 = calculate_MSD_RC(filename3, particle_ID3, 1);
data2 = calculate_MSD_RC(filename2, particle_ID2, 1);
data1 = calculate_MSD_RC(filename, particle_ID, 2);
data4 = calculate_MSD_RC(filename4, particle_ID4, 1);
data5 = calculate_MSD_RC(filename5, particle_ID5, 1);
data = [data1, data2, data3, data4, data5];

data_count = length(data);
bins = 0:0.2:4;

figure(1);
hist([data.shortRC],bins)
title('Histogram of RC values at short time scales')
xlabel('RC value')
ylabel('Frequency')

figure(2);
hist([data.longRC],bins)
title('Histogram of RC values at long time scales')
xlabel('RC value')
ylabel('Frequency')

figure(3);
for j = 1:data_count
    plot(log(data(j).tau), log(data(j).MSD))
    hold all
end

MSD = transpose([data.MSD]); % also add in geometric mean of MSD to plot
geomean_MSD = transpose(geomean(MSD));
plot(log(data(data_count).tau),log(geomean_MSD),'o','MarkerEdgeColor','b','MarkerFaceColor','b')
title('MSD vs. tau')
xlabel('Time lag (s)')
ylabel('MSD (µm^2/s)')

hold off

% Calculate percent particles undergoing hindered, diffusive, or active transport
counts_shortRC = histc([data.shortRC],[0 0.7516 1.2685 inf]); % 95% confidence interval bins
percent_counts_shortRC = counts_shortRC/sum(counts_shortRC);
hindered_shortRC = percent_counts_shortRC(1)
diffusive_shortRC = percent_counts_shortRC(2)
active_shortRC = percent_counts_shortRC(3)

% Calculate percent particles undergoing hindered, diffusive, or active transport
counts_longRC = histc([data.longRC],[0 0.4809 1.6565 inf]); % 95% confidence interval bins
percent_counts_longRC = counts_longRC/sum(counts_longRC);
hindered_longRC = percent_counts_longRC(1)
diffusive_longRC = percent_counts_longRC(2)
active_longRC = percent_counts_longRC(3)

% Calculate diffusivity and velocity
%p_mean = polyfit(tau,msd,1);
%D_mean = p_mean_um(1)/4
p_geomean = polyfit(data(1).tau,geomean_MSD,1);
D_geomean = p_geomean(1)/4









