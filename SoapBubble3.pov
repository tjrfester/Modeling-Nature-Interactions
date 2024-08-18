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
Cells are surrounded by a lipid bilayer, just like soap bubbles. For this reason their shape is similar to the shape of soap bubbles, or clusters of soap bubbles and also for 
this reason we start modeling the shape of cells by modeling the shape of soap bubbles. For this purpose we are using negatively interacting blobs. This way we obtain closely adjacent but clearly
separated bubbles. Hollow soap bubbles are obtained by substracting slightly 
smaller versions of the initial blobs from these initial blobs and by applying a transparent and iridescent texture to these structures.
*/


//-----------------------------------Scene settings (Camera, light, background)-------------------------------------------------

global_settings {
    assumed_gamma 1.0
    max_trace_level 5
}



#declare Ortho = camera {
    orthographic
    location <-3, 0, 7>    // position & direction of view
    look_at  <0,0,0>
    right 0.2*16*x            // horizontal size of view
    up 0.2*9*y               // vertical size of view
}



camera {
	Ortho
}


//background { 
    //color rgb <1, 1, 1> 
//}


// create a regular point light source
light_source {
    0*x                  // light's position (translated below)
    color rgb <1,1,1>    // light's color
    translate <0,0,0>
}  
// create a regular point light source
light_source {
    0*x                  // light's position (translated below)
    color rgb <1,1,1>    // light's color
    translate <0,10,-30>
}  
  /*

//The coordinate system

cylinder { 
    <-1000, 0, 0>, <1000, 0, 0>, 0.01 
    pigment {
        color rgb <1,0,0>     // solid color pigment
    }
}

cylinder { 
    <0, -1000, 0>, <0, 1000, 0>, 0.01
    pigment {
        color rgb <0,1,0>     // solid color pigment
    }
}

cylinder { 
    <0, 0, -10000>, <0, 0, 10000>, 0.01 
    pigment {
        color rgb <0,0,1>     // solid color pigment
  }
}

*/
//---------------------------Objects-----------------------------------------------------------------

difference {
    union{
        blob {
            threshold 0.54
            sphere { 
                < 0,   0,    0>, 1, 1 
            }
            sphere { 
                <-0.6,  0, 0>, 0.52, -1 
                rotate <0, 0, 30>
            }
            sphere {    
                <-0.6,  0, 0>, 0.52, -1 
                rotate <0, 0, -30>
            }
        }
        blob {
            threshold 0.54
            sphere { 
                < 0,   0,    0>, 0.52, -1 
            }
            sphere { 
                <-0.6,  0, 0>, 1, 1 
                rotate <0, 0, 30>
            }
            sphere { 
                <-0.6,  0, 0>, 0.52, -1 
                rotate <0, 0, -30>
            }

        }

        blob {
            threshold 0.54
            sphere { 
                < 0,   0,    0>, 0.52, -1 
            }
            sphere { 
                <-0.6,  0, 0>, 0.52, -1 
                rotate <0, 0, 30>
            } 
            sphere {    
                <-0.6,  0, 0>, 1, 1 
                rotate <0, 0, -30>
            }
        }
    }



    union{

        blob {
            threshold 0.59
            sphere { 
                < 0,   0,    0>, 1, 1 
            }
            sphere { 
                <-0.6,  0, 0>, 0.52, -1 
                rotate <0, 0, 30>
            }
            sphere { 
                <-0.6,  0, 0>, 0.52, -1 
                rotate <0, 0, -30>
            }
        }
        blob {
            threshold 0.59
            sphere { 
                < 0,   0,    0>, 0.52, -1 
            }
            sphere { 
                <-0.6,  0, 0>, 1, 1 
                rotate <0, 0, 30>
            }
            sphere { 
                <-0.6,  0, 0>, 0.52, -1 
                rotate <0, 0, -30>
            }
        }
        blob {
            threshold 0.59
            sphere { 
                < 0,   0,    0>, 0.52, -1 
            }
            sphere { 
                <-0.6,  0, 0>, 0.52, -1 
                rotate <0, 0, 30>
            } 
            sphere {    
                <-0.6,  0, 0>, 1, 1 
                rotate <0, 0, -30>
            }
        }
    }
    pigment {
        color rgbt <0,0,0.4,0.9>     // solid color pigment
    }
    finish {
        ambient 0.1          // ambient surface reflection color [0.1]
        diffuse 0.6          // amount [0.6]
        brilliance 1.0       // tightness of diffuse illumination [1.0]
        specular 0.5       // amount [0.0]
        metallic 0.95  // give highlight color of surface
        irid {               // Iridescence (Newton's thin film interference)
            0.08               // intensity
            thickness 0.5    // film's thickness [0.0]
            turbulence 0.3   // film's thickness turbulence
        }
    } // finish
}

