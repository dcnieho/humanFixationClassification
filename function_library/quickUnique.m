function c = quickUnique(a)
% if you just want standard unique with its first output only, this does
% the trick quicker. Just took relevant lines out of MATLAB's unique()

if isempty(a)
    c = a;
    return;
end

a = a(:);
sortA = sort(a);
dSortA = diff(sortA);
groupsSortA = [true; dSortA ~= 0];      % First element is always a member of unique list
c = sortA(groupsSortA);                 % Create unique list by indexing into sorted list
