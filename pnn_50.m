function [ pNN50 ] = pnn_50( odstepRR )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

% NN50
o1=odstepRR(1:end-1);
o2=odstepRR(2:end);
roznica_odstepowRR=o2-o1;
ss=zeros(1,length(o2));
ss(abs(roznica_odstepowRR)>0.05)=1;
NN50=sum(ss);
%pNN50
pNN50=NN50/length(odstepRR);

end

