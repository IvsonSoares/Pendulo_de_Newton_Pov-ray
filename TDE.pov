#include "colors.inc"   
#include "textures.inc"  
#include "stones.inc"
#include "transforms.inc"

camera {
  
  location<5,5,-12>
  look_at <0,0,10>

}                

light_source { <2,4,-6>      White area_light <8, 0, 0>, <0, 8, 0>, 3, 3  adaptive 0 jitter }
light_source { <0,0,0>       White  parallel point_at <10,0,20> }
light_source { <-10,-20,10>  White spotlight  point_at <-20, 0, 0>  tightness 0 radius 0 falloff 10} 

fog { distance 1500  rgbf <.1,.1,.1,.1> }
object{ plane {y,-1.3} pigment { checker Black Gray10} }
   

// inicio bola   
#declare Bola = union { 
#declare MyRadius = 30;
#declare YPosition = 0;
#declare N_Balls = 20;
#declare Raio = 18; 
#declare YCount = 0;      // lat
#declare BallCount = 0;  // long  

#while (YCount < 100)  

  
  #while (BallCount < 2*pi)   
   
    #declare XPosition = Raio*sin(BallCount)*cos(YCount);
    #declare YPosition = Raio*sin(BallCount)*sin(YCount);
    #declare ZPosition = Raio*cos(BallCount);
    #declare WhiteBall = sphere { <XPosition, YPosition, ZPosition>, MyRadius pigment { Silver }  finish {  Metal ambient .1 } }  ;
    #declare BallCount = BallCount + 2*pi/N_Balls;
                       
    object { WhiteBall translate <0,0,0> scale <0.01,0.01,0.01>}  
                        
   #end     
   #declare YPosition = YPosition + 3;  
   #declare BallCount = 0;
   #declare YCount = YCount + 1;
  #end  
  
  rotate <90,0,0>
}  // end bola
     
// corrente
#declare Corrente = union {

#declare Esferas = sphere { <0,1,0>, .1 pigment { Silver } finish { Metal ambient .1  diffuse .5}  }

#for(i, 0, 11, .5)

object {Esferas  translate<0,i,0> }
object {Esferas  translate<0,i + 1,0> scale .5 } 
object {Esferas  translate<0,i + 6,0> scale .5 }
object {Esferas  translate<0,i + 12,0> scale .5 }

#end
scale .5
}   // end corrente    

// inicio corrente e bola
#declare Corrente_Bola = union {

object { Corrente rotate <-30,0,0>}
object { Bola translate <0,0,0>}
object { Corrente rotate <30,0,0>}
                                
} // end corrente_bola

// conjunto das bolas
#declare CoordX   = 0;
#declare CoordY   = 0;
#declare CoordZ   = 0; 
#declare rotation = 0;

object {Corrente_Bola translate <CoordX + 0,CoordY,CoordZ>}
object {Corrente_Bola translate <CoordX + 1,CoordY,CoordZ>}
object {Corrente_Bola translate <CoordX + 2,CoordY,CoordZ>}


// inicio teto  

#declare Teto = intersection { 

prism { -1.00 ,1.00 , 4
        <-1.00, 0.00>, 
        < 1.00, 0.00>, 
        < 0.00, 1.50>,
        <-1.00, 0.00>  
        rotate<-90,-90,0>   
      }

prism { -1.00 ,1.00 , 4
       <-1.00, 0.00>, 
       < 1.00, 0.00>, 
       < 0.00, 1.50>, 
       <-1.00, 0.00>   
       rotate<-90,0,0> 
       scale<1,1,-1>   
      }


  scale <3.5, 2, 6> 
  translate<1, 5.35, 2>
  texture { T_Grnt15  finish { phong 0.5 } scale 1 }  
}
// fim teto 
 
  
// inicio hastes
#declare Haste = union { 

cylinder { <0,0,0>, <0,6,0>, .2}
cylinder { <6,0,0>, <6,6,0>, .2}
cylinder { <-5.9,-.1,0>, <-5.9,6.1,0>, .2 rotate <0,0,-90>}

texture { T_Grnt15  finish { phong 0.5 } scale 1 } 
}// fim das hastes




// ambas hastes
object { Haste  translate <-2,-.6,-2.9> }
object { Haste  translate <-2,-.6,-2.9 + 6> }
object { Teto }




// base
#declare Base =  box { <0,0,0>, <8,.5,8> texture { T_Grnt15  finish { phong 0.5 } scale 1 }}
                
object { Base translate <-3,-1.2,-3.5> }
// fim da base

// =========================ANIMACAO=================================================        


// clock efeito       
#declare Angle = 0;
#declare Angle2 = 0;

#switch(clock)
   #range (0,44)
         #declare Angle = clock;
   #break
      #range(45, 85)
         #declare Angle = 45 - (clock - 45);
   #break
      #range (86, 126)
         #declare Angle2 = (clock - 86);
   #break 
      #range (127, 168)
         #declare Angle2 =40 - (clock - 127);  
  #break
    
#end 

//


object {Corrente_Bola translate <CoordX - 1, CoordY, CoordZ> Rotate_Around_Trans(<0,0,-Angle> , <-1,5,0>) }
object {Corrente_Bola translate <CoordX + 3,CoordY,CoordZ> Rotate_Around_Trans(<0,0,Angle2> , <2.5,5,2>)}
// fim do clock efeito
//#if(clock < 20)

//#declare rotation = rotation + clock;
//object {Corrente_Bola translate <CoordX - 1, CoordY, CoordZ> rotate z*-rotation*3 translate <CoordX - .5 -rotation/6, CoordY + .2, CoordZ> }
//object {Corrente_Bola translate <CoordX + 3,CoordY,CoordZ>}

//#elseif (clock >= 20 & clock < 30)   

//#declare rotation = rotation - clock/10;
//object {Corrente_Bola translate <CoordX - 1, CoordY, CoordZ> rotate z*-rotation*2 translate <CoordX - .5 -rotation/17, CoordY + .2, CoordZ> }
//object {Corrente_Bola translate <CoordX + 3,CoordY,CoordZ>}

// rotation manual
//============================LADO OPOSTO DAS ESFERAS=====================================================  

//#elseif(clock >= 30 )  

//#declare rotation = rotation + clock;
//object {Corrente_Bola translate <CoordX - 1, CoordY, CoordZ>}
//object {Corrente_Bola translate <CoordX + 3,CoordY,CoordZ> rotate z*rotation translate <CoordX + .5 + rotation/10, CoordY - .2, CoordZ> }

//#elseif (clock > 40)
  
//#declare rotation = rotation + clock;
//object {Corrente_Bola translate <CoordX - 1, CoordY, CoordZ>}
//object {Corrente_Bola translate <CoordX + 3,CoordY,CoordZ> rotate z*-rotation translate <CoordX - .5 -rotation/17, CoordY + .2, CoordZ>}
//#end


// final do conjunto             