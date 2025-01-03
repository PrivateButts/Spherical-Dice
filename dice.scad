phi = (1 + sqrt(5)) / 2; // Golden ratio

d4_face_centers = [
    [ 0.333, 0.333, 0.333 ],   // Center of face 1
    [ -0.333, -0.333, 0.333 ], // Center of face 2
    [ -0.333, 0.333, -0.333 ], // Center of face 3
    [ 0.333, -0.333, -0.333 ]  // Center of face 4
];

d6_face_centers = [
    [ 1, 0, 0 ],  // Positive X
    [ -1, 0, 0 ], // Negative X
    [ 0, 1, 0 ],  // Positive Y
    [ 0, -1, 0 ], // Negative Y
    [ 0, 0, 1 ],  // Positive Z
    [ 0, 0, -1 ]  // Negative Z
];

d8_face_centers = [
    [ 0.5, 0.5, 0 ], [ -0.5, 0.5, 0 ], [ 0.5, -0.5, 0 ], [ -0.5, -0.5, 0 ], [ 0, 0.5, 0.5 ], [ 0, -0.5, 0.5 ],
    [ 0, 0.5, -0.5 ], [ 0, -0.5, -0.5 ]
];

d10_face_centers = [
    [ 0.7, 0, 0.7 ], [ -0.7, 0, 0.7 ], [ 0, 0.7, 0.7 ], [ 0, -0.7, 0.7 ], [ 0.5, 0.5, 0 ], [ -0.5, -0.5, 0 ],
    [ 0.7, 0, -0.7 ], [ -0.7, 0, -0.7 ], [ 0, 0.7, -0.7 ], [ 0, -0.7, -0.7 ]
];

d12_face_centers = [
    [ 0, 1 / phi, phi ], [ 0, -1 / phi, phi ], [ 0, 1 / phi, -phi ], [ 0, -1 / phi, -phi ], [ 1 / phi, phi, 0 ],
    [ -1 / phi, phi, 0 ], [ 1 / phi, -phi, 0 ], [ -1 / phi, -phi, 0 ], [ phi, 0, 1 / phi ], [ -phi, 0, 1 / phi ],
    [ phi, 0, -1 / phi ], [ -phi, 0, -1 / phi ]
];

d20_face_centers = [
    [ 0, 0.8506, 0.5257 ],        [ 0, -0.8506, 0.5257 ],       [ 0, 0.8506, -0.5257 ],
    [ 0, -0.8506, -0.5257 ],      [ 0.8506, 0.5257, 0 ],        [ -0.8506, 0.5257, 0 ],
    [ 0.8506, -0.5257, 0 ],       [ -0.8506, -0.5257, 0 ],      [ 0.5257, 0, 0.8506 ],
    [ -0.5257, 0, 0.8506 ],       [ 0.5257, 0, -0.8506 ],       [ -0.5257, 0, -0.8506 ],
    [ 0.3568, 0.5774, 0.7392 ],   [ -0.3568, 0.5774, 0.7392 ],  [ 0.3568, -0.5774, 0.7392 ],
    [ -0.3568, -0.5774, 0.7392 ], [ 0.3568, 0.5774, -0.7392 ],  [ -0.3568, 0.5774, -0.7392 ],
    [ 0.3568, -0.5774, -0.7392 ], [ -0.3568, -0.5774, -0.7392 ]
];

function normalize(v) = let(len = sqrt(v[0] * v[0] + v[1] * v[1] + v[2] * v[2])) len == 0
                            ? [ 0, 0, 0 ]
                            : [ v[0] / len, v[1] / len, v[2] / len ];

function normalize_all(face_centers) = [for (f = face_centers) normalize(f)];

function get_by_sides(sides) = sides == 4     ? d4_face_centers
                               : sides == 6   ? d6_face_centers
                               : sides == 8   ? d8_face_centers
                               : sides == 10  ? d10_face_centers
                               : sides == 100 ? d10_face_centers
                               : sides == 12  ? d12_face_centers
                               : sides == 20  ? d20_face_centers
                                              : [];

function get_face_centers(sides) = normalize_all(get_by_sides(sides));

// Pre-shuffled face labels for common dice
d4_labels = [ 3, 1, 4, 2 ];
d6_labels = [ 5, 2, 6, 3, 1, 4 ];
d8_labels = [ 7, 3, 5, 2, 8, 1, 4, 6 ];
d10_labels = [ 10, 7, 3, 1, 9, 6, 8, 2, 4, 5 ];
d12_labels = [ 11, 5, 9, 1, 7, 3, 12, 6, 8, 4, 10, 2 ];
d20_labels = [ 19, 8, 12, 1, 17, 6, 20, 4, 14, 3, 16, 7, 18, 2, 15, 5, 13, 10, 11, 9 ];
d100_labels = [ 0, 70, 30, 10, 90, 60, 80, 20, 40, 50 ];

function get_labels(sides) = sides == 4     ? d4_labels
                             : sides == 6   ? d6_labels
                             : sides == 8   ? d8_labels
                             : sides == 10  ? d10_labels
                             : sides == 100 ? d100_labels
                             : sides == 12  ? d12_labels
                             : sides == 20  ? d20_labels
                                            : [];