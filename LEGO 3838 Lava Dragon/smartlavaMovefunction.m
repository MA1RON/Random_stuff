function [lavaIIfrom,lavaJJfrom,lavaIIto,lavaJJto] = smartlavaMovefunction(board,playerMoving,players,alg)

lavaPick = ceil(rand()*12);
lavaPositions = find(board.e == 5);

lavaIIfrom = mod(lavaPositions(lavaPick),10);
if lavaIIfrom == 0
    lavaIIfrom = 10;
end

lavaJJfrom = ceil(lavaPositions(lavaPick)/10);

lavaFlag = false;
while ~lavaFlag
    if alg == 0
        lavaIIto = ceil(rand()*10); lavaJJto = ceil(rand()*10); % lava alg 0
    elseif alg == 1
        [lavaIIto, lavaJJto] = lavaAlg1(board,playerMoving,players); % laga alg 1
    end
    
    if ~board.e(lavaIIto,lavaJJto)
        lavaFlag = true;
    end
end