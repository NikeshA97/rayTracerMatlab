function [tmin,pli] = TestAllPlanes(A,d,o)
pli=0;
tmin = inf;
    for i = 1:o.NoPL
        t = rayPlaIntTestV1(A,d,o.pla{i}.vertex);
        if t<tmin && t>0
            tmin = t;
            pli = i;
        end
    end