// Persistence of Vision Ray Tracer Scene Description File
// File: SnailShell.pov

#version 3.6; // current version is 3.8

/* 
Information on Pov-Ray:
 
My personal introduction into Pov-Ray was the excellent book "3D-Welten, professionelle Animationen und fotorealistische Grafiken mit Raytracing" from 
Toni Lama by Carl Hanser Verlag München Wien, 2004. Apart of that I recommend the Pov-Ray-homepage (http://www.povray.org).

Further information on Pov-Ray can be found at https://sus.ziti.uni-heidelberg.de/Lehre/WS2021_Tools/POVRAY/POVRAY_PeterFischer.pdf,  
https://wiki.povray.org/content/Main_Page, https://de.wikibooks.org/wiki/Raytracing_mit_POV-Ray or, in german language, here: https://www.f-lohmueller.de/pov_tut/pov__ger.htm
*/ 
 
/*
---------------------------------------------------Modeling approach---------------------------------------------- 
To generate a more or less standard plant tissue, in a first step a relatively regular 3D-array of points is produced. In this example I am watching from the x-axis and I am creating three layers of 
points in x-direction, 7 layers in z-direction and 12 layers in y-direction. Distance of points is larger in z- (3.5) when compared to x- and y-direction (1.5). This means we will be dealing with somewhat 
elongated cells. A small amount of variance is added to the position. Unfortunately my approach only works with pretty small amounts of variance... Every second column of cells (in z-direction is shifted
by half of a cell diameter in y-direction and every second row in x-direction as well. 

As in the earlier examples, each position is filled by an individual blob, where spheres representing the surrounding cells are substracted from the central sphere. (Representing the pressure 
adjacent cells are exerting on each other.) The positions of these surrounding cells are found by searching the array containing the points created in the first step for points located in a certain maximum distance 
to the central position. 

A part of the structure of the cellular blobs is cut by a box to show internal appearance. 
//-----------------------------------------------------------------------------------------------------------------
*/

//-----------------------------------Scene settings (Camera, light, background)-------------------------------------------------

global_settings {
    assumed_gamma 1.0
    max_trace_level 5
}

#declare Hauptkamerax = camera {
    location  <-21, 12, 0>
    right     x*image_width/image_height
    look_at   <0, 0,  0>
    rotate <0, 0, 0>
}

camera {
    Hauptkamerax
}

// create a regular point light source
light_source {
    0*x                  // light's position (translated below)
    color rgb <1,1,1>    // light's color
    translate <-20, 40, 80>
}
light_source {
    0*x                  // light's position (translated below)
    color rgb <1,1,1>    // light's color
    translate <-30, 7, 0>
}
  
background { 
    color rgb <1, 1, 1> 
}
  
//--------------------------Objects---------------------------------------------


//Initiation of parameters

#declare zNumber =10;
#declare yNumber =12;
#declare xNumber =10;
#declare Number =  xNumber*yNumber*zNumber;
#declare Variance =0.4;
#declare P0 = <-3.5, -9.7, -25.>; 
#declare chance1 = seed (13);
#declare chance2 = seed (15);
#declare chance3 = seed (23);
#declare Positions = array [Number];
#declare Counter = 0; 



//Definition of points  

#declare ticker3 = 0; 
#while ( ticker3 <yNumber)

    #declare ticker2 = 0; 
    #while ( ticker2 <zNumber)

        #declare ticker = 0; 
        #while ( ticker <xNumber)

            #declare var1 = rand(chance1);
            #declare var2 = rand(chance2);
            #declare var3 = rand(chance3);

            #declare xDistance = 1.5;
            #declare yDistance = 1.5;
            #declare zDistance = 3.5;

