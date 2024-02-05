function[results,missclassfied] = majorityVoting(xTrain,yTrain,ids,pca_flag)
% 'xTrain' and 'yTrain' are the inputs to the function
% 'xTrain' is an MxN matrix with M observations in rows and N features in columns
% 'yTrain' is an Mx1 vector containing the ground truth (say 0 or 1) for the M observations
rng(15825); % Controlled random number generation
k = max(ids); % Denotes 5-fold cross validation; Change this number if you want to play with the 'fold' of the cross validation.
% cvFolds = crossval('Kfold',k);
% [ ranking ] = featselect( xTrain, yTrain)
if pca_flag
[~,scores,pcvars]=princomp(xTrain);
x=scores(:,1);
y=scores(:,2);
z=scores(:,3);
figure
gscatter3(x,y,z,yTrain');
xlabel('Principal Component 1','FontSize',10,'FontWeight','bold'); 
ylabel('Principal Component 2','FontSize',10,'FontWeight','bold'); 
zlabel('Principal Component 3','FontSize',10,'FontWeight','bold'); 
figure
gscatter(x,z,yTrain')
xlabel('Principal Component 1','FontSize',10,'FontWeight','bold'); 
ylabel('Principal Component 3','FontSize',10,'FontWeight','bold'); 
figure
gscatter(x,y,yTrain')
xlabel('Principal Component 1','FontSize',10,'FontWeight','bold'); 
ylabel('Principal Component 2','FontSize',10,'FontWeight','bold'); 
pca_train=[x,y,z];
% 
  xTrain=pca_train;
end
 cvFolds = cvpartition(yTrain,'LeaveOut')
yTrain_log=yTrain>0;
%  Initializing arrays 
finalPreds1 = []; 
finalPreds2 = []; 
finalPreds3 = []; 
finalPreds4 = []; 

finalScores1 = [];
finalScores2 = [];
finalScores3 = [];
finalScores4 = [];
MissCL_SVM=[];
MissCL_RF=[];
MissCL_LDA=[];
yT = []; 
% ids=1:size(yTrain,1);
% cp = classperf(yTrain); 
%% Cross validation loop begins here
for i=1:k
    testIdx = find(ids==i);
%         testIdx = i;
% x=3;
%     trainIdx =~testIdx;
    trainIdx =find(ids~=i);

    
    % Support vector machine 
    svmModel = fitcsvm(xTrain(trainIdx,:), ...
yTrain_log(trainIdx), 'Standardize', true, ...
'KernelFunction', 'gaussian', 'KernelScale', 'auto');
    scoreSVMModel = fitPosterior(svmModel); % This function allows for generating posterior probabilities
    [svmPreds, svmScores] = predict(scoreSVMModel, ...
xTrain(testIdx,:));
    finalPreds1 = [finalPreds1; svmPreds];
    finalScores1 = [finalScores1; svmScores];
    
    % Bootstrap aggregation
    bagModel = fitensemble(xTrain(trainIdx,:), ...
yTrain(trainIdx), 'Bag', 700, 'Tree', 'Type', 'Classification');
    % Posterior probabilities can be directly generated using 'predict' for Bagging
    [bagPreds, bagScores] = predict(bagModel, ...
xTrain(testIdx,:));
    finalPreds2 = [finalPreds2; bagPreds];
    finalScores2 = [finalScores2; bagScores];
       
    % Linear discriminant analysis
    ldaModel = fitcdiscr(xTrain(trainIdx,:), ...
yTrain(trainIdx), 'discrimType', 'pseudolinear');
  
    % Posterior probabilities can be directly generated using 'predict' for LDA
    [ldaPreds, ldaScores] = predict(ldaModel, ...
xTrain(testIdx,:));
    finalPreds3 = [finalPreds3; ldaPreds];
    finalScores3 = [finalScores3; ldaScores];
    
    yT = [yT; yTrain(testIdx)];
    
     %%%%%%%%%%% decision trees
%     treemodel = fitctree(xTrain(trainIdx,:), yTrain(trainIdx), 'ClassNames', [0 1], 'SplitCriterion', 'gdi', 'MaxNumSplits', 2000, 'Surrogate', 'off');
    
%     [treePreds, treeScores] = predict(treemodel, ...
% xTrain(testIdx,:));
%     finalPreds4 = [finalPreds4; treePreds];
%     finalScores4 = [finalScores4; treeScores];
    
end
%% 'Hard' majority voting
allPreds = [finalPreds1, finalPreds2, finalPreds3];
majorityVoteOutput = mode(allPreds');
[ SE_svm,SP_svm,Acc_svm,Prec_svm ] = classperf( finalPreds1,yTrain )
[ SE_bag,SP_bag,Acc_bag,Prec_bag ] = classperf( finalPreds2,yTrain )
[ SE_lda,SP_lda,Acc_lda,Prec_lda ]  = classperf( finalPreds3,yTrain )
% [ SE_tree,SP_tree,Acc_tree,Prec_tree ] = classperf( finalPreds4,yTrain)

 [ SE_mj,SP_mj,Acc_mj,Prec_mj ]  = classperf( majorityVoteOutput,yTrain )
 
 
 pred_svm=[finalPreds1,yTrain];
 pred_rf=[finalPreds2,yTrain];
 pred_lda=[finalPreds3,yTrain];
 MissCL_SVM=find((pred_svm(:,1)-pred_svm(:,2))~=0);
MissCL_RF=find((pred_rf(:,1)-pred_rf(:,2))~=0);
MissCL_LDA=find((pred_lda(:,1)-pred_lda(:,2))~=0);

 missclassfied=[MissCL_SVM;MissCL_RF;MissCL_LDA];
 
format compact

% 'Mode' perform the majority voting using predicted class labels
% Model performance of hard majority voting
% cp = classperf(cp, finalPreds1); 
% modelAccuracy = cp.CorrectRate; 
 fprintf('SVM model accuracy = %0.3f\n', Acc_svm); 
% cp = classperf(cp, finalPreds2); 
% modelAccuracy = cp.CorrectRate; 
 fprintf('Random Forests accuracy = %0.3f\n', Acc_bag); 
% cp = classperf(cp, finalPreds3); 
% modelAccuracy = cp.CorrectRate; 
 fprintf('LDA model accuracy = %0.3f\n', Acc_lda); 
% cp = classperf(cp, majorityVoteOutput); 
%  fprintf('Decision tree model accuracy = %0.3f\n', Acc_tree); 

% modelAccuracy = cp.CorrectRate;
 fprintf('Model accuracy based on hard majority voting ...= %0.3f\n', Acc_mj); 
%% 'Soft' majority voting 
majorityVoteArgmax = zeros(length(yTrain),1);
for ii=1:length(allPreds)
    p0 = (finalScores1(ii,1) + finalScores2(ii,1) + ...
finalScores3(ii,1)) / 3;
    p1 = (finalScores1(ii,2) + finalScores2(ii,2) + ...
finalScores3(ii,2)) / 3;
    if(p1 > p0)
        majorityVoteArgmax(ii) = 1;
    end
end
[ SE_mjs,SP_mjs,Acc_mjs,Prec_mjs ]  = classperf( majorityVoteArgmax,yTrain )

 fprintf('Model accuracy based on soft majority voting ...= %0.3f\n', Acc_mj); 
% Model performance of soft majority voting
[Xsvm, Ysvm, ~, AUCsvm] = perfcurve(yT, finalScores1(:,2), 1); 
 figure; plot(Xsvm,Ysvm); legend(['ROC support vector machine, AUC: ',num2str(AUCsvm)]);
% hold on
fprintf('SVM model AUC = %0.3f\n', AUCsvm); 
% plot(X, Y,'b-','LineWidth',2);
hold on;
[Xbag, Ybag, ~, AUCbag] = perfcurve(yT, finalScores2(:,2), 1);  
 plot(Xbag,Ybag); legend(['ROC Random Forests, AUC: ',num2str(AUCbag)]);

fprintf('Random Forests model AUC = %0.3f\n', AUCbag); 
% plot(X, Y,'r--','LineWidth',2); 
hold on;
[Xlda, Ylda, ~, AUClda] = perfcurve(yT, finalScores3(:,2), 1);  
 plot(Xlda,Ylda); legend(['ROC LDA, AUC: ',num2str(AUClda)]);
 
 fprintf('LDA model AUC = %0.3f\n', AUClda); 

% [Xtree, Ytree, ~, AUCtree] = perfcurve(yT, finalScores4(:,2), 1);  
%  plot(Xtree,Ytree); legend(['ROC decision tree, AUC: ',num2str(AUCtree)]);
 
% fprintf('Decision tree model AUC = %0.3f\n', AUCtree); 


% plot(X, Y,'k:','LineWidth',2); hold on;
[X, Y, ~, AUC] = perfcurve(yT, majorityVoteArgmax, 1);  
fprintf('Majority voting (argmax) model AUC = %0.3f\n', AUC); 
plot(X, Y); hold on;
xlabel('False positive rate','FontSize',12,'FontWeight','bold'); 
ylabel('True positive rate','FontSize',12,'FontWeight','bold'); 
set(gca,'FontWeight','bold','FontSize',10,'LineWidth',1);
 legend(['SVM:',num2str(AUCsvm)],['Random Forests:',num2str(AUCbag)],['LDA:',num2str(AUClda)],['Majority vote:',num2str(AUC)]);

%%

% T_svm = table(SE_svm,SP_svm,Acc_svm,AUCsvm,'VariableNames',{'Sensitivity','Specificity','Accuracy','AUC'})
% T_RF=table(SE_bag,SP_bag,Acc_bag,AUCbag,'VariableNames',{'Sensitivity','Specificity','Accuracy','AUC'})
% T_LDA=table(SE_lda,SP_lda,Acc_lda,AUClda,'VariableNames',{'Sensitivity','Specificity','Accuracy','AUC'})
% T_DT=table(SE_tree,SP_tree,Acc_tree,AUCtree,'VariableNames',{'Sensitivity','Specificity','Accuracy','AUC'})
% T_MV=table(SE_mj,SP_mj,Acc_mj,AUC,'VariableNames',{'Sensitivity','Specificity','Accuracy','AUC'})

% results = table([SE_svm;SE_bag;SE_lda;SE_tree;SE_mj],[SP_svm;SP_bag;SP_lda;SP_tree;SP_mj],[Acc_svm;Acc_bag;Acc_lda;Acc_tree;Acc_mj],[AUCsvm;AUCbag;AUClda;AUCtree;AUC],...
% 'VariableNames',{'Sensitivity' 'Specificity' 'Accuracy' 'AUC'},...
% 'RowNames',{'SVM' 'RF' 'LDA' 'DT' 'MV'})
results = table([SE_svm;SE_bag;SE_lda;SE_mj],[SP_svm;SP_bag;SP_lda;SP_mj],[Prec_svm;Prec_bag;Prec_lda;Prec_mj],[Acc_svm;Acc_bag;Acc_lda;Acc_mj],[AUCsvm;AUCbag;AUClda;AUC],...
'VariableNames',{'Sensitivity' 'Specificity' 'Precision' 'Accuracy' 'AUC'},...
'RowNames',{'SVM' 'RF' 'LDA' 'MV'})
% writetable(results,fullfile(savdir1,'table_results.txt'),'WriteRowNames',true)

end
