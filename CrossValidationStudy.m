
clear all ;close all
% load('D:\Seafile\Seafile\Atrial Fibrillation using Machine Learning\Final Simulations\TEST_NoStrokes_vs_TTY_TYKS_31012018\Train_Nostrokes_300_10sec_31012018.mat/')
% load('D:\Seafile\Seafile\Atrial Fibrillation using Machine Learning\Final Simulations\TEST_NoStrokes_vs_TTY_TYKS_31012018\Train_Nostrokes_300_20sec_31012018.mat')
% load('D:\Seafile\Seafile\Atrial Fibrillation using Machine Learning\Final Simulations\TEST_NoStrokes_vs_TTY_TYKS_31012018\Train_Nostrokes_300_30sec_31012018.mat')
% load('D:\Seafile\Seafile\Atrial Fibrillation using Machine Learning\Final Simulations\TEST_NoStrokes_vs_TTY_TYKS_31012018\Train_Nostrokes_300_40sec_05022018.mat')
% load('D:\Seafile\Seafile\Atrial Fibrillation using Machine Learning\Final Simulations\TEST_NoStrokes_vs_TTY_TYKS_31012018\Train_Nostrokes_300_50sec_05022018.mat')
load('D:\Seafile\Seafile\Atrial Fibrillation using Machine Learning\Final Simulations\TEST_NoStrokes_vs_TTY_TYKS_31012018\Train_Nostrokes_300_60sec_05022018.mat')

savdir1 ='D:\Seafile\Seafile\Atrial Fibrillation using Machine Learning\Manuscript\Publication results/' ;

data_6x_avg(~any(~isnan(data_6x_avg), 2),:)=[];
data_3x_acc_avg(~any(~isnan(data_3x_acc_avg), 2),:)=[];
data_3x_gyro_avg(~any(~isnan(data_3x_gyro_avg), 2),:)=[];
All_Axis=data_6x_avg(:,1:end-2);
ACC=data_3x_acc_avg(:,1:end-2);
GYRO=data_3x_gyro_avg(:,1:end-2);
pca_flag=0

for readloop=1:3
    
    if readloop==1
        
      [results_6axis_SSAWL,missclassfied_6axis]= majorityVotingNew(All_Axis,data_6x_avg(:,end-1),data_6x_avg(:,end),pca_flag);

        writetable(results_6axis_SSAWL,fullfile(savdir1,'6Axis_MedianFeauresOvSegments_30s.txt'),'WriteRowNames',true)
        
    elseif readloop==2
        
       [results_3axis_ACC,missclassfied_acc]= majorityVotingNew(ACC,data_3x_acc_avg(:,end-1),data_3x_acc_avg(:,end),pca_flag);

       writetable(results_3axis_ACC,fullfile(savdir1,'3AxisACC_MedianFeauresOvSegments_30s.txt'),'WriteRowNames',true)
        
    else
        
       [results_3axis_Gyro,missclassfied_gyr]= majorityVotingNew(GYRO,data_3x_gyro_avg(:,end-1),data_3x_gyro_avg(:,end),pca_flag);

        writetable(results_3axis_Gyro,fullfile(savdir1,'3AxisGyro_MedianFeauresOvSegments_30s.txt'),'WriteRowNames',true)
    end
end