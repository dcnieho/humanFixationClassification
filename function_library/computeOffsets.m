function [offsets] = computeOffsets(ref,test)

% make vectors describing where the fixations were coded in this data
[refVec,testVec]    = makeEventVectors(ref,test);
nFixRef             = size(ref,1);

% walk through reference, and see if there is also a fixation
% in the test vector in the same place (i.e, if there is any
% overlap). If so, consume/remove it from both ref and test so
% that it cannot be used again. Determine offset between start
% of event in reference vector and test vector.
offsets = nan(nFixRef,1);
for f=1:nFixRef
    qRefFix             = refVec==f;
    testFix             = quickUnique(testVec(qRefFix));                % see what is in the other data stream (0: not coded or used already, numbers code samples assigned to unique fixations)
    testFix             = min(testFix(testFix~=0));                     % take first fixation overlapping with refFix
    
    if ~isempty(testFix)
        qTestfix        = testVec==testFix;                             % get offsets between onsets of matched fixations
        offsets(f)      = find(qRefFix,1)-find(qTestfix,1);             % negative value means that test is later than ref
        
        % consume involved fixations so that they can't be matched again
        refVec(qRefFix)             = 0;
        testVec(testVec==testFix)   = 0;
    end
end

% some fixations were not matched, remove from output
offsets(isnan(offsets)) = [];
