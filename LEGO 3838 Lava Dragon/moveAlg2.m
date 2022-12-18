function [playerPick, parentsHistory] = moveAlg2(board,playerIIfrom,playerJJfrom,player)
% this algorithm search for the best route and follows it

winningPositions = [4 4; 4 7; 7 4; 7 7];
maxIteration = 3e2; % to avoid the situation where all routes are blocked

t = tree([playerIIfrom playerJJfrom]); % root of the tree
firstmoveAround = findpossibleMoves(playerIIfrom,playerJJfrom,board,player);

treeFlag = 0;
treeIndex = 1;
while ~treeFlag
    try
        iijj = t.get(treeIndex);
    catch % player blocked by lava
        finaliijj = [playerIIfrom,playerJJfrom]; % stays still
        playerPick = find(all(finaliijj == firstmoveAround,2));
        treeFlag = 1;
    end
    ii = iijj(1); jj = iijj(2);
    moveAround = findpossibleMoves(ii,jj,board,player);
    
    if any(all([ii jj] == winningPositions,2))
        parentsHistory = findparentsHistory(t,treeIndex);
        finaliijj = parentsHistory(length(parentsHistory)-1,:);
        playerPick = find(all(finaliijj == firstmoveAround,2));
        treeFlag = 1;
    end
    
    try
        parentsHistory = findparentsHistory(t,treeIndex);
    catch % player blocked by lava
        parentsHistory = [playerIIfrom,playerJJfrom];
        finaliijj = [playerIIfrom,playerJJfrom]; % stays still
        playerPick = find(all(finaliijj == firstmoveAround,2));
        treeFlag = 1;
    end
    for move = 1:size(moveAround,1)
        if ~any(all(moveAround(move,:) == parentsHistory,2))
            try
                t = t.addnode(treeIndex,moveAround(move,:));
            catch % player blocked by lava
                parentsHistory = [playerIIfrom,playerJJfrom];
                finaliijj = [playerIIfrom,playerJJfrom]; % stays still
                playerPick = find(all(finaliijj == firstmoveAround,2));
                treeFlag = 1;
            end
        end
    end
    
    treeIndex = treeIndex + 1;
    
    if treeIndex >= maxIteration % final spots blocked by lava
        parentsHistory = findparentsHistory(t,treeIndex);
        finaliijj = [playerIIfrom,playerJJfrom];
        playerPick = find(all(finaliijj == firstmoveAround,2));
        treeFlag = 1;
    end
end

% remember to set the case in which there in no other legal move but to
% stay where you are
% it may bug if there are no clear routes to the win !