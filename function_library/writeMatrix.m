function [ok] = writeMatrix(filename,subjname,K)

nsubj       = length(subjname);
fid         = fopen(filename,'wt');

% matrix header
for p=1:nsubj
    fprintf(fid,'\t%s',subjname{p});
end
fprintf(fid,'\n');

% print matrix values
for r=1:nsubj
    fprintf(fid,'%s',subjname{r});
    for s=1:nsubj
        fprintf(fid,'\t%.3f',K(r,s));
    end
    fprintf(fid,'\n');        
end
fclose(fid);
ok = 1;
