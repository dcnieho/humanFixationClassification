function [startOffsets,endOffsets] = computeStartEndOffsets(ref,test)
% [startOffsets,endOffsets] = computeStartEndOffsets(ref,test)
% ref and test contain event specifications as a Nx2 matrix, with one row
% per event, the event start indices in the left column and the event end
% index in the right column. Event indices are 1-based.

% logic: We make two vectors indicating for two coders where they set there
% events. We take one as the reference, and the other as the test vector.
% Walk through reference, and see if there is also a fixation in the test
% vector in the same place (i.e, if there is any overlap). If so,
% consume/remove it from both ref and test so that it cannot be used again.
% Compute offset for the matched event.

if isempty(ref) && isempty(test)
    % nothing to process
    [startOffsets,endOffsets] = deal([]);
    return;
end

% determine onset offsets
startOffsets    = computeOffsets(ref,test);

% determine offset offsets. For those, go through events back
% to front
nsamp           = max([ref(:); test(:)]);           % get highest sample index in data
nref            = nsamp-rot90(ref ,2)+1;            % code distance of each setting from this last sample
ntest           = nsamp-rot90(test,2)+1;            % code distance of each setting from this last sample
endOffsets      = -1 * computeOffsets(nref,ntest);  % as we are working on reversed time, multiply output by -1 to get back to normal time
