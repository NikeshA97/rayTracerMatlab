function col = illuminationModel_V5(A,d,hit,tmin,indx,o,cdpth,mxdpth)
%The inputs
% A - point of intersection
% d - ray direction
% hit - what ray hit
% tmin - the t in A + td
% indx - which specific object it hit
% cdpth - current depth
% mxdpth - max depth
%
%The model
% I = Ia*Ka*Od + ...
% sum[ Si*Fatt*Ip [ Kd*Od*(dot(N,L)) + Ks(dot(N,H)^n) ]    ] +
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
        [A,d,dn] = nextRaySph(A,d,tmin,otmp.PosR);
%     case 'plane'
%         otmp = o.pla{indx};
%         [A,d,dn] = nextRayPla(A,d,tmin,otmp.vertex);
%         
%         if mod(sum(round(A/5)),2) == 0 && otmp.spc == 0
%             otmp.Col = [1 1 0];
%         end    
        
    otherwise
        otmp = o.tri{indx};
        [A,d,dn] = nextRayTri(A,d,tmin,otmp.vertex);
        %temporary
        if mod(sum(round(A/5)),2) == 0 && otmp.spc == 0.001
            otmp.Col = [1 1 0];
        end
end
        %lighting model bit
        IaKaOd = o.Ia * otmp.amb * otmp.Col;
        SOAL = sumOverAllLights(A,dn,o,otmp);
        col = IaKaOd + SOAL;
        %the otmp.spc = 0.001 is temporary
        if otmp.spc == 0 || otmp.spc == 0.001
             return
        else
            cdpth = cdpth + 1;
           col = col + ...
                 otmp.spc*rayTracerV13(A,d,cdpth,mxdpth,o);
              return
        end
    
end

function col =  sumOverAllLights(A,dn,o,otmp)
%function that computes the sum in the lighting model
% A point on the surface
% dn - normal to the surface
col = 0;
for i = 1:o.NoL
    dL = o.lit{i}.Position - A;%ith light 
    
    %WL=computeWarnLight(dL,o.lit{i}.Position);
    
    col = col +... 
    (o.lit{i}.Int*1*isShadowV2(A,dL,o))*...
      (otmp.kd * otmp.Col * computeLightV3(dL,dn) + ...
          1 * otmp.tstvar * ...
          computeLNHLightV1(dL,dn,o.d0,otmp.glos)); 
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
%L = 0.5*(L-d0);
L = (L-d0)./norm(L-d0,2);

NLH=sum((L/norm(L)).*N);
if NLH>0
    LNH = NLH^n;
end
end

function Fatt = Fa(dL)
%function to calculate distance attenuation Fa
%c1,c2,c3 are user picked constants
%disp(dL)
c1 = 0; c2=0.00006; c3=0;
a = 1/(c1 + c2*dL + c3*dL^2);
%clamped at 1 so there is some attenuation
% Fatt = min(1,a);
Fatt = 1;
end

function WL = computeWarnLight(L,Lpos)
WL = 0;
%hL = NormVect(Lpos,[1.8e1, 1.8e1, -.8e1]);
hL = NormVect(Lpos,[.6e1,  8e1, .5e1]);
IL = 1;
p = 16;
LhL = sum(NormVect(-L).*hL);
if LhL > 0.9 && LhL <1
    disp(LhL);
    WL = IL*LhL^p;
end
end
