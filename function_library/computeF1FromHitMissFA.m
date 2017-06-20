function [F1,precision,recall] = computeF1FromHitMissFA(hit,miss,falseAlarm)

F1          = 2*hit/(2*hit+miss+falseAlarm);
precision   = hit/(hit+falseAlarm);
recall      = hit/(hit+miss);
