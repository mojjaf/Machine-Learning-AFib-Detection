function feat = featuresFromAcc(at, fs)
% featuresFromBuffer Extract vector of features from raw data buffer
% 
% Copyright 2014-2015 The MathWorks, Inc.

% Initialize digital filter
% persistent fhp
% if(isempty(fhp))
%     fhp = hpfilter;
%     fhp.PersistentMemory = false;
% end

% Initialize feature vector
feat = zeros(1,22);

% Remove gravitational contributions with digital filter
% abx = filter(fhp,at);
abx=at;

% Average value in signal buffer for all three acceleration components (1 each)
feat(1) = mean(at);


% RMS value in signal buffer for all three acceleration components (1 each)
feat(2) = rmslevel(abx);


% Autocorrelation features for all three acceleration components (3 each): 
% height of main peak; height and position of second peak
feat(3:5) = covFeatures(abx, fs);


% Spectral peak features (12 each): height and position of first 6 peaks
feat(6:17) = spectralPeaksFeatures(abx, fs);

% Spectral power features (5 each): total power in 5 adjacent
% and pre-defined frequency bands
feat(18:22) = spectralPowerFeatures(abx, fs);


% --- Helper functions
function feats = covFeatures(x, fs)

feats = zeros(1,3);

[c, lags] = xcorr(x(1:end/2));

minprom = 0.05;
mindist_xunits = 0.4;
minpkdist = floor(mindist_xunits/(1/fs));
[pks,locs] = findpeaks(c,...
    'minpeakprominence',minprom,...
    'minpeakdistance',minpkdist);

tc = (1/fs)*lags;
tcl = tc(locs);
% Feature 1 - peak height at 0
if(~isempty(tcl))   % else f1 already 0
    feats(1) = pks((end+1)/2);
end
% Features 2 and 3 - position and height of first peak 
if(length(tcl) >= 3)   % else f2,f3 already 0
    feats(2) = tcl((end+1)/2+1);
    feats(3) = pks((end+1)/2+1);
end

function feats = spectralPeaksFeatures(x, fs)

mindist_xunits = 0.3;

feats = zeros(1,12);

% N = 4096;
N = 2048;

minpkdist = floor(mindist_xunits/(fs/N));

[p, f] = pwelch(x,rectwin(length(x)),[],N,fs);

[pks,locs] = findpeaks(p,'npeaks',20,'minpeakdistance',minpkdist);
if(~isempty(pks))
    mx = min(6,length(pks));
    [spks, idx] = sort(pks,'descend');
    slocs = locs(idx);

    pks = spks(1:mx);
    locs = slocs(1:mx);

    [slocs, idx] = sort(locs,'ascend');
    spks = pks(idx);
    pks = spks;
    locs = slocs;
end
fpk = f(locs);

% Features 1-6 positions of highest 6 peaks
feats(1:length(pks)) = fpk;
% Features 7-12 power levels of highest 6 peaks
feats(7:7+length(pks)-1) = pks;

function feats = spectralPowerFeatures(x, fs)

feats = zeros(1,5);

edges = [0.5, 1.5, 5, 10, 15, 20];

[p, f] = periodogram(x,[],4096,fs);
    
for kband = 1:length(edges)-1
    feats(kband) = sum(p( (f>=edges(kband)) & (f<edges(kband+1)) ));
end
