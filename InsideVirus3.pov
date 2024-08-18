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

This file uses a direct approach for distributing elements evenly and randomly on the surface of a given object (here a virus) and align them to their normals with respect to this surface.  

The particle itself is produced by randomly distributing elements in a sphere-like way and fusing them into a blob.

Elements are distributed randomly and evenly around this structure. This is achieved by first distributing them evenly along a cylinder with the same radius as the sphere and with this radius has height. 
Subsequently, positions are projected onto the sphere, before being rotated randomly around the cylinder's axis. 

In the next step, positions will close in onto the sphere step-wise until they reach the particle's surface. This is tested by the inside-function. 
Finally they will be aligned according to the particle's normals. 
*/ 
                
//-----------------------------------Scene settings (Camera, light, background)-------------------------------------------------

global_settings {
    assumed_gamma 1.0
    max_trace_level 5
}


// orthographic projection using parallel camera rays
// Could be used to render a planar image map, for example
#declare Ortho = camera {
    orthographic
    location <-3, 0, -7>    // position & direction of view
    look_at  <0,0,0>
    right 1.*16*x            // horizontal size of view
    up 1.*9*y               // vertical size of view
}



camera {
	Ortho
}


background {
	color rgb <1, 1, 1>
}


// create a regular point light source
light_source {
    0*x                  // light's position (translated below)
    color rgb <1,1,1>    // light's color
    translate <-10, 10, -30>
} 
light_source {
    0*x                  // light's position (translated below)
    color rgb <0.6,0.6,0.6>    // light's color
    translate <30, 10, -10>
}  


/*

//Das Koordinatensystem

cylinder { 
	<-1000, 0, 0>, <1000, 0, 0>, 1 
  	pigment {
    		color rgb <1,0,0>     // solid color pigment
  	}
}

cylinder { 
	<0, -1000, 0>, <0, 1000, 0>, 1 
  	pigment {
    		color rgb <0,1,0>     // solid color pigment
  	}
}

cylinder { 
	<0, 0, -1000>, <0, 0, 1000>, 1 
  	pigment {
    		color rgb <0,0,1>     // solid color pigment
  	}
} 

*/

//---------------------------Objects-----------------------------------------------------------------       

#declare chance1 = seed (5); //Initiation of random numbers

#declare Virus = blob {      //Declaration of the particle
	threshold 0.6
	#declare ticker = 0; 
	#while (ticker < 250)
		#declare R = 2.3; 
		#declare P1 = <R *rand(chance1), 0, 0>; 		//Distribution along the radius
		#declare H = R*(2*rand(chance1) - 1); 			//Distribution on a cylinder of height and radius R
		#declare Angle = degrees(acos(H/R)); 		
		#declare P1 = vrotate (P1, <0, 0, Angle>);		//Projection onto the sphere
		#declare P1 = vrotate (P1, <360*rand(chance1), 0, 0>);	//random rotation around the second spherical axis.
		sphere { 
			<0, 0, 0>, 1.6, 1
 			translate P1   
   			texture{ 	
				pigment {
					color rgb <0,208/255,1>
				}
         			finish {
                        ambient 0.1          // ambient surface reflection color [0.1]
                        diffuse 0.6          // amount [0.6]
                        brilliance 1       // tightness of diffuse illumination [1.0]
                        specular 0.3     // amount [0.0]
                        roughness 0.03     // (~1.0..0.0005) (dull->highly polished) [0.05]
				}
			}
		} 

	#declare ticker = ticker + 1; 
	#end 
}

object {
	Virus
}


//Elements to be arranged on the virus's surface  


#declare GP1 = blob {
    // threshold (0.0 < threshold <= StrengthVal) surface falloff threshold #
    threshold 0.2
    sphere { 
        < 0,   0,    0>, 4, 1 
        scale <1, 2, 1>
        translate <0, 0, 0>
    }
    sphere { 
        <0.,  0, 0>, 5.8, 1 
        scale <1.4, 1., 1.4>
        translate <0, 5., 0>
    } 
    pigment {
        color rgb <0.1, 0., 0>     // solid color pigment
    }
    normal {
        bumps 0.5         // any pattern optionally followed by an intensity value [0.5]
        scale 0.01       // any transformations
    } 
    finish {
        ambient 0.1          // ambient surface reflection color [0.1]
        diffuse 0.9          // amount [0.6]
        brilliance 1.0       // tightness of diffuse illumination [1.0]
        specular 0.4       // amount [0.0]
        roughness 0.005     // (~1.0..0.0005) (dull->highly polished) [0.05]
    } // finish
    translate <0, 1.8, 0>
};



