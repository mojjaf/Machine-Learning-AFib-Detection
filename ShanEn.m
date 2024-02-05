function [ SE ] = ShanEn( vecin )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
vecin=zscore(vecin);
temp=vecin(vecin~=0);
SE=-sum((temp.^2).*log(temp.^2));

end

