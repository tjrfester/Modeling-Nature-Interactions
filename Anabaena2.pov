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

This worm is created in some kind of random walk. We start at a given position by inserting a sphere at this position. In this example here, the worm is then constructed along the z-axis. So the next
sphere is placed in a given distance on the z-axis and then rotated around the y and x-axis by small, random angles. (Between -20 and 20 degrees in both cases.) This new position then becomes the starting point for defining 
the next position, for the next sphere. Angles from subsequent steps are added up for generating a realistic random, worm-like structure.  */ 

//-----------------------------------Scene settings (Camera, light, background)-------------------------------------------------

global_settings {
    assumed_gamma 1.0
    max_trace_level 5
}

#declare Camera = camera {
    location  <110, -4, 0>
    right     x*image_width/image_height
    look_at   <0, -4,  0>
}

camera {Camera}

background { 
    color rgb <0, 0, 0> 
}

// create a regular point light source
light_source {
    0*x                  // light's position (translated below)
    color rgb <1,1,1>    // light's color
    translate <500, 500, -500>
} 

light_source {
     0*x                  // light's position (translated below)
    color rgb <1,1,1>    // light's color
    translate <500, -500, -500>
}  /*




//Das Koordinatensystem

cylinder { <-1000, 0, 0>, <1000, 0, 0>, 0.1
  pigment {

    color rgb <1,0,0>     // solid color pigment
  }
}

cylinder { <0, -1000, 0>, <0, 1000, 0>, 0.1 
  pigment {

    color rgb <0,1,0>     // solid color pigment
  }
}

cylinder { <0, 0, -1000>, <0, 0, 1000>, 0.1 
  pigment {

    color rgb <0,0,1>     // solid color pigment
  }
} 

        */



// Definition of textures ---------------------------------------------------------------
  
#declare Normal1 =     normal {
    dents 2.8         // any pattern optionally followed by an intensity value [0.5]
    turbulence 1.3   // some turbulence
    scale 0.1       // any transformations
}

#declare Normal2 =     // texture component
normal {
    agate 2.8         // any pattern optionally followed by an intensity value [0.5]
    turbulence 1   // some turbulence
    scale 1.5       // any transformations
}    

#declare Normal3 =     normal {
    bumps 0.8         // any pattern optionally followed by an intensity value [0.5]
    scale 0.01       // any transformations
} 
  


#declare Texturhuelle1 =  texture{
    pigment {          // (---surface color---)
        dents       // some pattern
        color_map {      // color map
            [0.05 color rgb <0.,0.3,0>]
            [0.1 color rgb <0.1,0.5,0>]
            [0.6 color rgb <0.1,1,0.>]
        }
        turbulence 1.3   // some turbulence
        scale 0.1    // transformations
    } 
// texture component
    normal {
        average
        normal_map {
            [1, Normal1 ]
            [1, Normal2 ]
        }
    } 
// control an object's surface finish
    finish {
        ambient 0.2          // ambient surface reflection color [0.1]
        diffuse 0.6          // amount [0.6]
        brilliance 1.0       // tightness of diffuse illumination [1.0]
        specular 0.5       // amount [0.0]
        metallic 0.9  // give highlight color of surface
    } // finish
}


#declare Texturhuelle3 =  texture{
    pigment {
        color rgb <0.3,0.6,0>     // solid color pigment
    }
    normal {
        bumps 0.8         // any pattern optionally followed by an intensity value [0.5]
        turbulence 1   // some turbulence
        scale 0.045       // any transformations
    }    
    finish {
        ambient 0.1          // ambient surface reflection color [0.1]
        diffuse 0.6          // amount [0.6]
        brilliance 1.0       // tightness of diffuse illumination [1.0]
        phong 0.8          // amount [0.0]
        metallic 0.9  // give highlight color of surface
    } // finish
}

  //-----------------------Huelle------------------------------------------

#declare Huelle =  sphere { 
    < 0,   0,    0>, 1.2 
    scale <1.4, 1.4, 1.2>
    scale 0.7
}   



