function col = rayTracerV14(A,d,cdpth,o,v,InOut)
%A is screen pos
%d is direct vect from viewer to screen
%o are all objects
%sz,tz,lz are the number of...
%spheres, triangles and lights
%will be used to see which sph/tri was hit
% col=0;
while cdpth<v.mxdpth
spindx=0;
trindx=0;
%Test-intersection-for-spheres--------------------------------------------%    
    if o.NoS~=0
       [tminsph,spindx]=TestAllSpheresV2(A,d,o);
    else; tminsph=inf;
    end
%Test-intersection-for-triangles------------------------------------------%    
    if o.NoT~=0
       [tmintri,trindx]=TestAllTrianglesV2(A,d,o);
    else; tmintri=inf;
    end    
%What-the-ray-hit-first---------------------------------------------------%    
    if tminsph == inf && tmintri == inf
        tmin =inf; hit = 'nothing';
    elseif tminsph<tmintri
        %tmin of sph    %which sphere it hit
        tmin = tminsph; indx=spindx;
        hit = 'sphere';
    elseif tmintri<tminsph
        tmin = tmintri; indx=trindx;
        hit = 'triangle';
    end
%     if v.dbg == 1
%         disp(hit)
%         disp(InOut)
%     end
%-------------------------------------------------------------------------%
    switch hit
        case 'nothing'
             col = v.Ia*[0.6 0.8 1]*0.91^(d(2)*10);
             %a small trick to get a gradient like effect for the sky
% col = [0.6 0.8 1]*v.Ia;
            return
        otherwise
            col = illuminationModel_V7(A,d,hit,tmin,indx,o,v,cdpth,InOut);
            return
    end
%-------------------------------------------------------------------------%
end
%ray has reached max depth
col = [0 1 0];