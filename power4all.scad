// SPDX: CC-BY-SA-4.0
// Copyright 2020 Brian Starkey <stark3y@gmail.com>

$fn = 128;
dxf_file = "power4all.dxf";

// Arbitrary small offset used to avoid zero-thickness surfaces
e = 1;

// The intersection applies a chamfer to the top edges. Not functionally necessary.
translate([0, 0, 16]) rotate([0, 180, 0]) intersection() {
	// Main structure
	difference() {
		// Main block
		union() {
			// Main block, to subtract everything else from
			linear_extrude(height = 16) import(dxf_file, layer="main_block");
		}
		// Minus all the internals
		union() {
			// Slice out the raised section at the back
			// Extrude length isn't important, just needs to cover the whole piece
			translate([-40, 0, 0]) rotate([0, 90, 0]) linear_extrude(height = 80) import(dxf_file, layer="sub_rear_horizontal");

			// Everything cut from the underside translated down by 'e' to avoid zero-thickness
			// surfaces at the base
			// All extrusions correspondingly increased by "e"
			translate([0, 0, -e]) {
				// Space where the contacts go. "10" is measured.
				linear_extrude(height = 10 + e) import(dxf_file, layer="sub_contacts");

				// This is the gap for the spade terminals to wedge into. The slots are angled to suit
				// the geometry of my spade terminals, but I'm not sure if that's universal.
				// The slot thickness comes out about right for my spades.
				// "7" is the width of my spades + 1
				linear_extrude(height = 7 + e) import(dxf_file, layer="sub_spades");

				// Deeper than the spade slots, to match up with the connector. This would be neater if it
				// sloped downwards, but I'm lazy and it doesn't really matter.
				// "10" is just eyeballed
				linear_extrude(height = 10 + e) import(dxf_file, layer="sub_wiring");

				// Cut out the hole where the spring clip goes
				// "15" is measured as the clip protrudes ~5 mm above the top surface
				linear_extrude(height = 15 + e) import(dxf_file, layer="sub_clip");

				// Not functional, but just to remind which terminal is which
				// "11" is eyeballed
				linear_extrude(height = 11 + e) import(dxf_file, layer="sub_signs");

			}

			// For the slides, extrude one part straight up (for the profile in X, Y), then intersect with
			// a horizontal profile, to get the Z
			intersection() {
				// Height not important, just needs to be tall enough to cover the full slides
				linear_extrude(height = 16) import(dxf_file, "slides_vertical");

				// Note that the X offset in the DXF file is important for this layer, representing
				// the distance from the base to the bottom of the slides. This allows a rotation
				// around the Y axis to place the slides in the right place vertically.
				// Extrusion height is not important - just needs to be large enough to cover everything
				translate([-40, 0, 0]) rotate([0, 90, 0]) linear_extrude(height = 80) import(dxf_file, layer="slides_horizontal");
			}

			// Cut out the XT60 connector. It's slightly oversize, so that the mating connector fits easily.
			// 60 is the distance to the end face, so 60 - 17 embeds the whole connector inside
			translate([0, 60 - 17, 7]) rotate([0, 90, 90]) linear_extrude(height = 17 + e) import(dxf_file, layer="sub_xt60");
		}
	}

	// Chamfer the top edges
	translate([0, 70, 0]) rotate([90, 0, 0]) linear_extrude(height = 100) import(dxf_file, layer="chamfer");
}
