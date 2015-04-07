% atlas
%
%  Similar to morphing, atlas creates an "average" image of all the images in the parameters file.
%
%  Bradley C. Grimm 
%  CS 6640 - Image Processing
%  October 29, 2009

function atlas( param_filename )

% Load parameters file.
[control_x control_y input output_name steps kw] = load_params( param_filename, 1 );

% Find the values of the weights.
[N M] = size( control_x );

yt = sum(control_y,2) / M;
xt = sum(control_x,2) / M;

% Load in images, and pad them as necessary.
images = [];
maxSz = [0 0 0];
for m=1:M
    Isz = size( imread( input(m,:) ) );
    if ( length(Isz) < 3 )
        Isz = [Isz 0];
    end
    maxSz = max(Isz, maxSz);
end

for m=1:M
    image = imread( input(m,:) );
    sz = size( image );
    if ( length(sz) < 3 )
        sz = [sz 0];
    end
    Isz = maxSz - sz;
    images(:,:,:,m) = padarray(image, [max(Isz(1), 0) max(Isz(2), 0)], 'post');
end

[dh dw c num] = size(images);

yt = yt / dh;
xt = xt / dw;

output = zeros(dh, dw, c);
for m=1:M
    y1 = control_y(:,m) / dh;
    x1 = control_x(:,m) / dw;

    kernel = @thin_plate_spline;
    %kernel = @(s) ( exp( -kw * (s * s) ) );
    
    k1 = calculate_rbf_weights( yt, xt, y1, x1, kernel );
    
    I1 = interpolate_morph( yt, xt, k1, kernel, images(:,:,:,m), dh, dw );
    output = output + I1 / M;
end

imshow(output)

str = sprintf('%s.png', output_name);
imwrite(output, str, 'png');

end

