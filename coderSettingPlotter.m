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
freq = 300;     % tracking frequency of eye-tracker
%%%

% Read in all settings made by coders
[subj,nsubj] = FileFromFolder(dirs.coderSet,[],'txt');
for p=nsubj:-1:1
    dat(p)          = readSettingsFile(fullfile(dirs.coderSet,subj(p).name),1);
    subjname{p}     = subj(p).fname;
end

% determine stimulus names
stimnames           = unique(dat(1).stimulus);
nstims              = numel(stimnames);

fhndl = -1;
qBreak = false;
% go through all stimuli
for t=1:nstims
    % import data
    data        = readdatafile(fullfile(dirs.ETdata,[stimnames{t} '.txt']));
    
    % collect settings of all coders for this stimulus
    settings = cell(1,nsubj);
    for c=1:nsubj
        % find fixation info from this trial, if any
        qSet        = strcmp(dat(c).stimulus,stimnames{t});
        
        % extract setting locations
        settings{c} = [dat(c).fixstart(qSet) dat(c).fixend(qSet)];
    end
    
    % per stimulus, plot settings
    if ~ishghandle(fhndl)
        fhndl = figure('Units','normalized','Position',[0 0 1 1]);  % make fullscreen figure
    else
        figure(fhndl);
        clf;
    end
    plotDetection(data.time,data.x,data.y,data.v,settings,subjname,1,stimnames{t});
    set(fhndl,'Visible','on');  % assert visibility to bring window to front again after keypress
    pause
    if ~ishghandle(fhndl)
        qBreak = true;
        break;
    end
    
    if qBreak
        break;
    end
end

% clean up path
rmpath(genpath(dirs.funclib));