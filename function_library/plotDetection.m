function plotDetection(time,Xdata,Ydata,Vdata,allSettings,allSubs,pIdx,tit)

ax1 = subplot(4,1,1); hold on
doPlot(time,Xdata,allSettings{pIdx}(:,1),allSettings{pIdx}(:,2));
ylabel('X (pix)')
axis tight
axis ij
title(texlabel(tit,'literal'))

ax2 = subplot(4,1,2); hold on
doPlot(time,Ydata,allSettings{pIdx}(:,1),allSettings{pIdx}(:,2));
ylabel('Y (pix)')
axis tight
axis ij

ax3 = subplot(4,1,3); hold on
doPlot(time,Vdata,allSettings{pIdx}(:,1),allSettings{pIdx}(:,2));
ylabel('Vel (pix/s)')
axis tight
xl = get(ax3,'XLim');
xlim([0 xl(2)]);

ax4 = subplot(4,1,4); hold on

for c=1:numel(allSettings)
    plotScarf(allSettings{c},c,c==pIdx);
    
    % add label
    window = time(end)-time(1);
    text(0,c-.5,[allSubs{c} ' '],'HorizontalAlignment','right','VerticalAlignment','middle')
end
axis ij
axis tight
ylim([0 numel(allSettings)])
axis off

axs = [ax1 ax2 ax3 ax4];

fh = gcf;
fh.ButtonDownFcn = @(a,b) changeCodingClick(a,b,axs,time,{Xdata,Ydata,Vdata},allSettings);

linkaxes(axs,'x');





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

function plotScarf(settings,idx,qHighlight)
% get fix start and end
fStart = settings(:,1);
fEnd   = settings(:,2);

% determine color
if qHighlight
    clr = [1 0 0];
else
    clr = .5*[1 1 1];
end

% plot as bar
for q=1:length(fStart)
    fill([fStart(q) fEnd(q) fEnd(q) fStart(q)],[idx-.9 idx-.9 idx-.1 idx-.1],clr,'Edgecolor',[0 0 0],'HitTest','off')
end

function changeCodingClick(figH, ~, axs, time,data,allSettings)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cp = figH.CurrentPoint;
axPos = axs(4).Position;
if cp(1)>=axPos(1) && cp(1)<=sum(axPos([1 3])) && cp(2)>=axPos(2) && cp(2)<=sum(axPos([2 4]))
    % get point on axis, determine which scarf clicked
    whichClicked = ceil(axs(4).CurrentPoint(1,2));
    
    % redraw data axes
    for a=1:3
        delete(axs(a).Children);
        axes(axs(a)); %#ok<LAXES>
        doPlot(time,data{a},allSettings{whichClicked}(:,1),allSettings{whichClicked}(:,2));
    end
    
    % redraw scarf
    % first clear all scarf elements
    hs = findobj(axs(4).Children, 'flat', 'Type', 'patch');
    delete(hs);
    % redraw them
    axes(axs(4));
    for c=1:numel(allSettings)
        plotScarf(allSettings{c},c,c==whichClicked);
    end
end
