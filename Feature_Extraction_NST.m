function [ features,features_avg,features_fusion,features_acc,features_gyro] = Feature_Extraction_NST( data,fs,win, step,lab, id )
%UNTITLED17 Summary of this function goes here
%   Detailed explanation goes here


 Features_Gx = stFeatureExtraction(data.gyroX',fs , win, step );
  Features_Gy = stFeatureExtraction(data.gyroY',fs , win, step );
   Features_Gz = stFeatureExtraction(data.gyroZ',fs , win, step );
    Features_Ax = stFeatureExtraction(data.accX',fs , win, step );
     Features_Ay = stFeatureExtraction(data.accY',fs , win, step);
      Features_Az = stFeatureExtraction(data.accZ',fs , win, step );
 if lab
labels=ones(size(Features_Ax,2),1);
% labels_x=ones(6,1);
labels_x=ones(size(Features_Ax,2),1);
 else
   labels=zeros(size(Features_Ax,2),1);
   labels_x=zeros(size(Features_Ax,2),1);
 end
idx=zeros(size(labels));
idx(:,:)=id;

ID_X=zeros(size(labels_x));
ID_X(:,:)=id;
features=[Features_Gx',Features_Gy',Features_Gz',Features_Ax',Features_Ay',Features_Az',labels,idx];
% 
% F_ax=median(Features_Ax');
% F_ay=median(Features_Ay');
% F_az=median(Features_Az');
% F_gx=median(Features_Gx');
% F_gy=median(Features_Gy');
% F_gz=median(Features_Gz');
Features_3D(1,1:size(Features_Gx,1),1:size(Features_Gx,2))=Features_Gx;
Features_3D(2,1:size(Features_Gx,1),1:size(Features_Gx,2))=Features_Gy;
Features_3D(3,1:size(Features_Gx,1),1:size(Features_Gx,2))=Features_Gz;
Features_3D(4,1:size(Features_Gx,1),1:size(Features_Gx,2))=Features_Ax;
Features_3D(5,1:size(Features_Gx,1),1:size(Features_Gx,2))=Features_Ay;
Features_3D(6,1:size(Features_Gx,1),1:size(Features_Gx,2))=Features_Az;
features_avg=median(Features_3D,1);
% features_avg=[F_gx,F_gy,F_gz,F_ax,F_ay,F_az,labels_x,ID_X];
feat_temp = reshape(features_avg,size(features_avg,1)*size(features_avg,2),size(features_avg,3));
features_avg=[feat_temp',labels_x,ID_X];

features_fusion=[Features_Gy',Features_Az',labels,idx];

features_acc=[Features_Ax',Features_Ay',Features_Az',labels,idx];
features_gyro=[Features_Gx',Features_Gy',Features_Gz',labels,idx ];
end

