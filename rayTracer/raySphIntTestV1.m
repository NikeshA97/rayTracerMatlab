function t = raySphIntTestV1(A,d,S)
A=A-S(1:3);

%a=sum(d.*d);
%a=dot(d,d);
a=norm(d)^2;

%b=sum(d.*(A-S(1:3)))*2;
b=sum(d.*A)*2;

% c = sum(S(1:3).^2) +...
%     sum(A.^2) - ...
%     2*sum(S(1:3).*A) - ...
%     S(4)^2;
c=sum(A.^2) - S(4)^2;

    dtr = b^2 - 4*a*c;
    if dtr >= 0
        t1 = (-b-sqrt(dtr))/(2*a);
        t2 = (-b+sqrt(dtr))/(2*a);
         if t1>0
             t = t1;
         elseif t2>0
             t = t2;
         else
             t = t1;
         end
    else
        t = inf;
    end
end
