close all
clear all
cd

all_fmel_logs=[];all_fmel_mffc=[];All_entropy=[];All_Spentropy=[];All_features=[];
all_AF=[]; all_AF_av=[];all_AF_hf=[];all_AF_hf_av=[]; all_AF_fus=[]; all_AF_hffus=[];
all_AF_acc=[];all_AF_acc_hf=[];all_AF_gyro=[];all_AF_gyro_hf=[];

all_ctrl=[];all_ctrl_hf=[];all_ctrl_av=[];all_ctrl_hf_av=[];all_ctrl_fus=[];
all_ctrl_hffus=[];all_ctrl_acc=[];all_ctrl_acc_hf=[];all_ctrl_gyro=[];all_ctrl_gyro_hf=[];


for i=1:2
    switch i
        case 1
            
            %No Strokes AFib data only
            hfiles =findmeasfiles('D:\BIOSIGNAL_PROCESSING\Mobile Measurements\AF data analysis\Nostrokes study\Afib_positive');
            %Nostrokes Selfrecorded AF
            %           hfiles =findmeasfiles('D:\Seafile\Seafile\Saeed_And_Mojtaba_Underwork\AFIb_Dr_recorded\Self_recorded_data\AF_self_recorded');
            
            AFib_or_MI=1;
        case 2
            
            % SR Nostrokes only
            hfiles = findmeasfiles('D:\BIOSIGNAL_PROCESSING\Mobile Measurements\AF data analysis\Nostrokes study\SR');
            % SR Selfrecorded Nostrokes
            %         hfiles = findmeasfiles('D:\Seafile\Seafile\Saeed_And_Mojtaba_Underwork\AFIb_Dr_recorded\Self_recorded_data\SR_self_recorded');
            
            AFib_or_MI=0;
            
            
        case 3
            hfiles = findmeasfiles('D:\BIOSIGNAL_PROCESSING\Mobile Measurements\AF data analysis\Nostrokes study\SONY-Z5');
            AFib_or_MI=-1;
            
        otherwise
            disp('Unknown path.')
            
    end
    
    for k=1:length(hfiles)
        %     try
        %  for k=2:2
        fs=200; % sampling freqeuncy
        gr=0; %graphic
        filt=3;  % 1= normal BPF 2= Envelope 3= SSA
        data=import_smartphone_data(hfiles, k,filt,fs, gr );% load smartphone data
        
        %%%%%%%%%%%%%%%%%% without artifact removal method
        gyroX=data.gyroX;
        gyroY=data.gyroY;
        gyroZ=data.gyroZ;
        accX=data.accX;
        accY=data.accY;
        accZ=data.accZ;
        
        
        data_maf=struct('accX',accX,'accY',accY,'accZ',accZ,'gyroX',gyroX,'gyroY',gyroY,'gyroZ',gyroZ);
        data_maf2=struct('accX',accX','accY',accY','accZ',accZ','gyroX',gyroX','gyroY',gyroY','gyroZ',gyroZ');
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  SSA Algorithm
        [data_ssa,data_ssa_hf ]=ssa_Analysis( data_maf2,2,12 );
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Feature Extraction
        
        gr=0;
        win=10;
        step=7.5;
        [ features,features_avg,features_fusion, feat_acc, feat_gyro ] = Feature_Extraction_NST( data_maf2,fs,win, step,AFib_or_MI,k );
        
        [ features_hf,features_avg_hf,features_fusion_hf,feat_acc_hf, feat_gyro_hf ] = Feature_Extraction_NST( data_ssa_hf,fs,win, step,AFib_or_MI,k );
        
        
        
        if AFib_or_MI
            all_AF=[all_AF;features];
            all_AF_av=[all_AF_av;features_avg];
            all_AF_hf=[all_AF_hf;features_hf];
            all_AF_hf_av=[all_AF_hf_av;features_avg_hf];
            all_AF_fus=[all_AF_fus;features_fusion];
            all_AF_hffus=[all_AF_hffus;features_fusion_hf];
            all_AF_acc=[all_AF_acc;feat_acc];
            all_AF_acc_hf=[all_AF_acc_hf;feat_acc_hf];
            all_AF_gyro=[all_AF_gyro;feat_gyro];
            all_AF_gyro_hf=[all_AF_gyro_hf;feat_gyro_hf];
            
        else
            all_ctrl=[all_ctrl;features];
            all_ctrl_av=[all_ctrl_av;features_avg];
            all_ctrl_hf=[all_ctrl_hf;features_hf];
            all_ctrl_hf_av=[all_ctrl_hf_av;features_avg_hf];
            all_ctrl_fus=[all_ctrl_fus;features_fusion];
            all_ctrl_hffus=[all_ctrl_hffus;features_fusion_hf];
            
            all_ctrl_acc=[all_ctrl_acc;feat_acc];
            all_ctrl_acc_hf=[all_ctrl_acc_hf;feat_acc_hf];
            all_ctrl_gyro=[all_ctrl_gyro;feat_gyro];
            all_ctrl_gyro_hf=[all_ctrl_gyro_hf;feat_gyro_hf];
            
        end
        
        close all
        
        
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%% ID correction for disease group
all_AF(:,end)=all_AF(:,end)+max(all_ctrl(:,end));
all_AF_av(:,end)=all_AF_av(:,end)+max(all_ctrl(:,end));
all_AF_hf(:,end)=all_AF_hf(:,end)+max(all_ctrl(:,end));
all_AF_hf_av(:,end)=all_AF_hf_av(:,end)+max(all_ctrl(:,end));
all_AF_fus(:,end)=all_AF_fus(:,end)+max(all_ctrl(:,end));
all_AF_hffus(:,end)=all_AF_hffus(:,end)+max(all_ctrl(:,end));
all_AF_acc(:,end)=all_AF_acc(:,end)+max(all_ctrl(:,end));
all_AF_acc_hf(:,end)=all_AF_acc_hf(:,end)+max(all_ctrl(:,end));
all_AF_gyro(:,end)=all_AF_gyro(:,end)+max(all_ctrl(:,end));
all_AF_gyro_hf(:,end)=all_AF_gyro_hf(:,end)+max(all_ctrl(:,end));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Data Preparation
dataset_normsig=[all_ctrl;all_AF];
dataset_normsig_avg=[all_ctrl_av;all_AF_av];
dataset_hfsig=[all_ctrl_hf;all_AF_hf];
dataset_hfsig_avg=[all_ctrl_hf_av;all_AF_hf_av];
dataset_sigfus=[all_ctrl_fus;all_AF_fus];
dataset_sigfus_hf=[all_ctrl_hffus;all_AF_hffus];
dataset_sigacc=[all_ctrl_acc;all_AF_acc];
dataset_sigacc_hf=[all_ctrl_acc_hf;all_AF_acc_hf];
dataset_siggyro=[all_ctrl_gyro;all_AF_gyro];
dataset_siggyro_hf=[all_ctrl_gyro_hf;all_AF_gyro_hf];
%%
[x_train_norm]=zscore(dataset_normsig(:,1:end-2));
[x_train_normavg]=zscore(dataset_normsig_avg(:,1:end-2));
[x_train_hf]=zscore(dataset_hfsig(:,1:end-2));
[x_train_hfavg]=zscore(dataset_hfsig_avg(:,1:end-2));


