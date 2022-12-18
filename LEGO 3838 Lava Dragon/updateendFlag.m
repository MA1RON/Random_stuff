function endFlag = updateendFlag(players,board)

maxTurn = 100;
winningPositions = [4,4;4,7;7,4;7,7];

for player = 1:4
    if any(all(players(player).position == winningPositions,2))
        endFlag = player;
        return
    end
end

if board.t > maxTurn
    endFlag = -1;
else
    endFlag = 0;
end
    
