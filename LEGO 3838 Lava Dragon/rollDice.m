function [dice,lavaMove,playerMoves,players] = rollDice(dice,players,playerMoving,talk)

% roll the dice
face = ceil(rand()*6);

% check if there is a lava movement
if dice(face,1) == -1
    lavaMove = true;
    if talk
        fprintf('Lava!\n')
    end
else
    lavaMove = false;
end

% add the player movement square
if players(playerMoving).movementSquares > 0 && ...
        any(dice(face,:) == 0)
    tochange = find(dice(face,:) == 0,1);
    dice(face,tochange) = playerMoving;
    players(playerMoving).movementSquares = players(playerMoving).movementSquares - 1;
end

% update the moving players
playerMoves = sum(dice(face,:) == (1:4)',2);

for player = [playerMoving:4 1:playerMoving-1]
    if playerMoves(player) > 0 && talk
        fprintf(['Player ' num2str(player) ' moves ' num2str(playerMoves(player)) ' times.\n'])
    end
end

