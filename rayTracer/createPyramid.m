function pyra = createPyramid(w,h,d,shift,scalar,theta,col,spc)
%w - width of base
%h - height of point on pyramid
%d - depth of  base

h = h*scalar;
w = w*scalar;
d = d*scalar;

%points on a unit 4 sided pyramid

pyr = [
        0  0    0  1;%a
        w  0    0  1;%b
        w  0    d  1;%c
        0  0    d  1;%d
      w/2  h  d/2  1;%e
      ];
  
%put the centre of the cube at origin
pyr(:,1:3) = pyr(:,1:3) - [w/2 h/2 d/2].*ones(5,1);

%pyramid rotation

%z axis roation matrix (roll)
cz = cos(theta(3));
sz = sin(theta(3));
Rz =[cz -sz 0 0;
     sz  cz 0 0;
     0   0  1 0;
     0   0  0 1];
%x axis rotation matrix (pitch)
cx = cos(theta(1));
sx = sin(theta(1)); 
Rx =[1 0   0  0;
     0 cx -sx 0;
     0 sx  cx 0;
     0 0   0  1];

%y axis rotation matrix (yaw)
cy = cos(theta(2));
sy = sin(theta(2)); 
Ry =[ cy 0 sy 0;
      0  1 0  0;
     -sy 0 cy 0;
      0  0 0  1];
  
%yaw pitch roll matrix
R = Rz*Ry*Rx;

%calculate new co-ords
pyr = pyr*R;

%remove the ones from the end
pyr(:,end) = [];

%x,y,z shift co-ords
pyr = pyr + shift.*ones(5,1);

%add the popertiers for the all the pyramid triangles
%some values are default / some are changeable

%create the matrix to store triangles
pyra = zeros(6,17);

%assign the co-ords
a = pyr(1,:); b = pyr(2,:); 
c = pyr(3,:); d = pyr(4,:);
e = pyr(5,:);


%bottom face
pyra(1,:) =...
    [[d], [a], [c],...
    [col], [spc], [1e4], [0.8], [0.4], [1] ];
pyra(2,:) =...
    [[b], [c], [a],...
    [col], [spc], [1e4], [0.8], [0.4], [1] ];

%front face
pyra(3,:) =...
    [[a], [e], [b],...
    [col], [spc], [1e4], [0.8], [0.4], [1] ];

%right face
pyra(4,:) =...
    [[b], [e], [c],...
    [col], [spc], [1e4], [0.8], [0.4], [1] ];

%back face
pyra(5,:) =...
    [[c], [e], [d],...
    [col], [spc], [1e4], [0.8], [0.4], [1] ];

%right face
pyra(5,:) =...
    [[d], [e], [a],...
    [col], [spc], [1e4], [0.8], [0.4], [1] ];