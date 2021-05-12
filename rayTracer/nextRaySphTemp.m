function [PointIn,PointOut,dreflection,drefraction,dn] = nextRaySphTemp(A,d,t,S,InOut)
% A - starting pos
% d - direct vect
% t - intersect t point#
% S - sphere
% InOut - is the ray inside or outside
% Output;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PointIn - Point inside the sphere
%PointOut - Point outside the sphere
%dreflection - reflection vector
%drefraction - refraction vector
%N - normal vector

eps = 1e-12;
PoI = A+d*t; %the point where the ray intersects the sphere
di = NormVect(d); %normalised incoming ray
dn = (PoI - S(1,1:3))/S(4); %always points outwards of sphere

PointIn = PoI - dn*eps; %point inside the sphere
PointOut = PoI + dn*eps; %point outside the sphere


if InOut == 1 %if ray inside
   dn = -dn; %switch direction of normal
end
dreflection = di - di-(2*sum(dn.*di))*dn; %reflection

mu = 1/1.52; %from air to glass
if InOut == 1
   mu = 1.52/1; %if ray inside switch the ratio
end
d=-d;
Nd = sum(dn.*(d));
sq = 1 - (mu^2)*(1-(sum(dn.*(d)))^2);
if sq<0
    drefraction = dreflection;
    return
else
    sq = sqrt(sq);
end
drefraction = mu*Nd - sq.*dn - mu.*(d);


