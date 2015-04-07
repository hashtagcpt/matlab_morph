% display_parameters
%
%  Given a parameters file, goes through the images and shows their control points.
%
%  Bradley C. Grimm 
%  CS 6640 - Image Processing
%  October 29, 2009

function [ output_args ] = display_parameters( param_file )

[control_x control_y input output_name steps kw] = load_params( param_file, 1 );

[N M] = size( control_x );

images = [];
for m=1:M
    input(m,:)
    images(:,:,:,m) = imread( input(m,:) );
end


for m=1:M
    for i=1:N
        x = control_x(i,m);
        y = control_y(i,m);
        images(y, x, :, m) = 255;
        images(y+1, x, :, m) = 0;
        images(y-1, x, :, m) = 0;
        images(y, x+1, :, m) = 0;
        images(y, x-1, :, m) = 0;
    end
    
    imshow(images(:, :, :, m) / 255);
    waitforbuttonpress;
end

end

