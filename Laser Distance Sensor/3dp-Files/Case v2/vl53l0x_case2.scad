include<CASE/Case2.scad>
x = 40;
y = 53;
z = 35;
lolinspace = 9;
sidewalltext = "L-D_#1";

case([x,y,z],part="top",reset = 0, button=true,lolinspace=lolinspace,cutheight = 6,lolinx=-4,charge_view=1,power_view = 1);
down(50)difference(){
   case([x,y,z],part="bottom",lolinx=-4,thread=true,lolinspace=lolinspace,cutheight = 6);
   #translate([x/2+1.6,0,7])rotate([90,0,90])linear_extrude(0.4)text(sidewalltext,size = 7,halign="center");
   }
down(25)fwd(50)plate();
down(25)back(50)sensor();

module sensor(){
   // translate([-19.7,3,26.5])color("red")rotate([-90,0,0])import("VL53L0X.stl");

    up(3.7)difference(){
        d=6;
        s=7;
        union(){
         case([x,y,z],part = "plate",explode=0,switch=0);
         up(12)fwd(2)case([x-15,y,z-20],part = "plate",explode=0);
         }

        back(1)union(){
         up(10)cuboid([s,10,d],rounding = 1, except=[FRONT,BACK]);
         up(4)fwd(2)cuboid([18,2,3]);
         }//end union
        for(i=[1,-1]){
         translate([i*9.7,-4,7.5])ycyl(d=2,h=8,anchor=FRONT);
         //translate([i*9.7,-2,7.5])ycyl(d=4,h=3,anchor=FRONT);

        }//end difference
    }
//end if
}//end front     
module plate(jst=false){
 difference(){
    case([x,y,z],cutheight=2,part="plate",snap=2.5,explode=0,lolinspace=lolinspace,lolinx=-4,jst=0,usbC = 1,switchpos=[0,7],switch=1);
    translate([6,0.2,12.5])ycyl(d=2,h=0.4);
    
    
   }//end difference
   }//end frontplate
 


