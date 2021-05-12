function [E F] =  msaaV2(C,px)
% C is the matrix of the image
% px is the gridsize that it averages
sz = size(C);
% D = zeros(sz(1)-px+1,sz(2)-px+1,3);
E = zeros(sz(1)-px+1,sz(2)-px+1,3);
F = zeros(sz(1)./px,sz(2)./px,3);
% tic
% for i = 1:sz(1)-px+1
%    for j = 1:sz(2)-px+1
%        D(i,j,:) = sum(sum(C(i:i+px-1,j:j+px-1,:)))/(px)^2;       
%    end
% end
% toc

% tic
for i = 1:px
    for j = 1:px
    E = E + C(i:end-px+i,j:end-px+j,:);
    end
end
E = E./(px^2);
% toc

a = 0;
b = 0;
for i = 1:px:sz(1)-px+1
    a = a+1;
    for j = 1:px:sz(2)-px+1
        b = b+1;
        F(a,b,:) = sum(sum(C(i:i+px-1,j:j+px-1,:)))./(px^2);      
    end
    b=0;
end


end