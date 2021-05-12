function [tmin ,tri] = TestAllTrianglesV2(A,d,o)
tri = 0;
tmin = inf;
    for i = 1:o.NoT
        t = rayTriIntTestV1(A,d,o.tri{i}.vertex);
        if t<tmin && t>0
            tmin = t;
            tri = i;
        end
    end
end