function [ data ] = import_smartphone_data(hfiles, ind,filt,Fs, gr )
%UNTITLED3 Summary of this function goes here
% IF filt = 1 ---> fft filter is activated
% IF filt = 2 ---> Envelope filter is activated
% IF filt = 3 ---> SSA filter is activated
% IF filt = 0 ---> NO filter is activated


%   Detailed explanation goes here
% clear all
% close all

addpath('.\thtools2\')
% hfiles = findmeasfiles('D:\Seafile\Seafile\All Clinical Data\SR_Healthy_smartphone');
% hfiles = findmeasfiles('D:\BIOSIGNAL_PROCESSING\Physiological Recordings\Mobile_datas_AF\AF_positives');
% hfiles = findmeasfiles('D:\BIOSIGNAL_PROCESSING\Physiological Recordings\Mobile_datas_LP_PRE\Only CAD_Acute'); % Puhelimen valinta
% hfiles = findmeasfiles('D:\BIOSIGNAL_PROCESSING\Physiological Recordings\Nostrokes\meas_ykkoset'); % Puhelimen valinta
% hfiles = findmeasfiles('D:\BIOSIGNAL_PROCESSING\Physiological Recordings\MOJTABA_MI_DATAS\MI_pre angio'); % Puhelimen valinta
% hfiles = findmeasfiles('D:\BIOSIGNAL_PROCESSING\Physiological Recordings\MOJTABA_MI_DATAS\MI_post angio'); % Puhelimen valinta
% 
filnum = ind % TÄTÄ MUUTTAMALLA VAIHTAA MITTAUSTA! 

hfile = hfiles(filnum);
% fs = 200;
hfile = hfile{1};
tt = findstr(hfile,'\');

%%
delimiter = {'\t',',',' '};

%% Format for each line of text:

formatSpec = '%s%s%*s%*s%*s%*s%*s%*s%[^\n\r]';

%% Open the text file.
fileID = fopen(hfile,'r');

%% Read columns of data according to the format.

dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);

ID=str2num(dataArray{1,2}{3});

%%%%%%


newmanpoints = 0;

infofilename = hfile(tt(end)+1:end)
pathname = hfile(1:tt(end))

gyrofilename = [ 'Gyro', infofilename(5:end)  ]
accfilename =  [ 'Acc', infofilename(5:end)  ]
% rrifilename =  [ 'RRInt', infofilename(5:end)  ]

grdata = importdata([pathname,gyrofilename]);

accdata = importdata([pathname,accfilename]);
timegr = grdata(:,4);
timeacc = accdata(:,4);
tmin = min(min(timegr),min(timeacc));

timegr = timegr-tmin;
timeacc = timeacc-tmin;
fs = 10*round(1e8*1/mean(diff(timeacc)))

[b,a]=butter(4,[.01,.4]);        % Bandpass digital filter design
[bb,aa]=butter(4,[.01,.2]);   
gyroX = grdata(:,1);
gyroY = grdata(:,2);
gyroZ = grdata(:,3);

AccX = accdata(:,1);
AccY = accdata(:,2);
AccZ = accdata(:,3);

if numel(gyroY)<numel(AccZ)
         start=2*Fs;
        stop=numel(gyroY)-(2*Fs);
else
        start=2*Fs;
        stop=numel(AccZ)-(2*Fs);
end
    
gyroX=detrend(double(gyroX(start:stop))).*57.3; %%%%% degree per second scale
    gyroY=detrend(double(gyroY(start:stop))).*57.3;
    gyroZ=detrend(double(gyroZ(start:stop))).*57.3;
    AccX=detrend(double(AccX(start:stop)));%%%% g scale
    AccY=detrend(double(AccY(start:stop)));
    AccZ=detrend(double(AccZ(start:stop)));
    
switch filt
    
    case 1
gyroX = filter(bb,aa,gyroX);
gyroY = filter(bb,aa,gyroY);
gyroZ = filter(bb,aa,gyroZ);
AccX = filter(b,a,AccX);
AccY = filter(b,a,AccY);
AccZ = filter(b,a,AccZ);
 if gr
            plotsmartphonedata( AccX,AccY,AccZ,gyroX,gyroY,gyroZ,Fs,gr )
  end

    case 2
gyroX = HF_sphone(gyroX,2);
gyroY = HF_sphone(gyroY,2);
gyroZ = HF_sphone(gyroZ,2);
AccX = HF_sphone(AccX,1);
AccY = HF_sphone(AccY,1);
AccZ = HF_sphone(AccZ,1);
 if gr
            plotsmartphonedata( AccX,AccY,AccZ,gyroX,gyroY,gyroZ,Fs,gr )
  end
    case 3
        winlen=floor(Fs/16);
        order=2;
        gr_in=0;
 [gyroX,kk,jj] = ssa(gyroX,winlen,order,gr_in);
 [gyroY,kk,jj]= ssa(gyroY,winlen,order,gr_in);
[gyroZ,kk,jj] = ssa(gyroZ,winlen,order,gr_in);
 [AccX,kk,jj]= ssa(AccX,winlen,order,gr_in);
 [AccY,kk,jj]= ssa(AccY,winlen,order,gr_in);
 [AccZ,kk,jj]= ssa(AccZ,winlen,order,gr_in);
 if gr
            plotsmartphonedata( AccX,AccY,AccZ,gyroX,gyroY,gyroZ,Fs,gr )
 end
  
  otherwise
        disp('No Filtering')
  
gyroX = baseline_removal_imu(gyroX,1,fs);
gyroY = baseline_removal_imu(gyroY,1,fs);
gyroZ = baseline_removal_imu(gyroZ,1,fs);
AccX = baseline_removal_imu(AccX,1,fs);
AccY = baseline_removal_imu(AccY,1,fs);
AccZ = baseline_removal_imu(AccZ,1,fs);
        if gr
            plotsmartphonedata( AccX,AccY,AccZ,gyroX,gyroY,gyroZ,Fs,gr )
        end
end
     
samplingfreq=200;
data=struct('accX',AccX,'accY',AccY,'accZ',AccZ,'gyroX',gyroX,'gyroY',gyroY,'gyroZ',gyroZ,'fs',samplingfreq,'ID',ID);


% header = load_header2([pathname,infofilename])
 



end

