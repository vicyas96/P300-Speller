%Compare create time of .ov File with the time when Start button was
%clicked. Then find the difference to know how much to remove from the
%beginning

%ovDirectory = [pwd '\'];
ovDirectory = ['C:\Users\' getenv('username') '\AppData\Roaming\openvibe-2.2.0\scenarios\signals\NewRecordedSignals\'];
listOfFiles = dir(fullfile(ovDirectory, '*.ov*')); %bring back to .ov
for i = 1 : length(listOfFiles)
    [filepath,name,ext] = fileparts([ovDirectory listOfFiles(i).name]);
    convert_ov2mat([ovDirectory listOfFiles(i).name], [ovDirectory name '.mat']);
    load([ovDirectory name '.mat']);
    ovFileHours = str2num([name(25) name(26)]);
    ovFileMinutes = str2num([name(28) name(29)]);
    ovFileSeconds = str2num([name(31) name(32)]);
    ovFileSecondsTotal = (ovFileHours*3600) + (ovFileMinutes*60) + ovFileSeconds;
    load([ovDirectory 'Vectors\' 'currentTimeAndSentence.mat']);
    %timeDifference = abs(ovFileSecondsTotal - currentTimeVector(1));
end


%%%%%Original Data after appying BandPassFilter
filteredSamples = bandpass(samples, [0.1 30], 128);

%%%%%Some other filters I've tried, but results were much worse
%[b,a] = butter(20,[0.1 30]/128, 'bandpass');
%filteredSamples = filtfilt(Num, 1, samples);
% filteredSamples = filtfilt(a, 1, samples);
%filteredSamples = filtfilt(SOS, G, samples);
%filteredSamples = samples;


% Ones = ones(96,1);
% Zeros = -1*ones(96,1);
% onesZeros = [Ones; Zeros];

%%%%For every character,  extract 128*0.5=64 samples per flash (500 ms after flash)
for currentCharacter = 1 : length(sentence)
    flashCounter = 1;
    finalVector = [];
    newFilteredSamples = filteredSamples;
    for epochs = 1 : 15
        for numberOfFlashes = 1 : 12
            flashCounter = flashCounter + 1;
            timeDifference = abs(ovFileSecondsTotal - currentTimeVector(flashCounter));
            newFilteredSamples(1:timeDifference*128,:) = [];
            currentCharacterVector = newFilteredSamples(1 : 64, :);
            newFilteredSamples = filteredSamples;
            finalVector = [finalVector; currentCharacterVector];
        end
    end
    newLetterWaveName = ['Letter' sentence(currentCharacter) '_BrainWave'];
    assignin('base', newLetterWaveName, finalVector);
    %save([newLetterWaveName '.mat'], newLetterWaveName);
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Signal Averaging%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%Take an average across 15 iterations for every character
    rowCounter = 1;
    vectorT = [];
    vectorBrain = [];
    averageVector = [];
    BrainWaveAverage = 0;
    concatenatedVector = [];
    LetterBrainWave = finalVector;
    targetVectorTemp = targetVector;
    for epochs = 1 : 15
        averageVector = [];
        for numberOfFlashes = 1 : 12
            concatenatedVector = [];
            vectorT = targetVectorTemp(rowCounter:rowCounter + 64 - 1);
            vectorBrain = LetterBrainWave(rowCounter:rowCounter + 64 - 1, :);
            concatenatedVector = [vectorBrain, vectorT];
            rowCounter = rowCounter + 64;
            averageVector = [averageVector; concatenatedVector];
        end
        BrainWaveAverage = BrainWaveAverage + averageVector;
    end
    BrainWaveAverage = BrainWaveAverage/15;
    
    newName = ['Letter' sentence(currentCharacter) '_BrainWaveAverage'];
    assignin('base', newName, totalAverage);
    save([ovDirectory newName], BrainWaveAverage);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


