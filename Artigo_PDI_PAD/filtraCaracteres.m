function ch = filtraCaracteres(chars)
global AREA_TOP_THRESH;
global AREA_BOT_THRESH;
global BOUND_MAX_PERI_THRESH;

    toRemove = [];
    for i=1:length(chars)
        fi = chars(i);
        bdbox = fi.BoundingBox;
        if( (fi.Area) > AREA_TOP_THRESH)
            rectangle('Position', fi.BoundingBox, 'EdgeColor', 'r');
            toRemove = [toRemove  i];
            continue;
        end

        if( (fi.Area) < AREA_BOT_THRESH)
            rectangle('Position', fi.BoundingBox, 'EdgeColor', 'r');
            toRemove = [toRemove  i];
            continue;
        end

        if( ( 2 * bdbox(3) + 2 * bdbox(4) ) > BOUND_MAX_PERI_THRESH)
            rectangle('Position', fi.BoundingBox, 'EdgeColor', 'r');
            toRemove = [toRemove  i];
            continue;
        end
        rectangle('Position', fi.BoundingBox, 'EdgeColor', 'b');

    end

    chars(toRemove)=[];
    ch = chars;
end