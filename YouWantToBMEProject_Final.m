%% 
% Final Project

clc; clear;
%% 
% reading cataract images

cat_max = [];

for i = 1:20
    name = 'cataract_'; 
    newname = strcat(name,int2str(i),'.png');
    img = imread(newname); %read image
    imgray = rgb2gray(img); %convert to gray scale
    cat_max(i) = max(imgray(:)); %find max value in catarct image
end

cat_avg = mean(cat_max); %find low threshold by averaging cataract max values
%% 
% reading all normal images

norm_max = [];

for i =  1:20
    name = 'Normal_';
    newname = strcat(name,int2str(i),'.png');
    img = imread(newname); %read image
    imgray = rgb2gray(img); %convert to gray scale
    norm_max(i) = max(imgray(:)); %find max value of normal image
end

norm_avg = mean(norm_max); %find high threshold by averaging normal max values
%% 
% Testing Images

filename = input('Enter file name'); %input image file name
% filename = "Cataract_20.png";
% filename = "Normal_20.png";

img = imread(filename); %read test image
img = rgb2gray(img); %convert to gray scale
maxval = max(img(:)); %find max value of image
imshow(img); %display the image

if maxval >= norm_avg % image max value is above high threshold
    fprintf('Normal/Healthy Eyes');
elseif maxval <= cat_avg % image max value is below low threshold
    fprintf('Cataract Formation');
else 
    diffc = abs(maxval - cat_avg); % difference between max value and low threshold
      diffn = abs(norm_avg - maxval); % differnce between max value and high threshold
   if diffn < diffc % image is closer to normal values
       fprintf('Likely normal but further diagnostic measures recommended.')
   elseif diffn > diffc % image is closer to cataract values 
       fprintf('Likely cataracts but further diagnostic measures recommended.')
   elseif diffn == diffc % image is exactly in between cataracts and normal
       fprintf("Unclear diagnosis, further testing is required.");
   end
end