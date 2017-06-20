function plotDetection(time,Xdata,Ydata,Vdata,allSettings,allSubs,pIdx,tit)

ax1 = subplot(4,1,1); hold on
doPlot(time,Xdata,allSettings{pIdx}(:,1),allSettings{pIdx}(:,2));
ylabel('X (°)')
axis ij
title(texlabel(tit,'literal'))

ax2 = subplot(4,1,2); hold on
doPlot(time,Ydata,allSettings{pIdx}(:,1),allSettings{pIdx}(:,2));
ylabel('Y (°)')
axis ij

ax3 = subplot(4,1,3); hold on
doPlot(time,Vdata,allSettings{pIdx}(:,1),allSettings{pIdx}(:,2));
ylabel('Vel (°/s)')
xl = get(ax3,'XLim');
xlim([0 xl(2)]);

ax4 = subplot(4,1,4); hold on

ylim([0.6 numel(allSettings)+.4])
for c=1:numel(allSettings)
    % get fix start and end
    fStart = allSettings{c}(:,1);
    fEnd   = allSettings{c}(:,2);
    
    % determine color
    if c==pIdx
        clr = [1 0 0];
    else
        clr = .5*[1 1 1];
    end
    
    % plot as bar
    for q=1:length(fStart)
        fill([fStart(q) fEnd(q) fEnd(q) fStart(q)],[c-.4 c-.4 c+.4 c+.4],clr,'Edgecolor',[0 0 0])
    end
    
    % add label
    window = time(end)-time(1);
    text(0,c,[allSubs{c} ' '],'HorizontalAlignment','right','VerticalAlignment','middle')
end
axis ij
axis tight
axis off

linkaxes([ax1 ax2 ax3 ax4],'x');



% helpers
function doPlot(time,data,fStart,fEnd)
lim = [min(data) max(data)];
for p=1:length(fStart)
    patch([fStart(p) fEnd(p) fEnd(p) fStart(p)],[lim([2 2]) lim([1 1])], .8*[1 1 1]);
    plot(fStart([p p]),lim,'-','Color',[.5 .5 1],'LineWidth',1.5)
    plot(fEnd  ([p p]),lim,'-','Color',[1 .5 .5],'LineWidth',1.5)
end
plot(time,data,'k-')
xlabel('time(ms)')
axis tight