#declare GP2 = blob {
    // threshold (0.0 < threshold <= StrengthVal) surface falloff threshold #
    threshold 0.2
    sphere { 
        < 0,   0,    0>, 4, 1 
        scale <1, 2, 1>
        translate <0, 0, 0>
    }
    sphere { 
        <0.,  0, 0>, 5.8, 1 
        scale <1., 1.2, 1.>
        translate <0, 3., 0>
    } 
    sphere { 
        <0.,  0, 0>, 4, -1 
        scale <1., 1.5, 1.>
        translate <3.5, 5., 0>
        rotate <0, 0, 0>
        pigment {
            color rgb <1, 0, 0>     // solid color pigment
        }
        normal {
            bumps 0.5         // any pattern optionally followed by an intensity value [0.5]
            scale 0.01       // any transformations
        } 
        finish {           // (---surface finish---)
            ambient 0.2
            diffuse 1.8
            specular 0.9     // shiny
            metallic 0.7
        }
    } 
    sphere { 
        <0.,  0, 0>, 4, -1 
        scale <1., 1.5, 1.>
        translate <3.5, 5.8, 0>
        rotate <0, 120, 0>
        pigment {
            color rgb <1, 0, 0>     // solid color pigment
        }
        normal {
            bumps 0.5         // any pattern optionally followed by an intensity value [0.5]
        scale 0.01       // any transformations
    } 
    finish {           // (---surface finish---)
        ambient 0.2
        diffuse 1.8
        specular 0.9     // shiny
        metallic 0.7
    }
} 
    sphere { 
        <0.,  0, 0>, 4, -1 
        scale <1., 1.5, 1.>
        translate <3.5, 5.8, 0>
        rotate <0, 240, 0>
        pigment {
            color rgb <1, 0, 0>     // solid color pigment
        }
        normal {
            bumps 0.5         // any pattern optionally followed by an intensity value [0.5]
            scale 0.01       // any transformations
        } 
        finish {           // (---surface finish---)
            ambient 0.2
            diffuse 1.8
            specular 0.9     // shiny
            metallic 0.7
        }
    } 
    pigment {
        color rgb <0.14, 0., 0>     // solid color pigment
    }
    normal {
        bumps 0.5         // any pattern optionally followed by an intensity value [0.5]
        scale 0.01       // any transformations
    } 
    finish {
        ambient 0.1          // ambient surface reflection color [0.1]
        diffuse 0.9          // amount [0.6]
        brilliance 1.0       // tightness of diffuse illumination [1.0]
        specular 0.4       // amount [0.0]
        roughness 0.005     // (~1.0..0.0005) (dull->highly polished) [0.05]
    } // finish
    translate <0, 1.8, 0>
};

#declare GP3 = blob {
    // threshold (0.0 < threshold <= StrengthVal) surface falloff threshold #
    threshold 0.2
    sphere { 
        < 0,   0,    0>, 4, 1 
        scale <1, 1.4, 1>
        translate <0, 0, 0>
    }
    pigment {
        color rgb <0.9, 0., 0>     // solid color pigment
    }
    normal {
        bumps 0.5         // any pattern optionally followed by an intensity value [0.5]
        scale 0.05       // any transformations
    }
    finish {
        ambient 0.1          // ambient surface reflection color [0.1]
        diffuse 0.9          // amount [0.6]
        brilliance 1.0       // tightness of diffuse illumination [1.0]
        specular 0.4       // amount [0.0]
        roughness 0.005     // (~1.0..0.0005) (dull->highly polished) [0.05]
    } // finish
    translate <0, 0.3, 0>
};


//-------------------Arrangement of elments----------------------------------------------------



#declare ticker = 0; 
#while (ticker < 300) 						//Distribution of 300 elements

	#declare R = 5; 						//For a start in the distance of R from the origin						

	#declare H = R*(2*rand(chance1) - 1); 				//Distribution on a cylinder of height and radius R
	#declare Angle = degrees(acos(H/R)); 				//Angle for projecting on the sphere's surface. 
	#declare P1 = <R, 0, 0>; 
	#declare P1 = vrotate (P1, <0, 0, Angle>); 
	#declare P1 = vrotate (P1, <360 *rand(chance1), 0,0>); 

	#while (inside (Virus, P1) < 1)			//P1 is moved towards the particle until it is inside
		#declare P1 = P1 - 0.01*P1; 
	#end  

	#declare P2 = P1 + 0.2*P1;			//P2 is a small distance outside the particle 
	#declare N1 = <0, 0, 0>; 			//Initiation of normal vector

	#declare Sec = trace (Virus, P2, -P2, N1); 	//Calculation of normal vectors

	#declare Winkelz = degrees(acos (N1.y)); 	//Calculation of angles necessary to align element to N - Rotation around z

	#if (N1.z < 0)					//Calculation of angles necessary to align element to N - Rotation around y
		#declare Winkely = degrees (atan (N1.x/N1.z)) -90; //Rotation around y
	#else
		#declare Winkely = degrees (atan (N1.x/N1.z)) +90;  
	#end 
    
    #if (rand(chance1)<0.33)
	    object {GP1 
		    scale 0.025
		    rotate <0, 0, Winkelz>
 		    rotate <0, Winkely, 0>
		    translate 1.02*P1 
	    } 
	#else
	    #if (rand(chance1)<0.66)
	        object {GP2 
		        scale 0.025
		        rotate <0, 0, Winkelz>
 		        rotate <0, Winkely, 0>
		        translate 1.02*P1 
	        }
	    #else
	        object {GP3 
		        scale 0.025
		        rotate <0, 0, Winkelz>
 		        rotate <0, Winkely, 0>
		        translate 1.02*P1 
	        }
	     #end
    #end



#declare ticker = ticker + 1;
#end


