function col = rayTracerV13(A,d,cdpth,mxdpth,o)
%A is screen pos
%d is direct vect from viewer to screen
%o are all objects
%sz,tz,lz are the number of...
%spheres, triangles and lights
%will be used to see which sph/tri was hit
% col=0;
while cdpth<mxdpth
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
%Test-intersection-for-planes---------------------------------------------%    
    %if o.NoPL~=0
     %  [tminpla,plindx]=TestAllPlanes(A,d,o);
    %else; tminpla=inf;
    %end    
%What-the-ray-hit-first---------------------------------------------------%    
    if tminsph == inf && tmintri == inf %&& tminpla ==inf
        tmin =inf; hit = 'nothing';
    elseif tminsph<tmintri %&& tminsph<tminpla
        %tmin of sph    %which sphere it hit
        tmin = tminsph; indx=spindx;
        hit = 'sphere';
    elseif tmintri<tminsph %&& tmintri<tminpla
        tmin = tmintri; indx=trindx;
        hit = 'triangle';
    %else
        %tmin = tminpla; indx=plindx;
        %hit = 'plane';
    end
%-------------------------------------------------------------------------%
    switch hit
        case 'nothing'
             col = 0.8*[0.6 0.8 1]*0.91^(d(2)*10);
%col = [0.6 0.8 1];
            return
        otherwise
            col = illuminationModel_V5(A,d,hit,tmin,indx,o,cdpth,mxdpth);
            return
    end
%-------------------------------------------------------------------------%
end
%ray has reached max depth
col = [0 1 0];