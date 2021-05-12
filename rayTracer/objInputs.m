%------------------------------------------------
% Sphere objects                                
%------------------------------------------------
% S = [                                         
%     { [l m n r], [r g b], [spc], [kt, RI], [n] [amb] [kd] [type] };        
%     {}...;                                     
%     ];                                        
%------------------------------------------------
% [l,m,n,r] - sphere with centre l,m,n radius r 
% [r, g, b] - objects diffusive colour (colour) 
% [spc]     - objects specular coefficient
% [kt]      - objects transmission coefficient
% [RI]      - objects Refractive index
% [n]       - specular exponent for gloss
% [amb]     - objects ambient reflection
% [kd]      - objects diffusive reflection
% [type]    - objects type
%------------------------------------------------
% spc is how reflective the surface will be
% kt - how transmissive the surface will be
% RI - index of refraction, 1 will make it completely transparent 
% n -  determines the specular highlight
% amb - how much ambient light the material reflects
% kd - diffusive reflection of the object material
% type - the object types are
% 'refl' - for reflective
% 'refr' - refractive
% 'both' - if it's both reflective and refractive
% 'opq' if the object is opaque
%------------------------------------------------
%
%------------------------------------------------
% Triangular objects
%------------------------------------------------
% T = [ 
%     [ [A], [B], [C], [r g b], [spc], [n] [amb] [kd] ] ;
%     []...;
%     ];
%------------------------------------------------
% [A], [B], [C] - Verticies of the tirangle
% [r, g, b] - objects diffusive colour (colour) 
% [spc]     - objects specular coefficent       
% [n]       - specular exponent for gloss
% [amb]     - objects ambient reflection
% [kd]      - objects diffusive reflection
%------------------------------------------------
%
%------------------------------------------------
% Light objects
%------------------------------------------------
% L = [ 
%     [ [x y z] ] ;
%     []...;
%     ];
%------------------------------------------------
% [x y z] - position of lights
%------------------------------------------------




