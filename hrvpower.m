function [ pwr ] = hrvpower( odstepRR )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
psdest = dspdata.psd(odstepRR);
pwr=psdest.avgpower;
end

