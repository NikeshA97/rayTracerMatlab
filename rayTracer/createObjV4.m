function o = createObjV4(S,T,L)

o=struct;

%for spheres
%can add more properties
%properties so far
%.PosR - Position and radius
%.Col - Object diffusive
%.spc - Specular constant for sphere
%.glos - glossiness of sphere
%.amb - objects ambient refelction

if isempty(S)==0
    o.NoS=length(S(:,1));
    for i=1:o.NoS
        o.sph{i}.PosR = S{i,1};
        o.sph{i}.Col = S{i,2};
        o.sph{i}.spc = S{i,3};
        o.sph{i}.ks= S{i,4};
        o.sph{i}.kt = S{i,5};
        o.sph{i}.glos = S{i,6};
        o.sph{i}.amb = S{i,7};
        o.sph{i}.kd = S{i,8};
        o.sph{i}.type = S{i,9};
    end
else
    o.NoS=0;
end


%for triangles
if isempty(T)==0
    o.NoT=length(T(:,1));
    for i =1:o.NoT
          o.tri{i}.vertex = T(i,1:9);
          o.tri{i}.Col = T(i,10:12);
          o.tri{i}.spc = T(i,13);
          o.tri{i}.glos = T(i,14);
          o.tri{i}.amb = T(i,15);
          o.tri{i}.kd = T(i,16);
          o.tri{i}.ks = T(i,17);
          o.tri{i}.kt = T(i,18:19);
          o.tri{i}.type = T(i,20);
    end
else
    o.NoT=0;
end

%for lights
if isempty(L)==0
    o.NoL=length(L(:,1));
    for i=1:o.NoL
        o.lit{i}.Position = L(i,1:3);
        o.lit{i}.Int = L(i,4);
        %o.lit{i}.Col = aObj(i,5:7);
    end
else
    o.NoL=0;
end
