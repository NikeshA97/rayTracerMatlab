function f = plotsomething(S,spos)
%set of spheres
x1= spos(1); x2 = spos(3);
y1 = spos(2); y2 = spos(4);
s = size((S),1);
f = cell(s,2,3);
for i = 1:s
%for the top view
[xtop ,ytop] = circle(S{i}(1),S{i}(3),S{i}(4));
f{i,1,1} = xtop;
f{i,2,1} = ytop;
%front view
[xfront ,yfront] = circle(S{i}(1),S{i}(2),S{i}(4));
f{i,1,2} = xfront;
f{i,2,2} = yfront;
%side view
[xside ,yside] = circle(S{i}(3),S{i}(2),S{i}(4));
f{i,1,3} = xside;
f{i,2,3} = yside;
end
%% Type of shape
% Red - Reflective
% Blue - Transmissive
% Green - Both
% Black - Opaque
%plot it
figure('Name','Sphere Views','NumberTitle','off')
%% Top View
s1 = subplot(2,2,1);
str = cell(1,s);
hold on
title('Top View')
axis equal
for j = 1:s
    col = pickcol(S{j,end});
    plot(f{j,1,1},f{j,2,1},'Color',col);
    str{j} = S{j,end};
end
legend(s1,str);
hold off
%% Front View
s2 = subplot(2,2,[3 4]);
hold on
title('Front View')
axis equal
for k = 1:s
    col = pickcol(S{k,end});
    plot(f{k,1,2},f{k,2,2},'Color',col);
    str{k} = S{k,end};
end
plot([x1,x2,x2,x1,x1],[y1,y1,y2,y2,y1],'LineStyle','-','Color',[0 0 0]);
legend(s2,str,'Screen');
hold off
%% Side View
s3 = subplot(2,2,2);
hold on
title('Side View')
axis equal
for m = 1:s
    col = pickcol(S{m,end});
    plot(f{m,1,3},f{m,2,3},'Color',col);
    str{m} = S{m,end};
end
plot([0 0],[0 max(max(f{:,2,3}))],'LineStyle','-','Color',[0 0 0]);
legend(s3,str);
hold off
end

function col = pickcol(type)
    switch type
        case 'refl'; col = [1 0 0];
        case 'refr'; col = [0 0 1];
        case 'both'; col = [0 1 0];
        case 'opq';  col = [0 0 0];
    end
end