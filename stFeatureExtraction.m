function Features = stFeatureExtraction(signal, fs, win, step)

% function Features = stFeatureExtraction(signal, fs, win, step)
%
% This function computes basic audio feature sequencies for an audio
% signal, on a short-term basis.
%
% ARGUMENTS:
%  - signal:    the audio signal
%  - fs:        the sampling frequency
%  - win:       short-term window size (in seconds)
%  - step:      short-term step (in seconds)
%
% RETURNS:
%  - Features: a [MxN] matrix, where M is the number of features and N is
%  the total number of short-term windows. Each line of the matrix
%  corresponds to a seperate feature sequence
%
% (c) 2014 T. Giannakopoulos, A. Pikrakis

% if STEREO ...
% if (size(signal,2)>1)
%     signal = (sum(signal,2)/2); % convert to MONO
% end

% convert window length and step from seconds to samples:
windowLength = round(win * fs);
step = round(step * fs);

curPos = 1;
L = length(signal);

% compute the total number of frames:
numOfFrames = floor((L-windowLength)/step) + 1;
% number of features to be computed:
numOfFeatures = 46;
Features = zeros(numOfFeatures, numOfFrames);
Ham = window(@hamming, windowLength);
mfccParams = feature_mfccs_init(windowLength, fs);

for i=1:numOfFrames % for each frame
    % get current frame:
    frame  = signal(curPos:curPos+windowLength-1);
    frame  = frame .* Ham;
    frameFFT = getDFT(frame, fs);
    
    if (sum(abs(frame))>eps)
        % compute time-domain features:
        Features(1,i) = feature_zcr(frame);
        Features(2,i) = feature_energy(frame);
        Features(3,i) = feature_energy_entropy(frame, 10);

        % compute freq-domain features: 
        if (i==1) frameFFTPrev = frameFFT; end;
        [Features(4,i), Features(5,i)] = ...
            feature_spectral_centroid(frameFFT, fs);
        Features(6,i) = feature_spectral_entropy(frameFFT, 10);
        Features(7,i) = feature_spectral_flux(frameFFT, frameFFTPrev);
        Features(8,i) = feature_spectral_rolloff(frameFFT,  0.05);
%         MFCCs = feature_mfccs(frameFFT, mfccParams);
%         Features(9:21,i)  = MFCCs;
        
        [HR, F0] = feature_harmonic(frame, fs);
        Features(9, i) = HR;
        Features(10, i) = F0;        
        Features(10+1:10+22, i)= featuresFromAcc(frame, fs);
        
        Features(33, i) =  ApEn( 1, 0.2 * std(frame), frame, 1 );
         [ rrint1, xcval, aocint, xcval1 ] = xcorrsykelyhyt(frame,fs);
         [ Features(34, i) ] = rmssd( rrint1/fs );
           Features(35, i) = median( rrint1/fs );
                    [Features(36, i)] = Higuchi_FD(frame, 3); 
                    [Features(37, i),Features(38, i)] = HjorthParameters(frame);
          [ Features(39, i) ] = hrvpower( rrint1/fs );
        Features(40, i) = ShanEn( frame );
%           [Features(53, i), Features(54, i)] = getHeartRateSchmidt(frame, fs, 0);
%        
        Features(41, i) = MAS(frame); 
         Features(42, i) = Powerentropy(frame,fs, 5);
         Features(43, i) = sampleEntropy(frame, 2, 0.1, 2);
         Features(44, i) = skewness(frame);
         Features(45, i) = kurtosis(frame);
          Features(46, i) = tpr(frame);
        
      
    else
        Features(:,i) = zeros(numOfFeatures, 1);
    end    
    curPos = curPos + step;
    frameFFTPrev = frameFFT;
end
% Features(53, :) = medfilt1(Features(53, :), 3);
