% load_params
%
%  Loads in a morphing parameters file.
%
%  Bradley C. Grimm 
%  CS 6640 - Image Processing
%  October 29, 2009

function [ control_pointx control_pointy input output_image steps kern_width ] = load_params( filename, atlas )

control_pointx = [];
control_pointy = [];
input = [];
steps = 1;

stage = 1;
fid = fopen(filename, 'r', 'n');
while ( 1 )
    line = fgetl(fid);
    if ~ischar(line)
        break;
    end
    
    if findstr(line,'//') == 1
        continue;
    else
        %disp(line);
        if ( stage == 1 )
            total = str2num(line);
            stage = stage + 1;
        elseif ( stage == 2 || stage == -2 )
            total(1) = total(1) - 1;
            if ( stage == 2 )
                control_pointx = [control_pointx; str2num(line)];
                stage = -2;
            else
                control_pointy = [control_pointy; str2num(line)];
                stage = 2;
            end
            if ( total(1) <= 0 )
                stage = 3;
            end
        elseif ( stage == 3 )
            % Input filenames.
            total(1,2) = total(1,2) - 1;
            input = [input; line];
            if ( total(2) <= 0 )
                stage = 5;
            end
        elseif ( stage == 5 )
            % Output filename.
            output_image = line;
            stage = stage + 1;
            if ( atlas )
                stage = stage + 1;
            end
        elseif ( stage == 6 )
            % Number of morph images
            steps = str2num(line);
            stage = stage + 1;
        elseif ( stage == 7 )
            % Kernel width
            kern_width = str2num(line);
            stage = stage + 1;
        end
    end
end

end

