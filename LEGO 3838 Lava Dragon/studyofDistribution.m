clc; clear; close all;

num_alg = 4;
hmgames = 20;
winnersPloty = zeros(5,num_alg);
finalTurnsPloty = zeros(100,num_alg);
for alg = 1:num_alg
    winners = zeros(hmgames,1);
    finalTurns = zeros(hmgames,1);

    for game = 1:hmgames
        [winner,finalTurn] = mainfunction(alg-1);
        winners(game) = winner;
        finalTurns(game) = finalTurn;
        
        if any(game == hmgames/10*(1:10)-1)
            fprintf(['Simulation ' num2str(game) ' completed.\n']);
        end
    end

    [~,winnersPosition] = unique(winners);
    winnersPlotx = [-1 1:4];
    for jwinner = 1:5
        winnersPloty(jwinner,alg) = sum(winnersPlotx(jwinner) == winners);
    end

    [~,finalTurnsPosition] = unique(finalTurns);
    finalTurnsPlotx = 1:100;
    for jfinalTurns = 1:100
        finalTurnsPloty(jfinalTurns,alg) = sum(finalTurnsPlotx(jfinalTurns) == finalTurns);
    end
    
    fprintf(['Algorithm ' num2str(alg) ' completed.\n']);
end

figure(1)
bar([categorical({'Time out', 'P1', 'P2', 'P3', 'P4'})'...
     categorical({'Time out', 'P1', 'P2', 'P3', 'P4'})'...
     categorical({'Time out', 'P1', 'P2', 'P3', 'P4'})'...
     categorical({'Time out', 'P1', 'P2', 'P3', 'P4'})'],...
     [winnersPloty(:,1) winnersPloty(:,2) winnersPloty(:,3) winnersPloty(:,4)],'grouped')
grid on
set(gca,'fontsize',18)
legend('All random', ...
       'Go higher', ...
       'Best route', 'Best route smart lava')

figure(2)
hold on
plot(finalTurnsPlotx,finalTurnsPloty(:,1),'b*-','linewidth',2)
plot(finalTurnsPlotx,finalTurnsPloty(:,2),'g*-','linewidth',2)
plot(finalTurnsPlotx,finalTurnsPloty(:,3),'r*-','linewidth',2)
plot(finalTurnsPlotx,finalTurnsPloty(:,4),'r*--','linewidth',2)
grid on
set(gca,'fontsize',18)
legend('All random', ...
       'Go higher', ...
       'Best route', 'Best route smart lava')