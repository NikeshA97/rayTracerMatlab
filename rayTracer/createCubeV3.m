function cube = createCubeV3(w,h,d,shift,scalar,theta,col,spc,ks,kt,RI,type)

%although it's called createCubeV3, it can create cuboid as well
%w d h - x y z respectively
h = h*scalar;
w = w*scalar;
d = d*scalar;

%co-ords on a cube
cc =[...
    0 0 0 1;%a
    w h 0 1;%b
    0 h 0 1;%c
    w 0 0 1;%d
    w 0 d 1;%e
    0 h d 1;%f
    w h d 1;%g
    0 0 d 1;%h
    ];
%put the centre of the cube at origin
cc(:,1:3) = cc(:,1:3) - [w/2 h/2 d/2].*ones(8,1);

%cube rotation

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
  
%Translation
T = [ 1 0 0 shift(1);
      0 1 0 shift(2);
      0 0 1 shift(3);
      0 0 0 1];
  
%yaw pitch roll matrix
R = Rz*Ry*Rx;


%calculate new co-ords for rotation
cc = cc*R;

%remove the ones from the end
cc(:,end) = [];

%x,y,z shift co-ords
cc = cc + shift.*ones(8,1);

%add the popertiers for the all the cube triangles
%some values are default / some are changeable

%create the matrix to store triangles
cube = zeros(12,20);

%assign the cube co-ords
a = cc(1,:); b = cc(2,:); c = cc(3,:); d = cc(4,:);
e = cc(5,:); f = cc(6,:); g = cc(7,:); h = cc(8,:);

%the set of triangles which make up the cube

%front face
cube(1,:) =...
    [[a], [c], [d],...
    [col], [spc], [1e4], [0.8], [0.4],...
    [ks], [kt], [RI], [type] ];
cube(2,:) =...
    [[b], [d], [c],...
    [col], [spc], [1e4], [0.8], [0.4],...
    [ks], [kt], [RI], [type] ];

%back face
cube(3,:) =...
    [[e], [g], [h],...
    [col], [spc], [1e4], [0.8], [0.4],...
    [ks], [kt], [RI], [type] ];
cube(4,:) =...
    [[f], [h], [g],...
    [col], [spc], [1e4], [0.8], [0.4],...
    [ks], [kt], [RI], [type] ];

%right face
cube(5,:) =...
    [[d], [b], [e],...
    [col], [spc], [1e4], [0.8], [0.4],...
    [ks], [kt], [RI], [type] ];
cube(6,:) =...
    [[g], [e], [b],...
    [col], [spc], [1e4], [0.8], [0.4],...
    [ks], [kt], [RI], [type] ];

%left face
cube(7,:) =...
    [[h], [f], [a],...
    [col], [spc], [1e4], [0.8], [0.4],...
    [ks], [kt], [RI], [type] ];
cube(8,:) =...
    [[c], [a], [f],...
    [col], [spc], [1e4], [0.8], [0.4],...
    [ks], [kt], [RI], [type] ];

%top face
cube(9,:) =...
    [[c], [f], [b],...
    [col], [spc], [1e4], [0.8], [0.4],...
    [ks], [kt], [RI], [type] ];
cube(10,:) =...
    [[g], [b], [f],...
    [col], [spc], [1e4], [0.8], [0.4],...
    [ks], [kt], [RI], [type] ];

%bottom face
cube(11,:) =...
    [[h], [a], [e],...
    [col], [spc], [1e4], [0.8], [0.4],...
    [ks], [kt], [RI], [type] ];
cube(12,:) =...
    [[d], [e], [a],...
    [col], [spc], [1e4], [0.8], [0.4],...
    [ks], [kt], [RI], [type] ];
