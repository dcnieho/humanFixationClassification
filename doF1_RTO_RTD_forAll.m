clear variables; clear global; clear mex; close all; fclose('all'); clc
dbstop if error % for debugging: trigger a debug point when an error occurs

dirs.home = cd;
cd data;                        dirs.data       = cd;
        cd coderSettings;       dirs.coderSet   = cd;
cd ..;  cd ETdata;              dirs.ETdata     = cd;
cd ..;
cd ..;  cd function_library;    dirs.funclib    = cd;
cd ..;
if ~isdir('results'), mkdir('results'), end
cd results;                     dirs.res        = cd;
cd(dirs.home);
addpath(genpath(dirs.funclib));                 % add dirs to path

%%%
% params
freq = 300;     % sampling frequency of input data on which the settings were made by the coders
%%%

% Read in all settings made by coders
[subj,nsubj] = FileFromFolder(dirs.coderSet,[],'txt');
for p=nsubj:-1:1
    dat(p)          = readSettingsFile(fullfile(dirs.coderSet,subj(p).name),1);
    subjname{p}     = subj(p).fname;
end

% convert setting times to sample indices
for p=1:nsubj
    dat(p).ifixstart= round(dat(p).fixstart./1000*freq)+1;
    dat(p).ifixend  = round(dat(p).fixend  ./1000*freq)+1;
end

% preallocate output
F1                  = zeros(nsubj);
precision           = zeros(nsubj);
recall              = zeros(nsubj);
startOffsets        = repmat({[]},nsubj,nsubj);
endOffsets          = repmat({[]},nsubj,nsubj);

% determine stimulus names
stimnames           = unique(dat(1).stimulus);
nstims              = numel(stimnames);

% determine measures for all combinations of coders
for c1=1:nsubj
    for c2=1:c1   % NB: as these measures are (skew-)symmetric, only do unique combinations
        % initialize counts
        hit         = 0;
        miss        = 0;
        falseAlarm  = 0;
        
        % per stimulus, compare ref and test sets
        for t=1:nstims
            % select reference (coder 1) and test (coder 2) settings for this stimulus
            qRef        = strcmp(dat(c1).stimulus,stimnames{t});
            qTest       = strcmp(dat(c2).stimulus,stimnames{t});
            
            % extract setting locations
            ref         = [dat(c1).ifixstart(qRef)  dat(c1).ifixend(qRef) ];
            test        = [dat(c2).ifixstart(qTest) dat(c2).ifixend(qTest)];
            
            if isempty(ref) && isempty(test)
                % nothing to process
                continue
            end
            
            
            % determine hits, misses and false alarms, add to counts from previous stimuli 
            [thit,tmiss,tfalseAlarm] = computeHitMissFA(ref,test);
            hit             = hit        + thit;
            miss            = miss       + tmiss;
            falseAlarm      = falseAlarm + tfalseAlarm;
            
            
            % determine start and end offsets
            [startOffs,endOffs] = computeStartEndOffsets(ref,test);
            startOffsets{c1,c2}   = [startOffsets{c1,c2}; startOffs];
            endOffsets{c1,c2}     = [  endOffsets{c1,c2};   endOffs];
        end
        
        % now compute F1, precision and recall
        [F1(c1,c2),precision(c1,c2),recall(c1,c2)] = computeF1FromHitMissFA(hit,miss,falseAlarm);
        
        % output to console
        fprintf('%d\t%d\t%s vs %s\t%.2f\t%d\t%d\t%d\n',c1,c2,subjname{c1},subjname{c2},F1(c1,c2),hit,miss,falseAlarm);
    end
end


% output matrices to file
F1voll              = F1 + tril(F1,-1).';                                   % fill whole matrix, making use of fact that F1 is symmetric
filename            = fullfile(dirs.res,'Obs agree F1.xls');
ok                  = writeMatrix(filename,subjname,F1voll);

precisionvoll       = precision + tril(recall,-1).';                        % fill whole matrix, making use of fact that precision and recall are each other's opposites
filename            = fullfile(dirs.res,'Obs agree precision.xls');
ok                  = writeMatrix(filename,subjname,precisionvoll);

recallvoll          = recall + tril(precision,-1).';                        % fill whole matrix, making use of fact that recall and precision are each other's opposites
filename            = fullfile(dirs.res,'Obs agree recall.xls');
ok                  = writeMatrix(filename,subjname,recallvoll);

startOffsetsMean    = tril(cellfun(@mean,startOffsets)).*1000./freq;
startOffsetsMean    = startOffsetsMean - tril(startOffsetsMean,-1).';       % fill whole matrix, making use of fact that RTO is skew-symmetric
filename            = fullfile(dirs.res,'RTO onset.xls');
ok                  = writeMatrix(filename,subjname,startOffsetsMean);

startOffsetsSD      = tril(cellfun(@std,startOffsets)).*1000./freq;
startOffsetsSD      = startOffsetsSD + tril(startOffsetsSD,-1).';           % fill whole matrix, making use of fact that RTD is symmetric
filename            = fullfile(dirs.res,'RTD onset.xls');
ok                  = writeMatrix(filename,subjname,startOffsetsSD);

endOffsetsMean      = tril(cellfun(@mean,endOffsets)).*1000./freq;
endOffsetsMean      = endOffsetsMean - tril(endOffsetsMean,-1).';           % fill whole matrix, making use of fact that RTO is skew-symmetric
filename            = fullfile(dirs.res,'RTO offset.xls');
ok                  = writeMatrix(filename,subjname,endOffsetsMean);

endOffsetsSD        = tril(cellfun(@std,endOffsets)).*1000./freq;
endOffsetsSD        = endOffsetsSD + tril(endOffsetsSD,-1).';               % fill whole matrix, making use of fact that RTD is symmetric
filename            = fullfile(dirs.res,'RTD offset.xls');
ok                  = writeMatrix(filename,subjname,endOffsetsSD);

% clean up path
rmpath(genpath(dirs.funclib));