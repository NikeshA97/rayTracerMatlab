function [PoI,dr,dn] = nextRaySph(A,d,t,S)
% A - starting pos
% d - direct vect
% t - intersect t point#
% S - sphere
% Output;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PoI, where it intersects next
% dr - unit reflect vector
% N - nomral to the point of contact

eps = 1e-12;

di = NormVect(d);
PoI = A + d*t;
%N = PoI - S(1,1:3);
%dn = NormVect(N);
dn = (PoI - S(1,1:3))/S(4);
PoI = PoI+dn*eps;

dr = di-(2*sum(dn.*di))*dn;
end