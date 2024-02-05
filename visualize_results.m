clear all
% close all
SE_6x=[];SP_6x=[];PR_6x=[];ACC_6x=[];Kappa=[];
SE_ac3x=[];SP_ac3x=[];PR_ac3x=[];ACC_ac3x=[];Kappa_ac3x=[];
SE_gy3x=[];SP_gy3x=[];PR_gy3x=[];ACC_gy3x=[];Kappa_gy3x=[];
for i=1:6
    switch i
        case 1
%             load('D:\Seafile\Seafile\Atrial Fibrillation using Machine Learning\Final Simulations\10sec_7.5secOverlapping\result_table_300Nostrokes_LOOCV_10sec.mat')
load('D:\Seafile\Seafile\Atrial Fibrillation using Machine Learning\Manuscript\Publication results\Tables\result_table_300Nostrokes_LOOCV_10sec.mat')

            for sensor=1:3
                if sensor==1
                    SE_6x=[SE_6x results_6axis_SSAWL.Sensitivity];
                    SP_6x=[SP_6x results_6axis_SSAWL.Specificity];
                    PR_6x=[PR_6x results_6axis_SSAWL.Precision];
                    ACC_6x=[ACC_6x results_6axis_SSAWL.Accuracy];
                    Kappa=[Kappa results_6axis_SSAWL.Kappaindex];
                end
                if sensor==2
                    SE_ac3x=[SE_ac3x results_3axis_ACC.Sensitivity];
                    SP_ac3x=[SP_ac3x results_3axis_ACC.Specificity];
                    PR_ac3x=[PR_ac3x results_3axis_ACC.Precision];
                    ACC_ac3x=[ACC_ac3x results_3axis_ACC.Accuracy];
                    Kappa_ac3x=[Kappa_ac3x results_3axis_ACC.Kappaindex];
                end
                if sensor==3
                    SE_gy3x=[SE_gy3x results_3axis_Gyro.Sensitivity];
                    SP_gy3x=[SP_gy3x results_3axis_Gyro.Specificity];
                    PR_gy3x=[PR_gy3x results_3axis_Gyro.Precision];
                    ACC_gy3x=[ACC_gy3x results_3axis_Gyro.Accuracy];
                    Kappa_gy3x=[Kappa_gy3x results_3axis_Gyro.Kappaindex];
                end
                
            end
            
            
            
            
        case 2
%             load('D:\Seafile\Seafile\Atrial Fibrillation using Machine Learning\Final Simulations\20sec_15SecOverlapping\result_table_300Nostrokes_LOOCV_20sec.mat')
load('D:\Seafile\Seafile\Atrial Fibrillation using Machine Learning\Manuscript\Publication results\Tables\result_table_300Nostrokes_LOOCV_20sec.mat')
            
for sensor=1:3
                if sensor==1
                    SE_6x=[SE_6x results_6axis_SSAWL.Sensitivity];
                    SP_6x=[SP_6x results_6axis_SSAWL.Specificity];
                    PR_6x=[PR_6x results_6axis_SSAWL.Precision];
                    ACC_6x=[ACC_6x results_6axis_SSAWL.Accuracy];
                    Kappa=[Kappa results_6axis_SSAWL.Kappaindex];
                end
                if sensor==2
                    SE_ac3x=[SE_ac3x results_3axis_ACC.Sensitivity];
                    SP_ac3x=[SP_ac3x results_3axis_ACC.Specificity];
                    PR_ac3x=[PR_ac3x results_3axis_ACC.Precision];
                    ACC_ac3x=[ACC_ac3x results_3axis_ACC.Accuracy];
                    Kappa_ac3x=[Kappa_ac3x results_3axis_ACC.Kappaindex];
                end
                if sensor==3
                    SE_gy3x=[SE_gy3x results_3axis_Gyro.Sensitivity];
                    SP_gy3x=[SP_gy3x results_3axis_Gyro.Specificity];
                    PR_gy3x=[PR_gy3x results_3axis_Gyro.Precision];
                    ACC_gy3x=[ACC_gy3x results_3axis_Gyro.Accuracy];
                    Kappa_gy3x=[Kappa_gy3x results_3axis_Gyro.Kappaindex];
                end
                
            end
        case 3
