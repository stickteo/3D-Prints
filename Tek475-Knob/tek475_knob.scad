
// knob
// - top diameter
// - bottom diameter
// - height
// - inner hole diameter
d1 = 16.5 + 1;
d2 = 18.0 + 1;
h = 20.5;
d3 = 10+0.5;

// knob holes
// - diameter
// - height location
hd = 3.5;
hh = 6.5;

// collar
// - diameter
// - height
// - height location
// - height from top to top
//cd = 14.0 + 1.0; //v1
cd = 14.0 + 0.5; //v2
ch = 14.0 + 1.0;
chh = 3.5;
ctt = 3.0;

// cd (v1)
// - actual: 14.3
// - nominal: 15.0
// - want: 13.8
// - difference: 0.5

// 20.5 - 5.0 - 12.0
// 14 - 2.3 - 9.3 = 2.4

// spokes
// - number
// - diameter
// - height location
sn = 33;
sd = d1 - 1;
sd2 = 0.8;
hs = 2.0;

// trim
// - diameter
// - notch
// - height
td = 16.5 + 0.5;
tn = 1.5;
th = 1.5 + 0.5;
thh = 0.5;

/*
//hull(){
  translate([0,0,h])
  linear_extrude(0.1)
  difference(){
    circle(d=d1);
    for(i=[1:sn]){
      $fn = 30;
      rotate([0,0,360/sn*i])
      translate([d1/2,0,0])
      circle(d=sd2);
    }
  }
  
  linear_extrude(0.1)
  difference(){
    circle(d=d2);
    for(i=[1:sn]){
      $fn = 30;
      rotate([0,0,360/sn*i])
      translate([d2/2,0,0])
      circle(d=sd2);
    }
  }
//}
*/

module parta(){
  $fn = sn*3;
  intersection(){
    cylinder(h=h,d1=d2,d2=d1);
    
    a = d1-sd2;
    cylinder(h=h+a/2,d1=h*2+a,d2=0);
  }
}

module partb(){
  difference(){
    for(i=[1:sn]){
      $fn = 30;
      rotate([0,0,360/sn*i])
      translate([0,d2/2,0])
      rotate([atan2((d2-d1)/2,h),0,0])
      translate([0,0,-h])
      cylinder(h=h*3,r=sd2/2);
    }
    
    $fn = sn*3;
    a = d2/2-(d2-d1)/2*hs/h;
    c = h*2;
    b = a * c/(c-hs);
    cylinder(h=c,d1=b*2,d2=0);
  }
}

module partc(){
  difference(){
    parta();
    partb();
  }
}

difference(){
  partc();
  partd();
}


module partd(){
  $fn = sn*3;
  translate([0,0,-h])
  cylinder(h=h*3,d=d3);

  //translate([0,0,-chh-ch])
  //cylinder(h=(chh+ch)*2,d=cd);
  translate([0,0,-ctt])
  cylinder(h=h,d=cd);
  
  // trim
  difference(){
    cylinder(h=th*2,d=td,center=true);
    
    rotate([0,0,180])
    translate([-tn/2,0,thh])
    cube([tn,td,th]);
  }
  
  parte();
}

module parte(){
  $fn = 30;
  translate([0,0,hh]){
    rotate([0,0,45])
    rotate([-90,0,0])
    cylinder(h=d2,d=hd);
    
    rotate([0,0,-45])
    rotate([-90,0,0])
    cylinder(h=d2,d=hd);
  }
}

//parte();




