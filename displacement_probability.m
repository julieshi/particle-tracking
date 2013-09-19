function R = displacement_probability(N)

% Input N number of random integers from -4 to 4 with associated
% probabilities

% Export vector R (2,0) of random displacements

% Choose a displacement with probability 
% experimentally determined using 40 nm nanospheres in glycerol @ 37C

a = [-4 -3 -2 -1 0 1 2 3 4]; % possible displacements
% w = [0.00204 0.0034 0.00815 .18478 .60326 .18478 .00815 .0034 .00204]; 
% probability of each displacement for 40 nm spheres

w = [0 0.00989 0.07033 0.24121 0.35714 0.24121 0.07033 0.00989 0]; 
% probability of each displacement for 100 nm spheres

X = a( sum( bsxfun(@ge, rand(N,1), cumsum(w./sum(w))), 2) + 1 );
Y = a( sum( bsxfun(@ge, rand(N,1), cumsum(w./sum(w))), 2) + 1 );

R = [X; Y];

