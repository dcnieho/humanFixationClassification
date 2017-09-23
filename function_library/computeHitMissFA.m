function [hit,miss,falseAlarm] = computeHitMissFA(ref,test)
% [hit,miss,falseAlarm] = computeHitMissFA(ref,test)
% ref and test contain event specifications as a Nx2 matrix, with one row
% per event, the event start indices in the left column and the event end
% index in the right column. Event indices are 1-based.

% logic: We make two vectors indicating for two coders where they set there
% events. We take one as the reference, and the other as the test vector.
% Walk through reference, and see if there is also a fixation in the test
% vector in the same place (i.e, if there is any overlap). If so,
% consume/remove it from both ref and test so that it cannot be used again.
% Count as a hit.
% When we have reached the end of the ref vector, what remains in ref is a
% miss (as it did not also occur in test), and what remains in test is a
% false alarm (as there is nothing there in reference set).

hit         = 0;
miss        = 0;
falseAlarm  = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% make vectors describing where the fixations were coded in this data
[refVec,testVec]    = makeEventVectors(ref,test);
nFixRef             = size(ref,1);

% walk through reference, and see if there is also a fixation
% in the test vector in the same place (i.e, if there is any
% overlap). If so, consume/remove it from both ref and test so
% that it cannot be used again. Count as a hit.
for f=1:nFixRef
    qRefFix = refVec==f;
    testFix = testVec(qRefFix & testVec~=0);                % see what is in the other data stream (0: not coded or used already, numbers code samples assigned to unique fixations)
    
    if ~isempty(testFix)
        testFix                     = testFix(1);           % take first fixation overlapping with refFix
        % mark as hit, consume involved fixations so they can't
        % be matched again
        hit                         = hit+1;
        refVec(qRefFix)             = 0;
        testVec(testVec==testFix)   = 0;
    end
end
% We have reached the end of the ref vector, what remains in
% ref is a miss (as it did not also occur in test), and what
% remains in test is a false alarm (as there is nothing there
% in reference set).
miss        = miss       + numel(quickUnique(refVec (refVec >0)));
falseAlarm  = falseAlarm + numel(quickUnique(testVec(testVec>0)));
