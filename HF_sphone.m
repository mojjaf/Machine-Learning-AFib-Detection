function [ tmptri ] = HF_sphone(  signal,flag )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
dsrate = 1;
nfir = 4;
nfir2 = 8;
bhp = -ones(1,nfir)/nfir;
bhp(1) = bhp(1)+1;
blp = triang(nfir2);
finalfilterlength = round(51/dsrate);
finalfilter = triang(finalfilterlength);



if flag==1
accZ = signal;
accZfilt = filter(bhp,1,accZ);
accZfilt = filter(blp,1,accZfilt);
tmp3 = accZfilt(1:dsrate:end);
tmptri = filter(finalfilter,1,abs(tmp3));
end

if flag==2
gyroY = signal;
gyrfilt = filter(bhp,1,gyroY);
gyro_filt = filter(blp,1,gyrfilt);
tmp3 = gyro_filt(1:dsrate:end);
tmptri = filter(finalfilter,1,abs(tmp3));
end

end

