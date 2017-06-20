function [data] = readSettingsFile(filenaam,skip)
 
[fid,message]   = fopen(filenaam);
if fid == -1
    error(message);
end
 
for p=1:skip                         % to skip header
    fgetl(fid);
end
 
dummy           = textscan(fid,'%s%s%f%f%f','delimiter','\t');
fclose(fid);
 
p               = 1;
data.stimulus   = dummy{:,p}; p=p+1;
data.date       = dummy{:,p}; p=p+1;
data.fixstart   = dummy{:,p}; p=p+1;
data.fixend     = dummy{:,p}; p=p+1;
data.fixdur     = dummy{:,p}; p=p+1;
