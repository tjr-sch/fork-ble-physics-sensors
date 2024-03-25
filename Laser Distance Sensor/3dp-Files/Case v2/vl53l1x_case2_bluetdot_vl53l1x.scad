include<CASE/Case2.scad>

x = 30;
y = 60;//default  = 52
z = 35;
modules = 0;
case([x,y,z],part="top",reset = false, button=true);
down(z+20)case([x,y,z],part="bottom",thread=true);
if(modules){
    translate([-11.3,16.6,-27.4])color("grey")rotate([0,180,90])import("lolin32_lite.stl");
    }
module sensor(){
     if(modules)color("tomato")translate([13,-4,20])rotate([0,180,0])import("VL53L1X_bluedot.stl");

    up(3.7)difference(){
        d=8;
        s=5;
        union(){
         case([x,y,z],part = "plate",explode=0);
         for(i=[1,-1]){
         translate([i*10.5,0,13.8])ycyl(d=4,h=3,);
         translate([i*10.5,0,-0.5])ycyl(d=2.5,h=3,);

        }//end difference
        }
        back(1)union(){
         translate([0,0,9.2])cuboid([s,10,d],rounding=1,except=[FRONT,BACK]);
         }//end union
        for(i=[1,-1]){
         translate([i*10.5,0,13.8])ycyl(d=2,h=4,);
        }//end difference
    }
//end if
}//end front     
module plate(){
 difference(){
   case([x,y,z],cutheight=2,part="plate",snap=2.5,explode=0);
   translate([-7.7,-0.1,-5.8])cuboid([7,3,5.5],rounding=1,except=[FRONT,BACK],anchor=FRONT);
   translate([7.3,-0.1,-7.5])cuboid([10.5,3,4.5],rounding=1,except=[FRONT,BACK],anchor=FRONT);
   }//end difference
   }//end frontplate
 
*down(18)fwd(50)plate();
*back(50)sensor();