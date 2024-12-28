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

split = true;
split_rot_x = 0; // [-180:1:180]
split_rot_y = 0; // [-180:1:180]
split_rot_z = 0; // [-180:1:180]

pins = true;
pin_hole_diameter = 2;
pin_holes = 4;
pin_hole_inset = 4;
pin_hole_rotation = 45; // [-180:1:180]
pin_hole_depth = 4;

orientation_pin = true;
orientation_pin_location = 15; // [-180:1:180]

debug_cross_section = false;
debug_highlight_labels = true;

module label_at_point(position, text_string) {
  // Calculate azimuthal angle (rotation around Z)
  yaw = atan2(position[1], position[0]);

  // Calculate polar angle (rotation around X)
  pitch = atan2(sqrt(position[0] * position[0] + position[1] * position[1]),
                position[2]);

  // Place and orient text
  translate(position) rotate([ 0, pitch, yaw ]) scale([ 1, 1, -1 ])
      linear_extrude(height = dice_diameter / 2, center = false)
          text(text_string, font = font, valign = "center", halign = "center",
               size = label_size);
}

module labels() {
  points = get_face_centers(sides = sides);
  for (i = [0:len(points) - 1]) {
    label_at_point(position = points[i] * -1 * dice_diameter / 2,
                   text_string = str(get_labels(sides)[i]));
  }
}

module dice() {
  points = get_face_centers(sides = sides);
  difference() {
    union() {
      difference() { // Outer sphere
        sphere(r = dice_diameter / 2, $fn = dice_outer_resolution);

        if (debug_highlight_labels) {
          // clang-format off
                #labels();
          // clang-format on
        } else {
          labels();
        }
      }
      // Inner sphere
      sphere(r = (dice_diameter / 2) - (label_deboss / 2),
             $fn = dice_outer_resolution);
    }
    // Inner cavity
    union() {
      // Connecting pocket
      hull() {
        for (pnt = points) {
          translate(pnt * bearing_diameter) sphere(r = bearing_diameter / 2);
        }
      }
      // Pocket for the bearing to settle in
      for (pnt = points) {
        translate(pnt * bearing_diameter)
            sphere(r = ((bearing_diameter + pocket_padding) / 2));
      }
    }
  }
}

module pin_holes(inverse=false) {
  rotate([(inverse?180:0),0,0])union(){for (i = [0:pin_holes]) {
    rotate([ 0, 0, (360 / pin_holes * i) + pin_hole_rotation ])
        translate(v = [ dice_diameter / 2 - pin_hole_inset, 0, 0 ])
            cube([ pin_hole_diameter, pin_hole_diameter, pin_hole_depth * 2 ],
                 center = true);
  }
  if (orientation_pin) {
    rotate([ 0, 0, orientation_pin_location ])
        translate(v = [ dice_diameter / 2 - pin_hole_inset, 0, 0 ])
            cube([ pin_hole_diameter, pin_hole_diameter, pin_hole_depth * 2 ],
                 center = true);
  }}
}

module slicing_plane(angleX = 0, angleY = 0, angleZ = 0, size = 200) {
  rotate([ angleX, angleY, angleZ ]) translate([ 0, 0, -size / 2 ])
      cube([ size, size, size ], center = true);
}

if (debug_cross_section) {
  difference() {
    dice();
    cube(dice_diameter);
  }
} else if (split) {
  translate([ dice_diameter + 5, 0, 0 ]) // If you want side by side
  //translate([0, 0, 5]) // just a little vert seperation to check pins
   difference() {
    rotate([ -split_rot_x, 0, 0 ]) rotate([ 0, -split_rot_y, 0 ])
        rotate([ 0, 0, -split_rot_z ]) difference() {

      dice();
      slicing_plane(split_rot_x, split_rot_y, split_rot_z, 200);
    }
    if(pins){
      #pin_holes();
    }
  }
  difference() {

    rotate([ 180-split_rot_x, 0, 0 ]) rotate([ 0, -split_rot_y, 0 ])
        rotate([ 0, 0, -split_rot_z ]) intersection() {

      dice();
      slicing_plane(split_rot_x, split_rot_y, split_rot_z, 200);
    }
    if(pins){
      #pin_holes(inverse=true);
    }
  }
} else {
  dice();
}