%             load('D:\Seafile\Seafile\Atrial Fibrillation using Machine Learning\Final Simulations\30sec_22.5Overlapping\result_table_300Nostrokes_LOOCV_30sec.mat')
            load('D:\Seafile\Seafile\Atrial Fibrillation using Machine Learning\Manuscript\Publication results\Tables\result_table_300Nostrokes_LOOCV_30sec.mat')

            for sensor=1:3
                if sensor==1
                    SE_6x=[SE_6x results_6axis_SSAWL.Sensitivity];
                    SP_6x=[SP_6x results_6axis_SSAWL.Specificity];
                    PR_6x=[PR_6x results_6axis_SSAWL.Precision];
                    ACC_6x=[ACC_6x results_6axis_SSAWL.Accuracy];
                    Kappa=[Kappa results_6axis_SSAWL.Kappaindex];
                end
                if sensor==2
                    SE_ac3x=[SE_ac3x results_3axis_ACC.Sensitivity];
                    SP_ac3x=[SP_ac3x results_3axis_ACC.Specificity];
                    PR_ac3x=[PR_ac3x results_3axis_ACC.Precision];
                    ACC_ac3x=[ACC_ac3x results_3axis_ACC.Accuracy];
                    Kappa_ac3x=[Kappa_ac3x results_3axis_ACC.Kappaindex];
                end
                if sensor==3
                    SE_gy3x=[SE_gy3x results_3axis_Gyro.Sensitivity];
                    SP_gy3x=[SP_gy3x results_3axis_Gyro.Specificity];
                    PR_gy3x=[PR_gy3x results_3axis_Gyro.Precision];
                    ACC_gy3x=[ACC_gy3x results_3axis_Gyro.Accuracy];
                    Kappa_gy3x=[Kappa_gy3x results_3axis_Gyro.Kappaindex];
                end
                
            end
        case 4
%             load('D:\Seafile\Seafile\Atrial Fibrillation using Machine Learning\Final Simulations\40sec_30seOverlapping\result_table_300Nostrokes_LOOCV_40sec.mat')
            load('D:\Seafile\Seafile\Atrial Fibrillation using Machine Learning\Manuscript\Publication results\Tables\result_table_300Nostrokes_LOOCV_40sec.mat')

            for sensor=1:3
                if sensor==1
                    SE_6x=[SE_6x results_6axis_SSAWL.Sensitivity];
                    SP_6x=[SP_6x results_6axis_SSAWL.Specificity];
                    PR_6x=[PR_6x results_6axis_SSAWL.Precision];
                    ACC_6x=[ACC_6x results_6axis_SSAWL.Accuracy];
                    Kappa=[Kappa results_6axis_SSAWL.Kappaindex];
                end
                if sensor==2
                    SE_ac3x=[SE_ac3x results_3axis_ACC.Sensitivity];
                    SP_ac3x=[SP_ac3x results_3axis_ACC.Specificity];
                    PR_ac3x=[PR_ac3x results_3axis_ACC.Precision];
                    ACC_ac3x=[ACC_ac3x results_3axis_ACC.Accuracy];
                    Kappa_ac3x=[Kappa_ac3x results_3axis_ACC.Kappaindex];
                end
                if sensor==3
                    SE_gy3x=[SE_gy3x results_3axis_Gyro.Sensitivity];
                    SP_gy3x=[SP_gy3x results_3axis_Gyro.Specificity];
                    PR_gy3x=[PR_gy3x results_3axis_Gyro.Precision];
                    ACC_gy3x=[ACC_gy3x results_3axis_Gyro.Accuracy];
                    Kappa_gy3x=[Kappa_gy3x results_3axis_Gyro.Kappaindex];
                end
                
            end
        case 5
