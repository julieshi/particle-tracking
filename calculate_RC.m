function RC = calculate_RC(msd,t_ref,t_probe)

% Inputs:
% msd = matrix of [average, stdev, n, tau]
%       where average = mean-squared-displacement (MSD) at time lag tau
%             stdev   = standard deviation of MSD at time lag tau
%             n       = number of values used to calculate MSD  
%             tau     = time lag (usually in seconds)
% t_ref = integer value that corresponds to tau for reference point
% t_probe = integer value that corresponds to tau for probe point

% Output:
% RC = relative change of probed tau to reference tau (this value is used
% to determine whether a particle is hindered, diffusive, or active when
% compared to a population randomly diffusing particles)

% Calculate relative change (RC) for various time scales
tau = msd(:,4); % time lag (sec)

[row_ref,col_ref] = find(msd==t_ref); % Find the row, column where t_ref is
ref = msd(row_ref,:); % Get t_ref row information [average stdev n tau]
msd_ref = ref(1); % Get average MSD value at t_ref

% Similarly for t_probe...
[row_probe,col_probe] = find(msd==t_probe);
probe = msd(row_probe,:);
msd_probe = probe(1);

% Calulate diffusivity, D, at t_ref and t_probe
tau_ref = ref(4);
D_ref = msd_ref./(4*tau_ref);
tau_probe = probe(4);
D_probe = msd_probe./(4*tau_probe);
RC = D_probe./D_ref;

%histfit(RC_short);
%mean_shortRC = mean(RC_short)
%std_shortRC = std(RC_short)

%upper_RC_short = mean_shortRC + 2*std_shortRC
%lower_RC_short = mean_shortRC - 2*std_shortRC
