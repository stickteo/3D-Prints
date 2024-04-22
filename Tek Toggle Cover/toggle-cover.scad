
// diameters
// - inner
// - outer
// - stem
da = 13;
//db = 20; //v1
//db = 21; //v2
db = 22;
//ds = 7+2; //v1
// v1 measurements
// want: 7
// nominal: 9
// actual: 8
//ds = 7+1.2; //v2, loose fit
ds = 7+1;
// height
//h = 12; //v1
h = 14.5;
//h2 = 13; //v1
h2 = 12; //v3

// angle
a = 16;
a2 = 16;

// offset
off = 1;


module parta(){
  polygon([[-da/2,0],[da/2,0],[db/2,h],[-db/2,h]]);
  translate([0,h,0]){
    difference(){
      circle(d=db,$fn=60);
      translate([0,-db/2-0.01,0])
      square([db,db], center=true);
    }
  }
}

module partb(){
  $fn = 100;
  rotate_extrude(){
    intersection(){
      translate([0,-h/2,0])
      square([db,h*2+db]);
      parta();
    }
  }
}

module partc(){
  rotate([a2,0,0])
  rotate([0,a,0])
  //translate([0,0,-h*cos(a)])
  //linear_extrude(h*2*cos(a))
  translate([off,0,-h2])
  linear_extrude(h2*2)
  circle(d=ds,$fn=6);
}

partc();
#partb();

module partd(){
  difference(){
    partb();
    partc();
  }
}

//partd();
