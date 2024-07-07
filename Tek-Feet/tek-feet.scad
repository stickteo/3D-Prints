// tek-feet.scad
// teod jun 15, 2024

// top width
// bottom width
// width cutout
// height with shaft
wt = 24.0;
wb = 21.0;
wc = 6.5;
hs = 38.0;//36.0;

// diameter screw hole
// diameter screw shaft
// screw offset
// diameter main shaft
// screw offset 2
// diameter screw pilot hole
//  v1 dsh measurements:
//  actual:     7.0mm
//  desired:    8.0mm
//  difference: 1.0mm
dsh = 8.0 + 1.0;
dss = 8.5;
so = 12.75;
dms = (so-wc)*2; 
so2 = wt-so;
dsp = 2.0;

//12.75;
//11.25;

// top thickness
// bottom thickness
tt = 4.0;//3.5;
bt = 4.0;//3.0;

// chamfer radius
// bevel radius
cr = 4.0;
br = 2.0;

// height
h = 33.0-br;//31.0 - br;

// wire gap
// wire height
wg = 6.5;
wh = (h+br-3*wg-tt-bt)/2+wg;

// shaft offset
sho = 27.5 - 12.0 - 2.5;

module parta(){
  points = [
    [0,0,0],
    [wt,0,0],
    [wt,wt,0],
    [0,wt,0],
    [wt-wb,wt-wb,h],
    [wt,wt-wb,h],
    [wt,wt,h],
    [wt-wb,wt,h]
  ];
  faces = [
    [0,1,2,3],
    [4,5,1,0],
    [7,6,5,4],
    [5,6,2,1],
    [6,7,3,2],
    [7,4,0,3]
  ];
  polyhedron(points,faces);
}

module partb(){
  difference(){
    $fn = 90;

    translate([-so2,-so2,0])
    parta();

    translate([0,0,tt])
    difference(){
      cube([so*2,so*2,h*2]);
      union(){
        cylinder(h,so,so);
        translate([-so*2,-so,0])
        cube([so*2,so*2,h]);
        translate([-so,-so*2,0])
        cube([so*2,so*2,h]);
      }
    }
  }
}

module partc(){
  $fn = 30;
  translate([0,0,-h])
  linear_extrude(h*3)
  translate([so,so,0])
  difference(){
    square(cr*2,center=true);
    translate([-cr,-cr,0])
    circle(cr);
  }
  
  translate([-so2,so,0])
  rotate([0,atan2(wt-wb,h),0])
  translate([0,0,-h])
  linear_extrude(h*3)
  difference(){
    square(cr*2,center=true);
    translate([cr,-cr,0])
    circle(cr);
  }
  
  translate([so,-so2,0])
  rotate([-atan2(wt-wb,h),0,0])
  translate([0,0,-h])
  linear_extrude(h*3)
  difference(){
    square(cr*2,center=true);
    translate([-cr,cr,0])
    circle(cr);
  }
  
  translate([-so2,-so2,0])
  rotate([-atan2(wt-wb,h),atan2(wt-wb,h),0])
  translate([0,0,-h])
  linear_extrude(h*3)
  difference(){
    square(cr*2,center=true);
    translate([cr,cr,0])
    circle(cr);
  }
}

module partd(){
  $fn = 30;
  offset(cr)
  offset(-cr)
  intersection(){
    $fn = 90;
    union(){
      circle(so);
      translate([-so*2,-so,0])
      square(so*2);
      translate([-so,-so*2,0])
      square(so*2);
    }
    translate([wt-wb-so2,wt-wb-so2,0])
    square(so*2);
  }
}

module parte(){
  $fn = 30;
  hull(){
    linear_extrude(0.1)
    partd();

    translate([0,0,br])
    linear_extrude(0.1)
    offset(-br)
    partd();
  }
}

module partf(){
  difference(){
    partb();
    partc();
  }
  translate([0,0,h-0.1])
  parte();
}

module partg(){
  $fn = 90;
  linear_extrude(wg)
  difference(){
    union(){
      circle(so+1);
      translate([-so-1,0,0])
      square(so+1);
      translate([0,-so-1,0])
      square(so+1);
    }
    union(){
      circle(d=dms);
      translate([-dms*2,0,0])
      square([dms*2,dms/2]);
      translate([0,-dms*2,0])
      square([dms/2,dms*2]);
      translate([-dms*2,-dms*2,0])
      square([dms*2,dms*2]);
    }
  }
}

module parth(){
  difference(){
    union(){
      partf();
      $fn = 60;
      translate([0,0,-hs+h+br])
      cylinder(h=h+br,d=dss);
    }
    translate([0,0,tt])
    partg();
    translate([0,0,tt+wh])
    partg();
    translate([0,0,tt+wh*2])
    partg();
  }
}

difference(){
  $fn = 60;
  parth();

  union(){
    translate([0,0,sho])
    cylinder(h=h+br,d=dsh);
    
    translate([0,0,-h-br])
    cylinder(h=(h+br)*3,d=dsp);
  }
}
