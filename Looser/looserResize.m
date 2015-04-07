% resize script
d = dir;
% image size
row = 115;
col = 115;
for tmp = 3:length(d)
    im = imread(d(tmp).name);
    %im = rgb2gray(im);
    im = imresize(im, [row col]);
    eval(sprintf('imwrite(im, ''%s%s'',''jpg'')',d(tmp).name(1:end-3),'jpg'));
end    
    
