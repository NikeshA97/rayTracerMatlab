function [tmin,spi] = TestAllSpheresV2(A,d,o)
spi=0;
tmin = inf;
    for i = 1:o.NoS
        t = raySphIntTestV1(A,d,o.sph{i}.PosR);
        if t<tmin && t>0
            tmin = t;
            spi = i;
        end
    end