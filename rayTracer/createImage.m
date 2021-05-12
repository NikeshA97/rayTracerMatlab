function createImage(C,f,n)
if nargin == 3
    amp = max(max(max(C)));
    C(:,:,1)=(C(:,:,1)/amp).^(1/n);
    C(:,:,2)=(C(:,:,2)/amp).^(1/n);
    C(:,:,3)=(C(:,:,3)/amp).^(1/n);
figure(f)
image(C)
set(gca,'YDir','normal'); % flip the plot vertically
axis image
axis off
elseif nargin == 2
    figure(f)
    image(C)
%   imshow(C)
    set(gca,'YDir','normal'); % flip the plot vertically
    axis image
    axis off
end


% check = ver('symbolic');
% str1 = {'(R2018a)'};
% str2 = {'(R2016b)'};
% AA = check.Release ~= str1{1};
% BB = check.Release ~= str2{1};
% keyboard
% if isempty(find(AA,1)) == 0 || isempty(find(BB,1)) == 0
%     C(:,:,1)=(C(:,:,1)/amp).^(1/1);
%     C(:,:,2)=(C(:,:,2)/amp).^(1/1);
%     C(:,:,3)=(C(:,:,3)/amp).^(1/1);
%     disp('test')
% end