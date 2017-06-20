function [data] = readdatafile(filenaam)

[fid,message] = fopen(filenaam);
if fid == -1
    error([message filenaam]);
end

skip = 1;                    % to skip header
for p=1:skip
    fgetl(fid);
end

dummy   = textscan(fid,'%f%f%f%f','delimiter','\t');
fclose(fid);

data.time   = dummy{:,1};
data.x      = dummy{:,2};
data.y      = dummy{:,3};
data.v      = dummy{:,4};
