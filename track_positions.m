% track_positions
%
%  Tracks mouse clicks over a list of images and stores out a parameters file on right click.
%
%  Bradley C. Grimm 
%  CS 6640 - Image Processing
%  October 29, 2009

function [ output_args ] = track_positions( I_names, Name, S )

global I
global Stage

global P

global Names

global OutName
global Steps

Names = I_names;

OutName = Name;
Steps = S;

Stage = 1;

M = size( I_names, 1 );

P = [];
I = [];
maxSz = [0 0 0];
for m=1:M
    Isz = size( imread( I_names(m,:) ) );
    maxSz = max(Isz, maxSz);
end

for m=1:M
    img = imread( I_names(m,:) );
    Isz = maxSz - size(img);
    P(m).Pos = [];
    I(:,:,:,m) = padarray(img(:,:,:), [max(Isz(1), 0) max(Isz(2), 0)], 'post');
end

% Start tracking
h=figure;
imshow( I(:,:,:,1) / 255 );
set(h,'windowbuttondownfcn',{@mouse_pressed}); % Calling track function

end
