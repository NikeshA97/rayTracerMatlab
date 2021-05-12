function inShadow = isShadowV2(A,dL,o,type)
%0 true - its in the shadow, dont contribute light
%1 false - not in shadow, light contributes
inShadow = 1;
switch type
    case 'refr'; return;
end
[tminsph,sphi]=TestAllSpheresV2(A,dL,o);
if tminsph~=inf %this means it intersects object
    switch o.sph{sphi}.type
        case 'refr' %not in shadow if sphere is refractive
            inShadow = 1;
            return
        otherwise
    inShadow = 0; %it's in shadow
    return
    end
else
    [tmintri,~]=TestAllTrianglesV2(A,dL,o);
    if tmintri ~=inf
        inShadow = 0;
        return
%     else
%      [tminpla,~]=TestAllPlanes(A,dL,o);
%         if tminpla ~= inf
%             inShadow = 0;
%             return
%         end
    end
end

