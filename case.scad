include <BOSL/constants.scad>
include <BOSL2/hinges.scad>
include <BOSL2/std.scad>
use <BOSL/debug.scad>
use <Jacquard24Custom-UnderlinedNumbers.otf>

dice = [ "D12", "D100", "D10", "D8", "D6", "D4" ];
dice_diameter = 40;
dice_padding = 2;
dice_spacing = 10;
horizontal_thickness = 40;
vertical_thickness = 4;

font = "Jacquard 24 Custom";
font_size = 10;
font_deboss = 1;

dice_slot_diameter = dice_diameter + dice_padding;
dice_slot_x_total = dice_slot_diameter + dice_spacing;
case_x = dice_slot_x_total * 3;
case_y = dice_slot_x_total * 3;
case_z = dice_slot_diameter / 2 + vertical_thickness;
generate_bottom = true; // [top:false,bottom:true]

// difference() {
//     cube([ case_x, case_y, case_z ]);
//     translate(
//         [ dice_slot_x_total / 2, case_y - (dice_slot_diameter / 2) -
//         dice_spacing,
//           case_z ]) for (i = [0:len(dice) - 1]) {
//         translate([ dice_slot_x_total * i, 0, 0 ]) sphere(d =
//         dice_slot_diameter); translate([ dice_slot_x_total * i,
//         -dice_slot_diameter / 1.25, 0 ])
//             text(text = dice[i], halign = "center", valign = "center", font =
//             font, size = font_size);
//     }
// }

module case_base(bottom = true) {
  difference() {
    hull() {
      for (i = [0:len(dice) - 1]) {
        rotate([ 0, 0, (360 / len(dice) * i) ])
            translate(v = [ dice_slot_x_total, 0, 0 ])
                cylinder(h = case_z, d = dice_slot_x_total);
      }
    }
    translate([ 0, 0, case_z ]) for (i = [0:len(dice) - 1]) {
      rotate([ 0, 0, (360 / len(dice) * i) ])
          translate(v = [ dice_slot_x_total, 0, 0 ]) union() {
        sphere(d = dice_slot_diameter);
        if (bottom) {
          rotate([ 0, 0, -(360 / len(dice) * i) ])
              translate([ 0, 0, 0 - case_z - font_deboss + vertical_thickness ])
                  linear_extrude(height = case_z)
                      text(text = dice[i], halign = "center", valign = "center",
                           font = font, size = font_size);
        }
      }
    }
    translate([ 0, 0, case_z ]) sphere(d = dice_slot_diameter);
    if (bottom) {
      translate([ 0, 0, vertical_thickness ]) linear_extrude(height = case_z)
          text(text = "D20", halign = "center", valign = "center", font = font,
               size = font_size);
    }
  }
}

module case (bottom = true){union(){
    case_base(bottom); translate([ 0, dice_slot_x_total + 18, case_z + 5 ])
        rotate([ 90, 0, 180 ]) ydistribute(spacing = 10){
            knuckle_hinge(length = 35, segs = 9, offset = 4, arm_height = 1,
                          teardrop = true, inner = !bottom);}}}

case (bottom = generate_bottom);