function [ Sensitivity,Specificity,Accuracy,Precision, Kindex ] = classperf(predictval,truevals )
%UNTITLED15 Summary of this function goes here
%   Detailed explanation goes here
ConfMtx = confusionmat(truevals,predictval)
'TOT ZEROS (healthy):'
sum(predictval==0);

% 'TOT ONES (Ischemic):';
sum(predictval==1);

'Sensitivity (%) (healthy classified as healthy / total healthy) =' ;   
Sensitivity=100*ConfMtx(2,2)/(ConfMtx(2,2)+ConfMtx(2,1))    ;
'Specificity (%) (Disease classified as Disease / total Disease) =' ;   
Specificity=100*ConfMtx(1,1)/(ConfMtx(1,1)+ConfMtx(1,2)) ;
Precision= 100*ConfMtx(2,2)/(ConfMtx(2,2)+ConfMtx(1,2)) ;

'Accuracy (%) () ='    
Accuracy=100*(ConfMtx(1,1)+ConfMtx(2,2))/(ConfMtx(1,1)+ConfMtx(2,2)+ConfMtx(1,2)+ConfMtx(2,1))
Kindex=kappa(ConfMtx,0,0.05);
end

