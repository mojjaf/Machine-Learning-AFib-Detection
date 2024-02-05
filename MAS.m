function [ mean_AS ] = MAS( frame )
%Divides each frame into small bins and calculates median amplitude spectrum in each bin from fft

%   Detailed explanation goes here
[ out ] = bin_emg( frame );
[ answ ] = MFMD(out );

mean_AS=mean(answ);


end

