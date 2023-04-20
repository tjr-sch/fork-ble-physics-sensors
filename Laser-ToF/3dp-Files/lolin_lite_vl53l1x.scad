include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>
use <BOSL/masks.scad>

$fn = 30;
espX = 35;
espY = 55;
espZ = 1.5;
wall = 1.5;
usbX = 8;
usbZ = 3.5;
z = 30;
dist = 5;
//show microcontroller and sensors?
mc = false ;
//position of usb and mounting holes
usbPos = 7;
mcDist = 20;
//
espMount = [[21,0,0],[0,38.5,0],[21,38.5,0],[0,0,0]];


screwD = 2;
module esp(){;
translate([121.5,63,-41])rotate([90,0,0])import("esp32.stl");
}

module lolin(){
 rotate([180,0,-90])import("lolin32_lite.stl");
}

module ina(){
   rotate([90,0,0])import("ina219_h.stl");
}
module ToF(){
    color("red")rotate([-90,0,90])translate([-13,-5,-15])import("VL53L1X.stl");
}
module hull(){
    if(mc)ToF();
    up(z/2+wall/2)difference(){
       down(0.5)cuboid([espX+2*wall,espY+2*wall,z+wall+1], fillet = 2, edges=EDGES_Z_ALL);
               up(wall/2)cuboid([espX,espY,z+0.1], fillet = 1, edges=EDGES_Z_ALL);

       
        //tof mount
        translate([8,0,-z/2-2])cuboid([8,5,wall+5],fillet  =1, edges=EDGES_Z_ALL);
        #translate([-4.5+3,0,-z/2])cuboid([4,16,2]);
        //tof screw hole
        for(i=[[12.5,10.5,-4-z/2],[12.5,-10.5,-4-z/2]]){
        color("red")translate(i)
            cylinder(d = 3, h = dist+1);}
       
         //usb hole 
       translate([3.1,-espY/2,6.8])cuboid([usbX,5,usbZ],fillet = 1, edges=EDGES_Y_ALL);
   //battery hole
       translate([-12.6,-espY/2,8])cuboid([9,5,6],fillet = 1, edges=EDGES_Y_ALL);

        
        //lid holder
        translate([-espX/2+1.5,-(espY)/2,13])rotate([0,90,0])cylinder(h=espX-3,d=2);
       
       //switch hole
            translate([0,-espY/2+2,-5])rotate([90,0,0])cylinder(d = 7.6, h = 5);
    }
    
    //screw holes
    for(i=[-1,1]){
    translate([i*(espX/2-1.5),espY/2-2,wall/2])difference(){
               cylinder(d = 5, h = z+0.5);
               translate([0,0,z/2])cylinder(d = 2, h = z+0.6);
            }
        }
        
        
    //holder esp
    z_1 = 19.5;
    translate([-espX/2+screwD*2.5-1.8,-espY/2+screwD*2.5-3+6.3,0]){
       color("green")for(i = espMount){
             translate(i)difference(){
             cylinder(h=mcDist,d=screwD*2.5);
             up(0.5)cylinder(h=mcDist, d = screwD-0.4);
          }
      }
      
  }
    
    
        
            
    
    
    module switch(){
         d=10;
         gap=0.6;
         difference(){
            union(){
            fwd(d/2)down(2)cylinder(d=d,h=4);
            cuboid([d,d,4]);
               
         }
            fwd(d/2)down(2)cylinder(d=d-gap*2,h=5);
            cuboid([d-gap*2,d,5]);
           }
     }
    
    //lid
   module lid(){
     up(z+2.2+5){
         difference(){
       cuboid([espX+2*wall,espY+2*wall,wall], fillet = 2, edges=EDGES_Z_ALL);for(i=[-1,1]){
    translate([i*(espX/2-1.5),espY/2-2,-2])cylinder(d=2.5,h=5);
    left(5)fwd(espY/2-10)switch();
       }
     }
     poslid=0.1;
     difference(){
     union(){
     translate([0,-espY/2+wall+poslid,-2.5-wall/2])cuboid([espX-3,wall*2,5]);
     translate([-espX/2+1.5,-(espY)/2+0.3+poslid,-3.5])rotate([0,90,0])cylinder(h=espX-3,d=2);
     }translate([-5,-(espY)/2+0.3+poslid,-3.5])cuboid(10);
     }
     h=8.7;
     translate([-0.8-4.2,-(espY)/2+poslid+3.6,-h/2])cyl(h=h,d=3);
       
       }
   }
   lid();
    
}

module mount(x_d){
       dRod = 10.5;
       x=20;
       y=30;
       z=20;
       l = 11;
       translate([-x_d+4.2,0,x/2])difference(){
         cuboid([x,y,z],fillet=3,edges = EDGES_Z_LF);
          scale([1,1,1.05])translate([2.5,y/2+0.5,0])rotate([90,0,0])cylinder(d = dRod, h = y+1);
          translate([2.5,0,-y/2])rotate([0,0,0])cylinder(d = dRod, h = y+1);

          translate([-x/2+2,0,0])rotate([90,0,90]){
            rotate([0,0,90])cylinder(h = 3.5, d=8, $fn = 6);
            translate([0,l/2,1.7])cube([7,l,3.5],center = true);
           translate([0,0,-2.5])cylinder(d = 5, h =10);
          }
       }
    }
    
difference(){
    hull();
    *down(2)translate([-25 ,0,-1])cube(50);
}
    right(4)down(1)mount(espX+2);
    if(mc){
       color("red")translate([-15.4,15,20])lolin();
    }