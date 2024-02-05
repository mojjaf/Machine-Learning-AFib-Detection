function [ RMSSDnrom ] = rmssd( odstepRR )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

RMSSDnrom=sqrt(sum(((mean(odstepRR)-odstepRR).^2))/length(odstepRR-1));
end

