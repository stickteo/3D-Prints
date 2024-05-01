
w = 1 * 25.4;
h = 1.9 * 25.4;
r = 1;
x = 0.375 * 25.4;
y1 = 0.25 * 25.4;
y2 = h - y1;

out = 0.5 * 25.4;
rad = 0.25 * 25.4;
t = 3;

module parta(){
  $fn = 100;
  offset(r=rad)
  offset(delta=out-rad)
  square([w,h],center=true);
}

module partb(){
  $fn = 100;
  translate([-w/2,-h/2,0]){
    translate([x,y1,0])
    circle(r);
    translate([x,y2,0])
    circle(r);
  }
}

module partc(){
  $fn = 100;
  difference(){
    parta();
    offset(r=rad/2) offset(r=-rad) parta();
  }
  offset(r=rad) partb();
}

module partd(){
  difference(){
    union(){
      linear_extrude(t-1)
      parta();
      
      translate([0,0,t-1-0.1])
      linear_extrude(1+0.1)
      partc();
    }
    
    translate([0,0,-t/2])
    linear_extrude(t*2)
    partb();
  }
}

partd();




