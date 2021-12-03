%% 
% Final Project

clc; clear;
%% 
% reading cataract images

cat_max = [];

for i = 1:20
    name = 'cataract_';
    newname = strcat(name,int2str(i),'.png');
    img = imread(newname);
    imgray = rgb2gray(img);
    cat_max(i) = max(imgray(:));
end

cat_avg = mean(cat_max);
%% 
% reading all normal images

norm_max = [];

for i =  1:20
    name = 'Normal_';
    newname = strcat(name, int2str(i),'.png');
    img = imread(newname);
    imgray = rgb2gray(img);
    norm_max(i) = max(imgray(:));
end

norm_avg = mean(norm_max);
%% 
% Testing Images

filename = input('Enter file name');
% filename = "cataract_1.png";
% filename = "Normal_1.png";

img = imread(filename);
img = rgb2gray(img);
maxval = max(img(:));

if maxval >= norm_avg
    fprintf('Normal/Healthy Eyes');
elseif maxval <= cat_avg
    fprintf('Cataract Formation');
else 
    diffc = abs(maxval - cat_avg);
      diffn = abs(norm_avg - maxval);
   if diffn < diffc
       fprintf('Likely normal but further diagnostic measures recommended.');
   elseif diffn > diffc 
       fprintf('Likely cataracts but further diagnostic measures recommended.')
   elseif diffn == diffc
       fprintf("Unclear diagnosis, further testing is required.");
   end
end