%             load('D:\Seafile\Seafile\Atrial Fibrillation using Machine Learning\Final Simulations\50sec_37secOverlapping\result_table_300Nostrokes_LOOCV_50sec.mat')
           load('D:\Seafile\Seafile\Atrial Fibrillation using Machine Learning\Manuscript\Publication results\Tables\result_table_300Nostrokes_LOOCV_50sec.mat')

            for sensor=1:3
                if sensor==1
                    SE_6x=[SE_6x results_6axis_SSAWL.Sensitivity];
                    SP_6x=[SP_6x results_6axis_SSAWL.Specificity];
                    PR_6x=[PR_6x results_6axis_SSAWL.Precision];
                    ACC_6x=[ACC_6x results_6axis_SSAWL.Accuracy];
                    Kappa=[Kappa results_6axis_SSAWL.Kappaindex];
                end
                if sensor==2
                    SE_ac3x=[SE_ac3x results_3axis_ACC.Sensitivity];
                    SP_ac3x=[SP_ac3x results_3axis_ACC.Specificity];
                    PR_ac3x=[PR_ac3x results_3axis_ACC.Precision];
                    ACC_ac3x=[ACC_ac3x results_3axis_ACC.Accuracy];
                    Kappa_ac3x=[Kappa_ac3x results_3axis_ACC.Kappaindex];
                end
                if sensor==3
                    SE_gy3x=[SE_gy3x results_3axis_Gyro.Sensitivity];
                    SP_gy3x=[SP_gy3x results_3axis_Gyro.Specificity];
                    PR_gy3x=[PR_gy3x results_3axis_Gyro.Precision];
                    ACC_gy3x=[ACC_gy3x results_3axis_Gyro.Accuracy];
                    Kappa_gy3x=[Kappa_gy3x results_3axis_Gyro.Kappaindex];
                end
                
            end
        case 6
%             load('D:\Seafile\Seafile\Atrial Fibrillation using Machine Learning\Final Simulations\60sec_45secOverlapping\result_table_300Nostrokes_LOOCV_60sec.mat')
            load('D:\Seafile\Seafile\Atrial Fibrillation using Machine Learning\Manuscript\Publication results\Tables\result_table_300Nostrokes_LOOCV_60sec.mat')

            for sensor=1:3
                if sensor==1
                    SE_6x=[SE_6x results_6axis_SSAWL.Sensitivity];
                    SP_6x=[SP_6x results_6axis_SSAWL.Specificity];
                    PR_6x=[PR_6x results_6axis_SSAWL.Precision];
                    ACC_6x=[ACC_6x results_6axis_SSAWL.Accuracy];
                    Kappa=[Kappa results_6axis_SSAWL.Kappaindex];
                end
                if sensor==2
                    SE_ac3x=[SE_ac3x results_3axis_ACC.Sensitivity];
                    SP_ac3x=[SP_ac3x results_3axis_ACC.Specificity];
                    PR_ac3x=[PR_ac3x results_3axis_ACC.Precision];
                    ACC_ac3x=[ACC_ac3x results_3axis_ACC.Accuracy];
                    Kappa_ac3x=[Kappa_ac3x results_3axis_ACC.Kappaindex];
                end
                if sensor==3
                    SE_gy3x=[SE_gy3x results_3axis_Gyro.Sensitivity];
                    SP_gy3x=[SP_gy3x results_3axis_Gyro.Specificity];
                    PR_gy3x=[PR_gy3x results_3axis_Gyro.Precision];
                    ACC_gy3x=[ACC_gy3x results_3axis_Gyro.Accuracy];
                    Kappa_gy3x=[Kappa_gy3x results_3axis_Gyro.Kappaindex];
                end
                
            end
    end
    
    
