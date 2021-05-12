function dn = NormVect(A,B)
    if nargin == 2
        d = B-A;
        dn = d/norm(d);
    else
        dn = A/norm(A);
    end
end