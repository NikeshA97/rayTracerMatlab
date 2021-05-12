clear; clc; %close all;
%----------------------------------------------%
%----------INPUT-------------------------------%
%----------------------------------------------%
P=[6 7 -10]; %Observer
pixx = 256; pixy = 256; %pixx =10; pixy=10;
m =  2; %multiplier
% m =10;
pixx = pixx*m; %# pixels x direction 
pixy = pixy*m; %# pixels y direction
% x1=0; x2=1; y1=0; y2=1; %base screen size
%screen size adjusted to ratio
% x1=x1*pixx/m; x2=x2*pixx/m; y1=y1*pixy/m; y2=y2*pixy/m;
x1=0; x2=12; y1=0; y2=12; 
v.mxdpth = 100; %max depth for recursion
InOut = 0;%the intial ray is set outside
disablewaitbar=0;% 0 to disable, - anything else to disable-----%
disablechksph = 1; %if annoying then disable it
%texturemap testing
%texmap1 = (cell2mat(...
    %struct2cell(...
    %load('testtexmap1.mat'))));
%resize texmap
%texmap1 = imread('watertex.jpg');
% texmap1 = imread('woodtex2.jpg');
% sizetexmap = size(texmap1);
% multi = 1000./sizetexmap;
% newtexmap1 = zeros(1000,1000,3);
% for ii = 1:1000
%     for jj = 1:1000
%         newtexmap1(ii,jj,:) = texmap1(ceil(ii/multi(1)),ceil(jj/multi(2)),:);
%     end
% end
% % v.texmap = circshift(newtexmap1,[0 500]);
% v.texmap = circshift(newtexmap1./255, 250, 1);


%----------------------------------------------%
%----------OBJECTS-----------------------------%
%----------------------------------------------%
%For input help: help objInputs 
%will give an error if not enough or too many inputs

%OBJECT:--SPHERES------------------------------%
%[ [l m n r], [r g b], [spc], [ks] [kt, RI],  [n] [amb] [kd] [type] ];
%----------------------------------------------%
S = [
%     {[6 5 3.1 3], [0 0 0], [.5], [.3], [.9 .95], [50], [0.1], [0.7], ['both'] };
%     {[11 3.1 9 3], [0 0 0], [.8], [1], [1 1], [500], [0.4], [0.7], ['refl'] };
%     {[12 3.1 9 3], [1 0 1], [1], [.8], [1 1], [32], [0.4], [0.7], ['opq'] };
%     {[5 5 9 3], [.8 .5 1], [1], [.8], [1 1], [512], [0.4], [0.7], ['opq'] };
%     {[7 13 9 4], [.8 .5 1], [1], [.8], [1 1], [256], [0.4], [0.7], ['opq'] };
%     {[5 5 9 3], [1 0 1], [1], [1], [1 1], [32], [1], [1], ['opq'] };
    
{[6 3 4 2], [1 0 1], [0], [.8], [1 1], [500], [0.4], [0.7],  ['opq'] };
{[6 10 4 3], [0 0 0], [1], [.8], [1 1], [500], [0.4], [0.7], ['refl'] }
    ];

%View of spheres
screenxy = [x1,y1,x2,y2];
if disablechksph == 0
    plotsomething(S,screenxy);
    h = questdlg('Do you wish to continue ?','RunTracer');
    switch h
        case 'No' %close all; 
            return; 
        case 'Cancel' %close all; 
            return; 
        otherwise %close all;
    end
    close 'Sphere Views';
end

%OBJECT:--TRIANGLES----------------------------%
%[ [A], [B], [C],...            
% [r g b], [spc], [n] [amb] [kd] ] ;
%----------------------------------------------%
T = [
        triObjCreationAreaV2();
        
        ];
%OBJECT:--LIGHTS-------------------------------%
L = [
    [-2e3,  2e3, -2e3 .9];


%     [-2e2,  2e2, -2e2 1];
%     [-2e2,  2e2, 2e2 1];
    [2e1,  2e1, -1e1 .5];
%     [.9e1,  .8e1, .2e1 1];
%     [.6e1,  8e1, .5e1 1];
%       [-12,  12, 2, .5];
            
    ];
%Creates them----------------------------------%
%o stores all the objects
o = createObjV4(S,T,L);

%v - other variables stores anything thats not objects 
v.P = P; %observer point
v.Ia = .7; %ambient intensity
%Code that initialises screen vectors----------%
xx=linspace(x1,x2,pixx+1);
cx = (xx(2)-xx(1))/2;
L=length(xx);
xx=xx+cx*ones(1,L);

yy=linspace(y1,y2,pixy+1);
cy = (yy(2)-yy(1))/2;
H=length(yy);
yy=yy+cx*ones(1,H);

[X,Y] = meshgrid(xx,yy);
C=zeros(H-1,L-1,3);
%----------------------------------------------%
%A waitbar-------------------------------------%
%ignore this-has nothing to do with raytracer--%
if disablewaitbar==0
p = 0.1; %percentile
per = round(p*H);
str0 ={'Please wait...'};
str1 ={'50% complete'};
str2 ={'Nearly there!'};
str3 ={'Keep waiting...'};
w = waitbar(0,str0);
end
%----------------------------------------------%
%Code that returns a colour matrix-------------%
v.dbg = 0; %set to 0 disable, debug purpose only
tic;%for timing
for i=1:H-1 %itterate over all pixels
    for j=1:L-1
        
        A = [X(1,j),Y(i,1),0];
        %Norm dirVect:Obs-->Screen
        d = NormVect(P,A);
        
        %will be used in illum model
        v.d0 = d; 
        v.A0 = A;
        
        %debug purpose only
        if v.dbg == 1
            if j == 31 && i == 33 %[x,y]
                v.dbg=0;
                keyboard
            end
        end
  
        %the main recursive function
        C(i,j,:) = rayTracerV14(A,d,0,o,v,InOut);
    end
    
    %A waitbar
    if disablewaitbar==0
        if i == per
            p=p+0.1;
            per=round(p*H);
            if p==0.6
                waitbar((i+1)/H,w,str1);
            elseif abs(p-1)<1e-12
                waitbar((i+1)/H,w,str2)
            elseif p>0.6
                waitbar((i+1)/H,w,str3);
            else
                waitbar((i+1)/H,w,str0);
            end
        end
    end
    %---------------
end

if disablewaitbar == 0
waitbar(1,w)
close(w);
end
toc%end time

%----------------------------------------------%
%if gamma correction - put in two inputs%------%
%createImage(C,f,n) for gamma correction---------%
createImage(C,3);
% C(:,:,1)=(C(:,:,1)/amp).^(1/n);--------------%
%----------------------------------------------%
[D, E] = msaaV2(C,4);
% [F, G] = msaaV2(C,8);