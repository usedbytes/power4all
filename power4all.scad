
$fn = 128;
dxf_file = "power4all.dxf";

rotate([0, 0, 0]) intersection() {
	difference() {
		union() {
			linear_extrude(height = 16) import(dxf_file, layer="bloc");
		}
		union() {
			translate([-40, 0, 0]) rotate([0, 90, 0]) linear_extrude(height = 80) import(dxf_file, layer="bloc_sub_horz");
			translate([0, 0, -1]) linear_extrude(height = 11) import(dxf_file, layer="sub_contacts");
			translate([0, 0, -1]) linear_extrude(height = 8) import(dxf_file, layer="spades_sub");
			translate([0, 0, -1]) linear_extrude(height = 11) import(dxf_file, layer="solder_sub");
			translate([0, 0, -1]) linear_extrude(height = 16) import(dxf_file, layer="sub_clip");
			translate([0, 0, -1]) linear_extrude(height = 12) import(dxf_file, layer="signs");

			difference() {
				union() {
					translate([-40, 0, 0]) rotate([0, 90, 0]) linear_extrude(height = 80) import(dxf_file, layer="slide_sub_horz");
				}
				union() {
					translate([0, 0, -1]) linear_extrude(height = 15) import(dxf_file, layer="internal");
				}
			}

			translate([0, 60-17, 7]) rotate([0, 90, 90]) linear_extrude(height = 17.5) import(dxf_file, layer="xt60_xsec");
		}
	}
	translate([0, 60, 0]) rotate([-0, 0, 0]) translate([0, 10, 0]) rotate([90, 0, 0]) linear_extrude(height = 100) import(dxf_file, layer="smooth");
}

