function plot_square(MM,uu,vv)

MM(MM==-1) = .5;

h = figure(1);
h.Position = [300 100 1000 700];
% wait_time = .1; % s
% pause(wait_time)

%% main square
subplot(3,3,[5 9])
mp = heatmap(MM,'ColorbarVisible','off','CellLabelColor','none');
set(gca,'FontColor','white')

%% rows
subplot(3,3,[4 7])
heatmap(vv','ColorbarVisible','off')
set(gca,'fontsize',18,'FontColor','white')

%% cols
subplot(3,3,[2 3])
heatmap(uu,'ColorbarVisible','off')
set(gca,'fontsize',18,'FontColor','white')

end