[x_train_sigfus]=zscore(dataset_sigfus(:,1:end-2));
[x_train_sigfus_hf]=zscore(dataset_sigfus_hf(:,1:end-2));

[x_train_acc]=zscore(dataset_sigacc(:,1:end-2));
[x_train_acc_hf]=zscore(dataset_sigacc_hf(:,1:end-2));
[x_train_gyro]=zscore(dataset_siggyro(:,1:end-2));
[x_train_gyro_hf]=zscore(dataset_siggyro_hf(:,1:end-2));


%%%%%%%%%%%%%%%%%% Classification Experiments With KSVM, Random Forest,


%%%%%%%%%%%%%%% classification Without Normalization

% majorityVoting(dataset_normsig(:,1:end-2),dataset_normsig(:,end-1),dataset_normsig(:,end));
% majorityVoting(dataset_normsig_avg(:,1:end-2),dataset_normsig_avg(:,end-1),dataset_normsig_avg(:,end));
% majorityVoting(dataset_hfsig(:,1:end-2),dataset_hfsig(:,end-1),dataset_hfsig(:,end));
% majorityVoting(dataset_hfsig_avg(:,1:end-2),dataset_hfsig_avg(:,end-1),dataset_hfsig_avg(:,end));
% majorityVoting(dataset_sigfus(:,1:end-2),dataset_sigfus(:,end-1),dataset_sigfus(:,end));
% majorityVoting(dataset_sigfus_hf(:,1:end-2),dataset_sigfus_hf(:,end-1),dataset_sigfus_hf(:,end));

pca_flag=0;
%%%%%%%% classification with all Axis feature
%%
% majorityVoting(x_train_norm,dataset_normsig(:,end-1),dataset_normsig(:,end),pca_flag);
% majorityVoting(x_train_normavg,dataset_normsig_avg(:,end-1),dataset_normsig_avg(:,end),pca_flag);
% majorityVoting(x_train_hf,dataset_hfsig(:,end-1),dataset_hfsig(:,end),pca_flag);
% % majorityVoting(x_train_hfavg,dataset_hfsig_avg(:,end-1),dataset_hfsig_avg(:,end),pca_flag);
%%
%%%%%%%%%%%%%% classification with fusion of AccZ and GyroY Features
% pca_flag=0;
%
% majorityVoting(x_train_sigfus,dataset_sigfus(:,end-1),dataset_sigfus(:,end),pca_flag);
% majorityVoting(x_train_sigfus_hf,dataset_sigfus_hf(:,end-1),dataset_sigfus_hf(:,end),pca_flag);

