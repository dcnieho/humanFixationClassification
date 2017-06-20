function [F1,precision,recall,hit,miss,falseAlarm] = computeF1FromEvents(ref,test)
% [F1,precision,recall,hit,miss,falseAlarm] = computeF1FromEvents(ref,test)
% ref and test contain event specifications as a Nx2 matrix, with one row
% per event, the event start indices in the left column and the event end
% index in the right column. Event indices are 1-based.

if isempty(ref) && isempty(test)
    % nothing to process
    [F1,precision,recall] = deal(nan);
    [hit,miss,falseAlarm] = deal(0);
    return;
end

% determine hits, misses and false alarms
[hit,miss,falseAlarm] = computeHitMissFA(ref,test);

% compute F1 etc from the hits, misses and false alarms
[F1,precision,recall] = computeF1FromHitMissFA(hit,miss,falseAlarm);
