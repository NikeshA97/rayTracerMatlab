function [PointIn,PointOut,dreflection,drefraction,dn] = nextRaySphV2(A,d,t,S,iof,InOut)

eps = 1e-6;
PoI = A+d*t;
di = NormVect(d);
dn = (PoI - S(1,1:3))/S(4);

PointIn = PoI - dn*eps; %point inside the sphere
PointOut = PoI + dn*eps; %point outside the sphere

%InOut = 0;

if InOut == 1 %if ray inside
   dn = -dn; %switch direction of normal
end
dreflection =  di - (2*sum(dn.*di))*dn; %reflection

mu = 1/iof; %from air to glass
if InOut == 1
   mu = mu^-1; %if ray inside switch the ratio
end
d=-d;
Nd = sum(dn.*(d));
sq = 1 - (mu^2)*(1-Nd^2);
if sq<0
    drefraction = dreflection;
    return
else
    sq = sqrt(sq);
end
drefraction = (mu*Nd - sq).*dn - mu.*(d);
%drefraction = mu*Nd - sq.*dn - mu.*(d);