function [ FDB FD] = fractalTrans(img)

[M N]= size(img);

img = double(img);
%figure, imshow(I);
%hold on;

if length(size(img)) == 3
    img = rgb2gray(img);
end;


rmax = 7;

%------- performing non-linear filtering on a varying size pixel block -------%
%h = waitbar(0,'Performing 3-D Box Counting...');
for r=2:rmax
    mask = fspecial('gaussian',r,r/2);
    img = conv2(img,mask,'same');
    rc = @(x) floor(((max(x)-min(x))/r))+ 1; % non-linear filter
    F= colfilt(img, [r r],'sliding', rc); 
    B{r}= log(double(F * (rmax^2/(r^2))));
    %waitbar(r/6)
end
%close(h)

i=log(2:rmax); % Normalised scale range vector

%------- computing the slope using linear regression -------%

Nxx=dot(i,i)-(sum(i)^2)/(rmax - 1);
%h = waitbar(0,'Transforming to FD...');
for m = 1:M
    for n = 1:N
        %fd= [B{7}(m,n), B{6}(m,n), B{5}(m,n), B{4}(m,n), B{3}(m,n), B{2}(m,n)]; % Number of boxes multiscale vector
        fd= [B{7}(m,n), B{6}(m,n), B{5}(m,n), B{4}(m,n), B{3}(m,n), B{2}(m,n)];
        Nxy=dot(i,fd)-(sum(i)*sum(fd))/(rmax - 1); 
        FD(m, n)= (Nxy/Nxx); % slope of the linear regression line
    end
    %waitbar(m/M)
end
%close(h)
%Activation function is used
FD2 = ReLU(FD);

FDB = mat2gray(FD2);
end



