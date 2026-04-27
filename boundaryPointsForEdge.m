function [xEdge, yEdge] = boundaryPointsForEdge(geom, eid)
    npts = 50;
    try
        pts = evaluate(geom,'Edge',eid,linspace(0,1,npts));
        xEdge = pts(1,:); yEdge = pts(2,:);
    catch
        nodes = geom.Edges(eid).Nodes;
        coords = geom.Nodes(:,nodes);
        xEdge = linspace(coords(1,1),coords(1,2),npts);
        yEdge = linspace(coords(2,1),coords(2,2),npts);
    end
end