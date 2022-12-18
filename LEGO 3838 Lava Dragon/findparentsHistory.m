function parentsHistory = findparentsHistory(t,treeIndex)

parentsHistory(1,1:2) = t.get(treeIndex);

parentIndex = 2;
while treeIndex > 1
    parentsHistory(parentIndex,:) = t.get(t.Parent(treeIndex));
    
    treeIndex = t.Parent(treeIndex);
    
    parentIndex = parentIndex + 1;
end