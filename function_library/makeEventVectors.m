function [vec1,vec2] = makeEventVectors(evt1,evt2)

% determine last sample used
nsamp   = max([evt1(:); evt2(:)]);

% make vectors coding where events are
vec1    = makeTheVector(evt1,nsamp);
vec2    = makeTheVector(evt2,nsamp);



% helpers
function vec = makeTheVector(evt,nsamp)
% for each event, fill vector with sequene number of event between event
% start and event end. Zero otherwise
% e.g. evt = [2 4; 7 10] yields:
% vec = [0 1 1 1 0 0 2 2 2 2]
vec = zeros(1,nsamp);
for f=1:size(evt,1)
    vec(evt(f,1):evt(f,2)) = f;
end
