function [xunit, yunit] = circle(x,y,r)
%found on the matlab forum
%then modified it a bit to take multiple values
% hold on
% axis equal
%for i = length(x)
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
% h = plot(xunit, yunit);
%end
% hold off