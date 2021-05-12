function [PoI , dr, dn] = nextRayPla(A,d,t,PL)
%PoI is point of intersection
%dr is reflected vector
%dn is normal to surface

e1 = PL(4:6) - PL(1:3);
e2 = PL(7:9) - PL(1:3);
% if sum(e1) == 6
%     keyboard 
% end
eps = 1e-6;
PoI = A + d*t;

dn = NormVect(cross(e1,e2));

di = NormVect(d);

PoI = PoI+dn*eps;
dr = di-(2*sum(dn.*di))*dn;