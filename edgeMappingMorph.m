% get edge map of human
im1 = imread('HumGrey.bmp');
im1 = rgb2gray(im1);
im1eMap = edge(im1,'canny');
[r1,c1] = find(im1eMap ~= 0);

% get edge map of robot
im2 = imread('RobGrey.bmp');
im2 = rgb2gray(im2);
im2eMap = edge(im2,'canny');
[r2,c2] = find(im2eMap ~= 0);

sampling = linspace(1,length(c2),length(c1));
for tmp = 1:length(sampling)
    %get me those sample points nrows, 2 col
end
%open the text file for writing

%write txt file, first row nrows, 2 col

%write txt file with length(sampling) points

%write the names of the image files on two lines

%write the name of the text file

%what are those two numbers?

%close up the file