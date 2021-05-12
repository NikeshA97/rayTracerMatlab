function [PoI, dr, dn] = nextRayTri(A,d,t,T)
%PoI is point of intersection
%dr is reflected vector
%dn is normal to surface

e1 = T(4:6) - T(1:3);
e2 = T(7:9) - T(1:3);
% if sum(e1) == 6

% end
eps = 1e-12;
PoI = A + d*t;

dn = NormVect(cross(e1,e2));

di = NormVect(d);

PoI = PoI+dn*eps;
dr = di-(2*sum(dn.*di))*dn;
