$fn = 128;
dxf_file = "cap.dxf";

base_t = 4;

difference() {
	linear_extrude(height = base_t) import(dxf_file, layer="base");
	translate([0, 0, base_t - 1.5]) linear_extrude(height = 2) import(dxf_file, layer="slot");
}
linear_extrude(height = 4 + base_t) import(dxf_file, layer="pegs");
linear_extrude(height = 7.6 + base_t) import(dxf_file, layer="outer");
