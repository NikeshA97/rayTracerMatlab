function T = triObjCreationArea()
T = [
    %the floor triangle
        [[-1e4 0 -1e4], [0 0 1e4], [1e4 0 -1e4],...
        [1 0 0], [0.001], [1e4], [0.8], [0.4], [0] ];
        %[1 0 0], [0], [1e4], [0.5], [0.1], [0] ];
    %
    %will show - FF
    %       [[2 1 8], [4 5 8], [6 1 8],...
    %       [1 0 0], [1], [100], [0.8], [0.4], [1] ];
    %wont show - BF
    %       [[2 1 8], [6 1 8], [4 5 8],...
    %       [1 0 0], [1], [100], [0.8], [0.4], [1] ];
    
%     
%     [ [2 2 2], [6 8 2], [10 2 2],...
%     [1 0 0], [0], [1e4], [0.8], [0.4], [0] ];
    
    createCubeV3(2,2,2,[6 2 4],1,[pi/4 pi/4 pi/2],...
    [1 0 1],0);
%     
%     createCubeV3(2,2,4,[1 4 2],1,[0 0 0],...
%     [.3 .7 1],0);
%     
%     createCubeV3(8,2,2,[10.5 5 3],1,[0 pi/4 pi/2],...
%     [0 1 0],0);

    createMirror(8,8,.5,[6 0.1 3],1,[0 0 0],[.5 .5 .5])%botmir
    
%     createMirror(10,10,.5,[12 12 6],1,[3*pi/4 0 -pi/4],[0 0 1])
%     createMirror(10,10,.5,[-3 7 10],1,[0 -pi/4 pi/2],[0 0 0])
%     createMirror(15,10,.5,[17 7 -3],1,[0 -pi/4 -pi/2],[0 1 0])
      

%        createPlaneV2(20,20,[15 0 6],1,[0 0 -pi/2],...
%     [0 0 0],0);
        
      %two mirrors facing eachother
%       createMirror(20,10,.5,[6 6 9.5],1,[pi/2 0 0],[0 0 1])
%       createMirror(20,10,.5,[6 5.5 -10],1,[-pi/2 0 0],[1 1 1])
     

     % 4 mirrors in square
%      createMirror(10,10,1,[2 6 4.5],1,[pi/2 0 pi/4],[0 0 1])
%      createMirror(10,10,1,[10 6 4.5],1,[pi/2 0 -pi/4],[0 1 1])
%      createMirror(10,10,1,[10 6 -3.5],1,[pi/2 0 (pi/4 + pi)],[0 1 0])
%      createMirror(10,10,1,[2 6 -3.5],1,[pi/2 0 (-pi/4 + pi)],[1 0 1])

%        createPlaneV2(6,6,[6 6 3],1,[pi/2 0 0],...
%        [1 .5 1],0);
       
%        createMirror(4,4,2,[6 6 3],1,[pi/2 0 0],[1 0 1])
%        createPlaneV2(6,6,[3 6 0],1,[pi/2 0 pi/2],...
%        [1 .5 1],0);

%        createPlaneV2(6,6,[9 6 0],1,[pi/2 0 -pi/2],...
%        [1 .5 1],0);


%         createCubeV3(2,2,2,[6 6 4],2,[pi/4 pi/4 pi/2],...
%         [1 0 1],0);
        
        createPyramid(2,2,2,[6 8 4],2,[0 pi/4 0],...
        [.85 .3 .1],0);
        
%         createCubeV3(2,2,2,[6 4 4],2,[0 pi/4 0],...
%         [0 1 0],0);

     ];