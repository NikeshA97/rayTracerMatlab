function mirror = createMirror(w,h,bz,shift,scalar,theta,brdc)
%brdc - border color
%bz - border size
mirror = createPlaneV2(w,h,shift,scalar,theta,[0 0 0], 0, 1, 1 , .95 , 2);
if bz <=0
    return
end

e1 = mirror(1,4:6) - mirror(1,1:3);
e2 = mirror(1,7:9) - mirror(1,1:3);
n  = cross(e1,e2);
eps = 1e-12;
border = createPlaneV2(w+bz,h+bz,shift-n*eps,scalar,theta,[brdc],1 , .3, .9 , .95 , 1);

mirror = [mirror;border];
