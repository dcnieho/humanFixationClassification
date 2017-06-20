addpath(genpath('function_library'));                 % add dirs to path

% event specification is a Nx2 matrix, with one row per event, the event
% start indices in the left column and the event end index in the right
% column. Event indices are 1-based.
ref     = [
    1 20
    33 46
    49 60
    63 74
    ];
test    = [
    4 12
    15 24
    27 54
    66 80
];

% to convert offsets in samples to ms, we need sampling frequency of the
% data
freq = 300;     % Hz

[startOffsets,endOffsets] = computeStartEndOffsets(ref,test);
startOffsets = startOffsets.*1000./freq;
endOffsets   =   endOffsets.*1000./freq;

% RTO: mean of offsets
startRTO = mean(startOffsets);
endRTO   = mean(  endOffsets);

% RTD: SD of offsets
startRTD = std(startOffsets);
endRTD   = std(  endOffsets);

% print result to console
fprintf('start RTO: %.2f\nstart RTD: %.2f\nend RTO: %.2f\nend RTD: %.2f\n',startRTO,startRTD,endRTO,endRTD);

% clean up path
rmpath(genpath('function_library'));