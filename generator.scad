use <Jacquard24Custom-UnderlinedNumbers.otf>
use <dice.scad>

dice_diameter = 40;
bearing_diameter = 10;
pocket_padding = 2;
sides = 4; // [4, 6, 8, 10, 100, 12, 20]
label_size = 10;
label_deboss = 1;
font = "Jacquard 24 Custom";
dice_outer_resolution = 100;

debug_cross_section = false;
debug_highlight_labels = true;

module label_at_point(position, text_string)
{
    // Calculate azimuthal angle (rotation around Z)
    yaw = atan2(position[1], position[0]);

    // Calculate polar angle (rotation around X)
    pitch = atan2(sqrt(position[0] * position[0] + position[1] * position[1]), position[2]);

    // Place and orient text
    translate(position) rotate([ 0, pitch, yaw ]) scale([ 1, 1, -1 ])
        linear_extrude(height = label_deboss, center = false)
            text(text_string, font = font, valign = "center", halign = "center", size = label_size);
}

module labels()
{
    points = get_face_centers(sides = sides);
    for (i = [0:len(points) - 1])
    {
        label_at_point(position = points[i] * -1 * dice_diameter / 2, text_string = str(get_labels(sides)[i]));
    }
}

module dice()
{
    points = get_face_centers(sides = sides);
    difference()
    {
        // Outer sphere
        sphere(r = dice_diameter / 2, $fn = dice_outer_resolution);
        // Inner sphere
        union()
        {
            // Connecting pocket
            hull()
            {
                for (pnt = points)
                {
                    translate(pnt * bearing_diameter) sphere(r = bearing_diameter / 2);
                }
            }
            // Pocket for the bearing to settle in
            for (pnt = points)
            {
                translate(pnt * bearing_diameter) sphere(r = ((bearing_diameter + pocket_padding) / 2));
            }
        }
        if (debug_highlight_labels)
        {
#labels();
        }
        else
        {
            labels();
        }
    }
}

if (debug_cross_section)
{
    difference()
    {
        dice();
        cube(dice_diameter);
    }
}
else
{
    dice();
}