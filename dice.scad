phi = (1 + sqrt(5)) / 2; // Golden ratio

d4_face_centers = [
    [ 0.333, 0.333, 0.333 ],   // Center of face 1
    [ -0.333, -0.333, 0.333 ], // Center of face 2
    [ -0.333, 0.333, -0.333 ], // Center of face 3
    [ 0.333, -0.333, -0.333 ]  // Center of face 4
];

d6_face_centers = [
    [-1.0000, 0.0000, 0.0000],
    [0.0000, 1.0000, 0.0000],
    [1.0000, 0.0000, 0.0000],
    [0.0000, -1.0000, 0.0000],
    [0.0000, 0.0000, -1.0000],
    [0.0000, 0.0000, 1.0000],
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
    [0.7371, -0.2395, -0.1480],
    [0.4556, -0.6270, 0.1480],
    [0.0000, -0.7750, -0.1480],
    [0.0000, 0.7750, 0.1480],
    [0.4556, 0.6270, -0.1480],
    [0.7371, 0.2395, 0.1480],
    [-0.7371, -0.2395, -0.1480],
    [-0.7371, 0.2395, 0.1480],
    [-0.4556, 0.6270, -0.1480],
    [-0.2815, 0.3875, -0.6270],
    [0.2815, 0.3875, -0.6270],
    [0.4556, -0.1480, -0.6270],
    [0.2815, -0.3875, 0.6270],
    [-0.2815, -0.3875, 0.6270],
    [0.0000, -0.4790, -0.6270],
    [-0.4556, -0.1480, -0.6270],
    [-0.4556, -0.6270, 0.1480],
    [-0.4556, 0.1480, 0.6270],
    [0.0000, 0.4790, 0.6270],
    [0.4556, 0.1480, 0.6270],
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
d6_labels = [ 5, 4, 2, 3, 1, 6 ];
d8_labels = [ 6, 2, 3, 7, 8, 5, 4, 1 ];
d10_labels = [ 10, 7, 3, 1, 9, 6, 8, 2, 4, 5 ];
d12_labels = [ 11, 5, 9, 1, 7, 3, 12, 6, 8, 4, 10, 2 ];
d20_labels = [ 11, 4, 18, 3, 19, 9, 12, 10, 17, 7, 1, 13, 14, 20, 5, 15, 2, 8, 16, 6 ];
d100_labels = [ 0, 70, 30, 10, 90, 60, 80, 20, 40, 50 ];

function get_labels(sides) = sides == 4     ? d4_labels
                             : sides == 6   ? d6_labels
                             : sides == 8   ? d8_labels
                             : sides == 10  ? d10_labels
                             : sides == 100 ? d100_labels
                             : sides == 12  ? d12_labels
                             : sides == 20  ? d20_labels
                                            : [];