//if-Klausel for shifting every second column of cells ( in x- and z-direction) for half a cell diameter in y-direction.
            #if (mod(ticker, 2) >0) 

                #if (mod(ticker2, 2) >0) 

                    #declare P1=<P0.x + (ticker) * xDistance + Variance * var1, P0.y + (ticker3) * yDistance + Variance * var2, P0.z + (ticker2) * zDistance + zDistance/2 + Variance*var3>;

                #else

                    #declare P1=<P0.x + (ticker) * xDistance + Variance * var1, P0.y + (ticker3) * yDistance + yDistance/2  + Variance * var2, P0.z + (ticker2) * zDistance + zDistance/2 + Variance*var3>;

                #end

            #else

                #if (mod(ticker2, 2) >0) 

                    #declare P1=<P0.x + (ticker) * xDistance + Variance * var1, P0.y + (ticker3) * yDistance + yDistance/2 + Variance * var2, P0.z + (ticker2) * zDistance + Variance*var3>;

                #else

                    #declare P1=<P0.x + (ticker) * xDistance + Variance * var1, P0.y + (ticker3) * yDistance + Variance * var2, P0.z + (ticker2) * zDistance + Variance*var3>;

                #end
            #end

            #declare Positions [Counter] = P1;
            #declare Counter = Counter + 1; 
 
        #declare ticker = ticker + 1; 
        #end

    #declare ticker2 = ticker2 + 1; 
    #end
 
#declare ticker3 = ticker3 + 1; 
#end
  
                                          //Now the structure is built according to the points defined above.

difference {

    union {   //cells are put together into a union

        #declare ticker = 0; 
        #while ( ticker < Number)

            #declare P1 = Positions [ticker];//Der jeweilige Punkt
            #declare RadiusVal   = 1.5; // (0 < RadiusVal) outer sphere of influence on other components
            #declare StrengthVal = 1.0; // (+ or -) strength of component's radiating density

            #declare RadiusVal2   = 1.2; // (0 < RadiusVal) outer sphere of influence on other components
            #declare StrengthVal2 = -0.8; // (+ or -) strength of component's radiating density

            blob {
                threshold 0.3
                sphere { 
                    <0, 0, 0>, RadiusVal, StrengthVal
                    scale <1, 1, 2>
                    translate < P1.x, P1.y, P1.z> 
                }
  
                #declare ticker2 = 0;                              //Here comes the loop searching the array for adjacent cells
                #while (ticker2 < Number) 
                                                   //Positions of these cells are caled P2
                    #declare P2 = Positions [ticker2]; 
                    #declare Distance = vlength (P2 - P1);

                    #if (Distance > 0)                                 //This excludes the Position P1 itself
                        #if (Distance < 3.7)                               //And this excludes all Positions to far away from P1

                            sphere { 
                                <0, 0, 0>, RadiusVal2, StrengthVal2     //Sphere on these position are substracted from the central sphere
                                scale <1, 1, 2>
                                translate P2
                            } 

                        #else
                        #end
                    #else
                    #end

                #declare ticker2 = ticker2 + 1; 
                #end

                texture {
                    pigment {
                        color rgb <0.2,0.7,0>     // solid color pigment
                    }
                    normal {
                        bumps 1        // any pattern optionally followed by an intensity value [0.5]
                        bump_size 0.5   // optional
                        scale 0.1       // any transformations
                    }
                    finish {
                        ambient 0.2         // ambient surface reflection color [0.1]
                        diffuse 0.6          // amount [0.6]
                        brilliance 1       // tightness of diffuse illumination [1.0]
                        specular 0.01       // amount [0.0]
                        roughness 0.9     // (~1.0..0.0005) (dull->highly polished) [0.05]
                    } // finish


                }
            }

        #declare ticker = ticker + 1; 
        #end

    }

    box { 
        <2.5, -4, -3>, <-20, 20, 20> 
        texture {
            pigment {
                color rgb <1,0.7,0.>     // solid color pigment
            }
            normal {           // (---surface bumpiness---)
                crackle 3    // for use with normal{} (0...1 or more)
                scale 0.05
            }
            finish {
                ambient 0.3          // ambient surface reflection color [0.1]
                diffuse 0.6          // amount [0.6]
                brilliance 1.0       // tightness of diffuse illumination [1.0]
                specular 0.8       // amount [0.0]
                metallic 1  // give highlight color of surface
            } // finish
        }


    }    


    rotate <0, -45, 0>
} 