end

%%
% 
% boxplot(ACC_6x','PlotStyle','compact')
% h = gca;
% h.XTick = [1 2 3 4];
% h.XTickLabel = {'KSVM','RF','LDA','MV'};
% % % h.YLabel={'Sensitivity'};
figure
subplot(141);
b = barh(round(ACC_6x'),'BaseValue',80,'FaceColor','flat');
 for k = 1:size(ACC_6x',2)
     b(k).CData = k;
 end
ylabels = {'10sec','20sec','30sec','40sec','50sec','60sec'};
set(gca,'yticklabel',ylabels)
xlabel('Accuracy (%)')
ylabel('Windowing Length in Seconds')
legend('SVM', 'RF', 'Robust Boost', 'MV','location','northwest')

subplot(142);b = barh(round(SE_6x'),'BaseValue',70,'FaceColor','flat');
 for k = 1:size(SE_6x',2)
     b(k).CData = k;
 end
ylabels = {'10sec','20sec','30sec','40sec','50sec','60sec'};
set(gca,'yticklabel',ylabels)
xlabel('Sensitivity (%)')
ylabel('Windowing Length in Seconds')
legend('SVM', 'RF', 'Robust Boost', 'MV','location','northwest')
subplot(143);
b = barh(round(SP_6x'),'BaseValue',80,'FaceColor','flat');
 for k = 1:size(SP_6x',2)
     b(k).CData = k;
 end
ylabels = {'10sec','20sec','30sec','40sec','50sec','60sec'};
set(gca,'yticklabel',ylabels)
xlabel('Specificity (%)')
ylabel('Windowing Length in Seconds')
legend('SVM', 'RF', 'Robust Boost', 'MV','location','northwest')
subplot(144);
b = barh(round(PR_6x'),'BaseValue',88,'FaceColor','flat');
 for k = 1:size(PR_6x',2)
     b(k).CData = k;
 end
ylabels = {'10sec','20sec','30sec','40sec','50sec','60sec'};
set(gca,'yticklabel',ylabels)
xlabel('Precision (%)')
ylabel('Windowing Length in Seconds')
legend('SVM', 'RF', 'Robust Boost', 'MV','location','northwest')

% b = barh(round(Kappa'),'BaseValue',0.8,'FaceColor','flat');
%  for k = 1:size(Kappa',2)
%      b(k).CData = k;
%  end
% ylabels = {'10sec','20sec','30sec','40sec','50sec','60sec'};
% set(gca,'yticklabel',ylabels)
% xlabel('Kappa Coefficient')
% ylabel('Windowing Length in Seconds')
% legend('SVM', 'RF', 'Robust Boost', 'MV','location','northwest')

% figure;bar(Kappa(1:4,:)','DisplayName','Kappa')
% 
% figure;bar(SE_6x(1:4,:)','DisplayName','Sensitivity')
% 
% figure;bar(SP_6x(1:4,:)','DisplayName','Specificty')
% 
% figure;bar(ACC_6x(1:4,:)','DisplayName','Accuracy')

%%
% temp=ACC_6x';
% temp(:,5) = NaN;
% temp=[temp,ACC_ac3x'];
% temp(:,10) = NaN;
% temp=[temp,ACC_gy3x'];
% figure('Color', 'w');
% c = colormap(lines(4));
% C = [c; ones(1,4); c];  % this is the trick for coloring the boxes
% 
% 
% % regular plot
% boxplot(temp, 'colors', C, 'plotstyle', 'compact', ...
%     'labels', {'','6AXIS','','','','ACC','','','GYRO',''}); % label only two categories
% hold on;
% for ii = 1:4
%     plot(NaN,1,'color', c(ii,:), 'LineWidth', 4);
% end
% 
% title('BOXPLOT');
% ylabel('Accuracy');
% xlabel('SENSORS');
% legend({'KSVM', 'RF', 'LDA','MV'});