#declare Huelle2 = object {
    Huelle
    scale 0.9
}

#declare Huelle3 = object {
    Huelle
    scale 0.9
} 

  
#declare chance1a = seed (3);
#declare chance1b = seed (3);
  
#declare chance2 = seed (7);

#declare tickerFaden = 0;
#while (tickerFaden < 30)


//Loop for calculation of positions 


    #declare Number = floor(50 + 30 * rand(chance2));
    #declare Positions = array[Number];
    #declare AngleXArray = array[Number];                   //Array for angles of rotation around x-axis
    #declare AngleYArray = array[Number];                   //Array for angles of rotation around y-axis
    #declare Distance0 = 1.26;
    #declare AngleX = 0;
    #declare AngleY = 0; 
    #declare Start = <0, 0, 0>;
    #declare P2 = Start;
    #declare Hetero = 0; 

    #declare ticker = 0;
    #while (ticker < Number)

        #if (rand(chance1a)<0.07)                            //if-statement for inserting larger Heterocysts; Distances have to be enlarged for two subsequent steps. 

            #declare Hetero = 1; 
            #declare Distance = 1.5 * Distance; 

        #else

            #if (Hetero > 0)

                #declare Hetero = 0; 
                #declare Distance = 1.5 * Distance0; 

            #else

                #declare Hetero = 0; 
                #declare Distance = Distance0; 

            #end
        #end
  

        #declare P1 = Start + <0, 0, Distance>;
        #declare P1 = vrotate (P1, <AngleX, 0, 0>);
        #declare P1 = vrotate (P1, <0, AngleY, 0>); 
        #declare PEnd = P1 + P2;

        #declare Positions[ticker] = PEnd; 
        #declare AngleXArray[ticker] = AngleX; 
        #declare AngleYArray[ticker] = AngleY; 

        #declare P2 = PEnd;
        #declare AngleX = AngleX + 40*(rand(chance2)-0.5);
        #declare AngleY = AngleY + 40*(rand(chance2)-0.5);

    #declare ticker = ticker + 1;
    #end 




 
//The actual structure

    #declare chance1 = seed (3);                          //These random number have to be equivalent to the random variable chance1 from above!


    union {

    #declare PreAngleX = 0;
    #declare PreAngleY = 0;

        #declare ticker = 0;
        #while (ticker < Number)

            #declare P1 = Positions [ticker];
            #declare AngleX = AngleXArray [ticker];                                 //Values for positions and angles are taken from the arrays.
            #declare AngleY = AngleYArray [ticker];                                 //Values for positions and angles are taken from the arrays.


            #if (ticker > 0)
                #declare PreAngleX = AngleXArray [ticker-1]; 
                #declare PreAngleY = AngleYArray [ticker-1]; 
            #else
                #declare PreAngleX = 0;                                        //Here angles from the position before are taken from the arrays; if-statements avoids working with undefined values for ticker. 
                #declare PreAngleY = 0; 
            #end

            #declare AngleX = (AngleX + PreAngleX)/2;                          //Actual angles are calculated as the mean between the current angle and the angle of the precursor element.
            #declare AngleY = (AngleY + PreAngleY)/2; 
        
            #if (rand(chance1b)<0.07)                                           //if-statement for inserting larger heterocysts.

                object {
                    Huelle3
                    scale <1.5, 1.5, 1.7>
                    rotate <AngleX, 0, 0>
                    rotate <0, AngleY, 0>
                    translate P1 
                    texture {
                        Texturhuelle3
                    }
                } 

            #else

                object {
                    Huelle
                    rotate <AngleX, 0, 0>
                    rotate <0, AngleY, 0>
                    translate P1 
                    texture {
                        Texturhuelle1
                    }
                } 
            #end
  
        #declare ticker = ticker + 1;
        #end 
    
    translate <0, -30 * rand(chance2), -80 +120 *rand(chance2)>
}


#declare tickerFaden = tickerFaden + 1;
#end  
