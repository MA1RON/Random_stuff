clear; close all; clc;
%% create game
show_flag = true;
nn = 5;
[uu,vv,MM] = make_vectors(nn);

%% results
%{
fprintf('Cols:\n')
disp(uu)
fprintf('Rows:\n')
disp(vv)
fprintf('Solution:\n')
disp(MM*2-1)
%}

%% plot the time
history = readmatrix('historical_data.csv');
subplot(3,3,1);
for point = 1:size(history,1)
    hold on
    if history(point,3) == 0 % win
        plot(history(point,1),history(point,2),'ko','markersize',12,'markerfacecolor','b');
    elseif history(point,3) == 1 % not a single solution
        plot(history(point,1),history(point,2),'ko','markersize',12,'markerfacecolor','r');
    end
end
set(gca,'fontsize',18)
grid on

%% play it
% fprintf('Result:\n')
tic; [MM,end_type] = play(uu,vv,show_flag);
time = toc;
writematrix([history;nn time end_type], 'historical_data.csv');
history = readmatrix('historical_data.csv');

%% plot the time
subplot(3,3,1);
if end_type == 0 % win
    plot(nn,time,'ko','markersize',12,'markerfacecolor','b');
elseif end_type == 1 % not a single solution
    plot(nn,time,'ko','markersize',12,'markerfacecolor','r');
end
set(gca,'fontsize',18)
grid on