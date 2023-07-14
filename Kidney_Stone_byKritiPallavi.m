% clearing all variables and the screen
clc;clear all;

%reading image
img = imread('1 (1).jpg');
figure
imshow(img)
%title('ORIGINAL IMAGE');

%Applying filteration of kidney stone
img = rgb2gray(img);
figure
imshow(img);


%title('GRAYSCALE IMAGE');
j = imadjust(img,[.5 .8],[]);
figure
imshow(j);
%title('INTENSITY IMAGE');
k = medfilt2(j,[12 13]);
figure
imshow(k)
%title('FILTERED IMAGE:')

%Applying segmentation
im = im2double(k);
[rim cim]=size(im);
data = im;
data = data(:);
cluster_n = 2;
[center,U,obj_fcn] = fcm(data,cluster_n);
%morphological analysis
U1=U';
A = zeros(length(data),1);
for i=1:480000
    if(U1(i,1)>=U1(i,2))
        A(i,1)= 1;
    else
        A(i,1)= 0;
    end
end
k=1;
for i=1:cim
    for j=1:rim
        fin_im(j,i)=A(k,1);
        k=k+1;
    end
end

%Displaying final cropped image
figure
fin_im=imcrop(fin_im,[115,40,600,355]);

imshow(fin_im);
%title('Final image:');
fin_im=edge(fin_im);
imshow(fin_im);