function plane = createPlaneV2(w,h,shift,scalar,theta,col,spc,ks,kt,RI,type)
%affine transformations are used
%restricted top facing plane - rectangle
%top face
%[0 1 0], [0 1 1], [1 1 0]
%[1 1 1], [1 1 0], [0 1 1]
h = h*scalar;
w = w*scalar;
%plane co-ords
pc = [ 0 0 0 1;
       0 0 h 1;
       w 0 0 1;
       w 0 h 1
      ];

%put the centre of rectangle at origin
pc(:,[1 3]) = pc(:,[1 3]) - ([w/2 h/2]'*ones(1,4))';

%plane rotation

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

%calculate the new co-ords
pc = pc*R;

%remove the ones from the end
pc(:,end) = [];

%x y z shift co-ords
pc = pc + (shift'*ones(1,4))';

%add in the rest of the properties for plane triangles
%some values are default / some are changeable

%create the matrix to store triangles
plane  = zeros(2,20);

%the triangles
%top face
plane(1,:) =...
    [[pc(1,:)], [pc(2,:)], [pc(3,:)],...
    [col], [spc], [1e4], [0.8], [0.4],...
    [ks], [kt], [RI], [type] ];
plane(2,:) =...
    [pc(4,:), [pc(3,:)], [pc(2,:)],...
    [col], [spc], [1e4], [0.8], [0.4],...
    [ks], [kt], [RI], [type] ];
  
