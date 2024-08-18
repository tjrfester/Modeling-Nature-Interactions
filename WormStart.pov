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
the next position, for the next sphere. Angles from subsequent steps are added up for generating a realistic random, worm-like structure. (Here spheres are separated to demonstrate the underlying principle. 
The next example will show a blob generated from these spheres. */ 

//-----------------------------------Scene settings (Camera, light, background)-------------------------------------------------

global_settings {
    assumed_gamma 1.0
    max_trace_level 5
}

#declare Camera = camera {
    location  <12, 0.1, 0>
    look_at   <0, 0,  0>
}

camera {Camera}

sky_sphere {
    pigment {
        gradient y
        color_map { 
            [0.0 color rgb <1,1,1>] [0.5 color rgb <1,1,1>] [1.0 color rgb <1,1,1>] 
        }
        scale 2
        translate -1
    }
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

cylinder { <-1000, 0, 0>, <1000, 0, 0>, 0.01 
  pigment {

    color rgb <1,0,0>     // solid color pigment
  }
}

cylinder { <0, -1000, 0>, <0, 1000, 0>, 0.01 
  pigment {

    color rgb <0,1,0>     // solid color pigment
  }
}

cylinder { <0, 0, -1000>, <0, 0, 1000>, 0.01 
  pigment {

    color rgb <0,0,1>     // solid color pigment
  }
} 

       */


//---------------------------Objects-----------------------------------------------------------------
#declare chance1 = seed (3);


// Definition of normals-----------------------------------------------------------------------

#declare Normal1 =     normal {
    crackle 2.5         // any pattern optionally followed by an intensity value [0.5]
    scale 0.02       // any transformations
}



#declare Normal2 =     normal {
    bumps 0.8         // any pattern optionally followed by an intensity value [0.5]
    scale 0.15       // any transformations
}  

// Definition of worm texture---------------------------------------------------------------

  
#declare TexturWurm = texture{
    pigment {
        color rgb <255/255,102/255,0/255>    // solid color pigment
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
        phong 0.5          // amount [0.0]
        phong_size 80      // (1.0..250+) (dull->highly polished) [40]
    } // finish

}  

  
#declare TexturStart = texture{
    pigment {
        color rgb <0/255, 208/255, 255/255>     // solid color pigment
    }
// control an object's surface finish
    finish {
        ambient 0.2          // ambient surface reflection color [0.1]
        diffuse 0.6          // amount [0.6]
        brilliance 1.0       // tightness of diffuse illumination [1.0]
        phong 0.5          // amount [0.0]
        phong_size 80      // (1.0..250+) (dull->highly polished) [40]
    } // finish
}  

  
  



//Loop for calculation of positions

#declare Number = 10;
#declare Positions = array[Number];
#declare Distance = 0.9;
#declare AngleX = 0;
#declare AngleY = 0; 
#declare Start = <0, 0, 0>;
#declare P2 = Start;

#declare ticker = 0;
#while (ticker < Number)

    #declare P1 = Start + <0, 0, Distance>;
    #declare P1 = vrotate (P1, <AngleX, 0, 0>);
    #declare P1 = vrotate (P1, <0, AngleY, 0>); 
    #declare PEnd = P1 + P2;

    #declare Positions[ticker] = PEnd; 

    #declare P2 = PEnd;
    #declare AngleX = AngleX + 40*(rand(chance1)-0.5);
    #declare AngleY = AngleY + 40*(rand(chance1)-0.5);

#declare ticker = ticker + 1;
#end 




 
//The actual structure (a blob)

blob {
    // threshold (0.0 < threshold <= StrengthVal) surface falloff threshold #
    threshold 0.6
    
    #declare ticker = 0;
    #while (ticker < Number)

        #declare P1 = Positions [ticker];

        sphere { 
            <0, 0, 0>, 0.35, 1
            translate P1
        }  
  
    #declare ticker = ticker + 1;
    #end
 
texture{ 
    TexturStart
    }
translate <0, 0, -4>
  
}
