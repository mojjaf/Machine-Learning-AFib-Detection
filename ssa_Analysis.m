function [data_ssa,data_hf_ssa]= ssa_Analysis( data,order,winlen,varargin )

%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%  plotsmartphonedata( data.accX,data.accY,data.accZ,data.gyroX,data.gyroY,data.gyroZ,200,1 )
% order=5
% winlen=10;
 narginchk(3,5)
if ( nargin ==4)
fig=cell2mat(varargin);% NO figure
else
fig=0;
end

if ( nargin <5 )
  ekg=(data.gyroX)*0;% NO ECG signal
else
    ekg=varargin;
end
  fs=200;

gr=fig;
[gyroX,kk,jj] = ssa(data.gyroX,winlen,order,gr);
 [gyroY,kk,jj]= ssa(data.gyroY,winlen,order,gr);
[gyroZ,kk,jj] = ssa(data.gyroZ,winlen,order,gr);
 [AccX,kk,jj]= ssa(data.accX,winlen,order,gr);
 [AccY,kk,jj]= ssa(data.accY,winlen,order,gr);
 [AccZ,kk,jj]= ssa(data.accZ,winlen,order,gr);
 
 [ accX_hf ] = HF_sphone(AccX,1 );
 [ accY_hf ] = HF_sphone(AccY,1 );
 [ accZ_hf ] = HF_sphone(AccZ,1 );
 [ gyroX_hf ] = HF_sphone(gyroX,2 );
 [ gyroY_hf ] = HF_sphone(gyroY,2 );
 [ gyroZ_hf ] = HF_sphone(gyroZ,2 );
  fig=0;
 if fig
 figure
            plotholterdata(ekg, AccX,AccY,AccZ,gyroX,gyroY,gyroZ,200,1 )
                        plotholterdata(ekg, accX_hf,accY_hf,accZ_hf,gyroX_hf,gyroY_hf,gyroZ_hf,200,1 )
                                                plotholterdata(ekg,diff( accX_hf),diff(accY_hf),diff(accZ_hf),diff(gyroX_hf),diff(gyroY_hf),diff(gyroZ_hf),200,1 )


          
      [pks,locs,widths,proms] = findpeaks(gyroX,'MinPeakDistance',100,'MinPeakHeight',0.5*(max(gyroX(1*fs:3*fs))),'Annotate','extents');
% figure
% plot(gyroX)
% hold on
% plot(locs,gyroX(locs),'r*')
% hold off
% 
% L = 256;
% noverlap = 100;
% [pxx,f,pxxc] = pwelch(AccZ,hamming(L),noverlap,200,fs,...
%     'ConfidenceLevel',0.95);
% 
% plot(f,(pxx))
% 
% xlabel('Frequency (Hz)')
% ylabel('Magnitude (dB)')
 end
% figs=1

% [heartRate, systolicTimeInterval] = getHeartRateSchmidt(gyroY, fs, fig)
% [heartRate, systolicTimeInterval] = getHeartRateSchmidt(gyroY_hf, fs, fig)


 data_ssa=struct('accX',AccX','accY',AccY','accZ',AccZ','gyroX',gyroX','gyroY',gyroY','gyroZ',gyroZ');
 data_hf_ssa=struct('accX',diff( accX_hf'),'accY',diff( accY_hf'),'accZ',diff( accZ_hf'),'gyroX',diff(gyroX_hf'),'gyroY',diff(gyroY_hf'),'gyroZ',diff(gyroZ_hf'));
% output=data_ssa;
end

