function tprout = tpr(vecin)
% tprout = tpr(vecin)
% calculates turning point ratio

N = length(vecin);


tmp = abs(diff(sign(diff(vecin))));
tprout = sum(tmp)/2/(N-2);

end

