function col = illuminationModel_V6(A,d,hit,tmin,indx,o,v,cdpth,InOut)
%The inputs
% A - point of intersection
% d - ray direction
% hit - what ray hit
% tmin - the t in A + td
% indx - which specific object it hit
% cdpth - current depth
% mxdpth - max depth
% InOut - is the ray inside or outside

%The model
% I = Ia*Ka*Od + ...
% sum[ Si*Fatt*Ip [ Kd*Od*(dot(N,L)) + Ks(dot(N,H)^n) ]  ] +
% Ks*Os*I <--- I is the recusrion
%Defintion of eveerything
% I    - intensity at the point(col) ( will be 1 for now )
% Ia   - intensity of ambient light const for all obj
% Ka   - ambiet light reflected from object surface (0 - 1)
% Ks   - object materials specular coeff (0 - 1)
% n    - specular exponent for object
% Od   - obejcets diffusive colour
% Si   - in shadow or not (0 or 1)
% Fatt - distance attentuation max(1,(c1+c2*d+c3*d^2)^-1)
% N    - normal to the surface
% L    - direction to the light source
% H    - halfway between viewer and lightsource

switch hit
    
    case 'sphere'
        otmp = o.sph{indx}; %assgins the intersected object to a new object
        [Ain,Aout,drfl,dref,dn] = nextRaySphV2(A,d,tmin,otmp.PosR,otmp.kt(2),InOut);
        
        %lighting model bit
        IaKaOd = v.Ia * otmp.amb * otmp.Col;
        SOAL = sumOverAllLights(Aout,dn,o,otmp,v);
        col = IaKaOd + SOAL;
        
        %the otmp.spc = 0.001 is a special case for the floor 
        if otmp.spc == 0.001                                                
            return
        end
        cdpth = cdpth + 1;
        
        switch otmp.type
            case 'opq'
                return %the ray stops
            case 'refl'
                col = col + ... %only reflect
                    otmp.ks*rayTracerV14(Aout,drfl,cdpth,o,v,0);
            case 'refr'
                if InOut == 0 %ray outside
                    col = col + ... %change ray to inside
                        otmp.kt(1)*rayTracerV14(Ain,dref,cdpth,o,v,~InOut);
                else
                    col = col + ...%create reflective(inside) and refractive ray
                        otmp.kt(1)*rayTracerV14(Aout,dref,cdpth,o,v,~InOut) +...
                        otmp.ks*rayTracerV14(Ain,drfl,cdpth,o,v,InOut);
                end
            case 'both'
                if InOut == 0 %ray outside
                    col = col + ... %create reflective And refractive ray 
                        otmp.ks*rayTracerV14(Aout,drfl,cdpth,o,v,0)+...
                        otmp.kt(1)*rayTracerV14(Ain,dref,cdpth,o,v,~InOut);
                else
                    col = col + ... %this is the ray inside, no inter object reflections
                        otmp.kt(1)*rayTracerV14(Aout,dref,cdpth,o,v,~InOut);
                end
        end
        return
        
    otherwise
        otmp = o.tri{indx};
        [A,d,dn] = nextRayTri(A,d,tmin,otmp.vertex);
        %temporary
        if mod(sum(round(A/1.5)),2) == 0 && otmp.spc == 0.001
            otmp.Col = [1 1 0];
        end
        %lighting model bit
        IaKaOd = v.Ia * otmp.amb * otmp.Col;
        SOAL = sumOverAllLights(A,dn,o,otmp,v);
        col = IaKaOd + SOAL;
        %the otmp.spc = 0.001 is temporary
        if otmp.spc == 0 || otmp.spc == 0.001
            return
        else
            cdpth = cdpth + 1;
            col = col + ...
                otmp.spc*rayTracerV14(A,d,cdpth,o,v,InOut);
            return
        end
end

end

function col =  sumOverAllLights(A,dn,o,otmp,v)
%function that computes the sum in the lighting model
% A point on the surface
% dn - normal to the surface
col = 0;
for i = 1:o.NoL
    dL = o.lit{i}.Position - A;%ith light 
    
    %WL=computeWarnLight(dL,o.lit{i}.Position);
    
    col = col +... 
    (o.lit{i}.Int*Fa(dL)*isShadowV2(A,dL,o,otmp.type))*...
      (otmp.kd * otmp.Col * computeLightV3(dL,dn) + ...
          otmp.spc  * ...
          computeLNHLightV1(dL,dn,v.d0,otmp.glos)); 
end
end

function LN = computeLightV3(L,N)
%L - from point to light source
%N - normal at the p oint
% Computes dot(N,L) from the phong model
LN = 0;
NL = sum((L/norm(L)).*N);
if NL > 0
   LN = NL;
end
end

function LNH = computeLNHLightV1(L,N,d0,n)
%L - from point to ligiht source
%N - normal at point
%d0 - from screen to first point of intersection
% gloss - specular exponent
%computes dot(N,H), H is the halfway
%from viewer to light source
LNH = 0;
L2 = (L-d0)./norm(L-d0);

NLH=sum(L2.*N);
if NLH>0
    LNH = NLH^n;
end
end

function Fatt = Fa(dL)
%function to calculate distance attenuation Fatt
%c1,c2,c3 are user picked constants (can only be changed here)
%disp(dL)
dL = norm(dL);
c1 = 0; c2=0.00006; c3=0;
a = 1/(c1 + c2*dL + c3*dL^2);
%clamped at 1 so there is some attenuation
Fatt = min(1,a);
% Fatt = 1;
end