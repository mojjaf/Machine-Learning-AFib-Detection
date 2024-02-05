function [ rrint, xcval, aocint, xcval2] = xcorrsykelyhyt(seismo,fs,intval)
%[ rrint, xcval, aocint, xcval2] = xcorrsykelyhyt(seismo,fs,intval)

% if nargin<2
%     fs = 800;
% end
% fs
% C = ones(1,1200);
% C(1:200) = 0;
% C(201:400)=1;
% C(401:800)=.75;
% C(801:end)=.5;


len = numel(seismo);
num = floor((len-fs)/fs);
% ml = fs;
L = round(fs*1.5);
for ii = 1 : num-1;
%     intval = 2000;
    intval = fs*2.5;
%     if intval < 1000;
%         intval = 1000;
%     end
    indvec = (1:intval) + (ii-1)*fs;
    
    try
        tmp = seismo(indvec);
    catch
        keyboard
    end
    
    tmp = tmp-mean(tmp);
    xc = xcorr(tmp,tmp(1:L));
    
    %
    xc = xc(intval:end);
    xc2 = xc;
    xc = xc.*linspace(2,1,numel(xc))';
    
    xc2(1:round(fs/8)) = 0;
    xc2(round(fs*3/8):end) = 0;
%     xc(1:300) = 0;
    xc(1:round(3/8*fs)) = 0;
    [mv, ml] = max(xc);
    rrint(ii) = ml;
    xcval(ii) = mv;
    
    
    [mv, ml] = max(xc2);
    aocint(ii) = ml;
    xcval2(ii) = mv;
%     L = ml*1.4;
%     L = 1200;
end