%%
%%%%%%%%%%%%%%%%% Classification with only Acc featuer
%
% majorityVoting(x_train_acc,dataset_sigacc(:,end-1),dataset_sigacc(:,end));
% majorityVoting(x_train_acc_hf,dataset_sigacc_hf(:,end-1),dataset_sigacc_hf(:,end));
%
%
% %%%%%%%%%%%%%%%%%%% classification with only Gyro feature
%
% majorityVoting(x_train_gyro,dataset_siggyro(:,end-1),dataset_siggyro(:,end));
% majorityVoting(x_train_gyro_hf,dataset_siggyro_hf(:,end-1),dataset_siggyro_hf(:,end));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% LABELIT=dataset_hfsig(:,end)';
% Y_TULOS=dataset_hfsig(:,end-1)';
% X=x_train_hf;
% [ ConfMtx_MULTICLASS_svmk_hfsig, ConfMtx_MULTICLASS_svmk_entity_hfsig, accuracy, accuracyV, sensitivityV, specificityV] = classify_matrix_new2(LABELIT, Y_TULOS, X , 0, 0);

% LABELIT=dataset_normsig(:,end)';
% Y_TULOS=dataset_normsig(:,end-1)';
% X=x_train_norm;
% % X_comb=[x_train_norm,x_train_hf];
% [ ConfMtx_MULTICLASS_svmk_hfsig, ConfMtx_MULTICLASS_svmk_entity_hfsig, accuracy, accuracyV, sensitivityV, specificityV] = classify_matrix_new2(LABELIT, Y_TULOS, X , 0, 0);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SAVE SIMULATION RESULTS
%%
featureselection_AF;
read=0
if read
    pca_flag=0;
    savdir1 ='D:\Seafile\Seafile\Atrial Fibrillation using Machine Learning\results_12012018_Nostrokes_Only_298cases_20sec ovrlap segment_46features' ;
    results_6axis_allfeat=majorityVoting(x_train_norm,dataset_normsig(:,end-1),dataset_normsig(:,end),pca_flag);
    
    writetable(results_6axis_allfeat,fullfile(savdir1,'6AxisFeats_AFresults.txt'),'WriteRowNames',true)
    results_6axis_ssaWL=majorityVoting(x_train_hf,dataset_normsig(:,end-1),dataset_normsig(:,end),pca_flag);
    writetable(results_6axis_ssaWL,fullfile(savdir1,'6AxisFeats_SSAWL_AFresults.txt'),'WriteRowNames',true)
    
    results_2axis_SSA=majorityVoting(x_train_sigfus,dataset_sigfus(:,end-1),dataset_sigfus(:,end),pca_flag);
    writetable(results_2axis_SSA,fullfile(savdir1,'2AxisFeats_SSA_AFresults.txt'),'WriteRowNames',true)
    
    results_2axis_SSAWL= majorityVoting(x_train_sigfus_hf,dataset_sigfus_hf(:,end-1),dataset_sigfus_hf(:,end),pca_flag);
    writetable(results_2axis_SSAWL,fullfile(savdir1,'2AxisFeats_SSAWL_AFresults.txt'),'WriteRowNames',true)
    X_2axis_trainCombx= [x_train_sigfus,x_train_hf ];
    X_comb=[x_train_norm,x_train_hf];
    
    results_6axis_SSAWL= majorityVoting(X_comb,dataset_normsig(:,end-1),dataset_normsig(:,end),pca_flag);
    writetable(results_2axis_SSAWL,fullfile(savdir1,'6AxisFeats_SSAWL_ALLfeats_AFresults.txt'),'WriteRowNames',true)
    
    results_2axis_SSAWL= majorityVoting(X_2axis_trainCombx,dataset_sigfus(:,end-1),dataset_sigfus(:,end),pca_flag);
    writetable(results_2axis_SSAWL,fullfile(savdir1,'2AxisFeats_SSAWL_AFresults.txt'),'WriteRowNames',true)
    
end
%%
csvConvert=0;
if csvConvert
    csvwrite('dataset_hfsig.csv',dataset_hfsig);
    csvwrite('dataset_hfsig_avg.csv',dataset_hfsig_avg);
    csvwrite('dataset_normsig.csv',dataset_normsig);
    csvwrite('dataset_normsig_avg.csv',dataset_normsig_avg);
    csvwrite('dataset_sigacc.csv',dataset_sigacc);
    csvwrite('dataset_sigacc_hf.csv',dataset_sigacc_hf);
    csvwrite('dataset_sigfus.csv',dataset_sigfus);
    csvwrite('dataset_sigfus_hf.csv',dataset_sigfus_hf);
    csvwrite('dataset_siggyro.csv',dataset_siggyro);
    csvwrite('dataset_siggyro_hf.csv',dataset_siggyro_hf);
end
