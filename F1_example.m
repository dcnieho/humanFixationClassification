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

% compute F1 from these events
[F1,precision,recall,hit,miss,falseAlarm] = computeF1FromEvents(ref,test);

% print result to console
fprintf('F1: %.2f\nprecision: %.2f\nrecall:%.2f\n(hit: %d, miss: %d, false alarm: %d)\n',F1,precision,recall,hit,miss,falseAlarm);

% clean up path
rmpath(genpath('function_library'));