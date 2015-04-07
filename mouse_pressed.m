% mouse_pressed
%
%  Handler for checking whena mouse is pressed and storing where it clicked.
%
%  Bradley C. Grimm 
%  CS 6640 - Image Processing
%  October 29, 2009

function mouse_pressed( imagefig, varargins )

global I
global Stage

global P

global Names

global OutName
global Steps

type = get(gcbf, 'SelectionType');

if ( strcmp( type, 'normal' ) || strcmp( type, 'open' ) == 1 )
    pt = get(gca,'currentpoint');
    pt = floor( pt(1,1:2) );
    pt = [pt(2) pt(1)];
    
    I( (pt(1)-3):(pt(1)+3), (pt(2)-3):(pt(2)+3), :, Stage ) = 255;
    I( (pt(1)-2):(pt(1)+2), (pt(2)-2):(pt(2)+2), :, Stage ) = 1;

    P(Stage).Pos = [P(Stage).Pos; pt(2); pt(1)];
    Stage = Stage + 1;
    if ( Stage > size(I,4) )
        Stage = 1;
    end
    imshow( I(:,:,:,Stage) / 255 );
else
    size(P)
    for i=1:size(P,2)
        FP(:,i) = P(i).Pos(:)';
    end
    
    OutNameParams = strcat( OutName, '.txt' );
    fid = fopen(OutNameParams, 'w', 'n');
    fprintf(fid, '%f %f\n', size(FP)');
    fprintf(fid, [repmat('%f ', 1, size(FP,2)), '\n'], FP');
    for i=1:size(Names)
        fprintf(fid, '%s\n', Names(i,:) );
    end
    fprintf(fid, '%s\n%d\n20', OutName, Steps );
    fclose(fid);
    
    set(gcf,'windowbuttondownfcn',[]);
end

end

