function[tmin, tri] = TestAllTrianglesV3(A,d,o)
tmin = inf;
NoT = o.NoT;
T = zeros(NoT,3,3);
for i = 1:NoT
    T(i,1,:) = (o.tri{i}.vertex(1:3));
    T(i,2,:) = (o.tri{i}.vertex(4:6));
    T(i,3,:) = (o.tri{i}.vertex(7:9));
end    
%e1 = B - A
e1 = T(:,2,:) - T(:,1,:);

%e2 = C - A
e2 = T(:,3,:) - T(:,1,:);

sd = zeros(NoT,1,3);
sd(:,1,1) = d(1); 
sd(:,1,2) = d(2); 
sd(:,1,3) = d(3);

s1 = cross(sd,e2,3);
div = dot(s1,e1,3);

Ad = zeros(NoT,1,3);
Ad(:,1,1) = A(1); 
Ad(:,1,2) = A(2); 
Ad(:,1,3) = A(3);

dd = Ad - T(:,1,:);

indiv = 1./div;

b1 = dot(dd,s1,3).*indiv;

s2 = cross(dd,e1,3);

b2 = dot(sd,s2,3).*indiv;
t = dot(e2,s2,3).*indiv;

test1 = (b1>0 & b1<1);
test2 = (b1+b2 <=1 & b2>0);
filter = (test1 & test2);
tf = t.*filter;
for i = 1:length(tf)
    if tf(i) == 0
        tf(i) = inf;
    end
end
tri = find(tf == min(tf) & tf~=inf,1 );
if isempty(tri) == 1
   tri =0;
    return
else
tmin = t(tri);
end
end