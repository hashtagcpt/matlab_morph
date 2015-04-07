d = dir('*.png');

for tmp = 1:length(d)
    % read in image
    im = imread(d(tmp).name);
    
    % threshold image;
    ind = find(im ~= 0);
    im(ind) = 255;
    
    % write image
    imwrite(im,d(tmp).name);
end

    