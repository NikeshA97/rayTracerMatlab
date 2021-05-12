function t = rayTriIntTestV1(A,d,T)
v0 = T(1:3);
v1 = T(4:6);
v2 = T(7:9);
e1 = v1-v0;
e2 = v2-v0;


% s1 = cross(d,e2);
      s1 = [d(2)*e2(3)-d(3)*e2(2),...
      d(3)*e2(1)-d(1)*e2(3),...
      d(1)*e2(2)-d(2)*e2(1)];


div = (sum(s1.*e1));
%if div == 0
% if div < 0  %triangle is backfacing
%     t = inf;
%     return
% end



dd = A-v0;
indiv = 1/div;
b1 = sum(dd.*s1)*indiv;
if b1<eps || b1 >1 
    t = inf;
    return
end
% s2 = cross(dd,e1);

s2 = [dd(2)*e1(3)-dd(3)*e1(2),...
      dd(3)*e1(1)-dd(1)*e1(3),...
      dd(1)*e1(2)-dd(2)*e1(1)];

b2 = sum(d.*s2)*indiv;
if b2 < eps || b1 + b2 > 1 + eps
    t = inf;
    return
end
t = sum(e2.*s2)*indiv;