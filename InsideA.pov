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

This file is made to demonstrate the inside-function in Pov-Ray. It allows to decide, whether a given point is inside or outside a given object. In addition, I'm also introducing macros with this file. 
The macro given below randomly produces positions (within a given volume) and examines whether these positions are inside or outside a given object. Only the positions inside this object are stored in
an array. In a second step the letter "A" in various colours is displayed on each position. The object used for the inside-test also was a big letter "A".
*/ 
                

//----------------------------------------------macros-------------------------------------------------

//This macro provides a cartesian distribution of objects within a certain container. The positions are stored in the array "Positions", the amount of positions in the variable "Sum"

#macro xyzDistributionInsideArray (Object, Start, Amountx, Amounty, Amountz, Distancex, Distancey, Distancez, Variance)


    #declare Positions = array [Amountx * Amounty * Amountz];
    #declare Sum = 0;

    #local chance1 = seed (13);


    #local xKoord = Start.x; 
    #local yKoord = Start.y; 
    #local zKoord = Start.z; 

    #local ticker3 = 0;                                  //three nested loops for generating random positions
    #while (ticker3 <Amountx)
        #local xKoord = xKoord + Distancex; 
        #local yKoord = Start.y; 

        #local ticker2 = 0;
        #while (ticker2 <Amounty)
            #local yKoord = yKoord + Distancey; 
            #local zKoord = Start.z; 


            #local ticker = 0;
            #while (ticker <Amountz)
                #local zKoord = zKoord + Distancez; 

                #local var1 = rand(chance1);
                #local var2 = rand(chance1);
                #local var3 = rand(chance1);

                #local P1 = <xKoord + Variance * (var1 - 0.5), yKoord +  Variance * (var2 - 0.5), zKoord +  Variance * (var3 - 0.5)>;

                #if (inside (Object, P1) = 1)       //inside function

                    #declare Positions[Sum] = P1;   //storing positions
                    #declare Sum = Sum + 1;         //keeping track of number of stored positions

                #else

                #end

            #local ticker = ticker + 1;
            #end

        #local ticker2 = ticker2 + 1;
        #end

    #local ticker3 = ticker3 + 1;
    #end

#end
//--------------------------------------------end of macros-----------------------------------------------

//-----------------------------------Scene settings (Camera, light, background)-------------------------------------------------

global_settings {
    assumed_gamma 1.0
    max_trace_level 5
}


#declare Camera = camera {
    location  <0, 1, 10>
    right     x*image_width/image_height
    look_at   <0,1,  0>
}


camera {Camera}


// create a regular point light source
light_source {
    0*x                  // light's position (translated below)
    color rgb <1,1,1>    // light's color
    translate <100, 50, 0>
}
light_source {
    0*x                  // light's position (translated below)
    color rgb <1,1,1>    // light's color
    translate <40, 50, -80>
}
light_source {
    0*x                  // light's position (translated below)
    color rgb <1,1,1>    // light's color
    translate <30, 50, 800>
}


//Coordinate system

/*
cylinder { 
    <-100, 0, 0>, <100, 0, 0>, 0.08 //x-axis, red
    pigment {
        color rgb <1,0,0>     // solid color pigment
    }
}

cylinder { 
    <0, -100, 0>, <0, 100, 0>, 0.08 //y-axis, green
    pigment {
    color rgb <0,1,0>     // solid color pigment
    }
}

cylinder { 
    <0, 0, -100>, <0, 0, 100>, 0.08 //z-axis, blue
    pigment {
    color rgb <0,0,1>     // solid color pigment
    }
}

*/

background { 
    color rgb <1, 1, 1> 
}


//-----------------------Definition of objects---------------------------------------------------------------------       

//Definition of the container-object (a big "A")

// create a TrueType text shape
#declare Huelle = text {
    ttf             // font type (only TrueType format for now)
    "arial.ttf",  // Microsoft Windows-format TrueType font file name
    "A",      // the string to create
    0.2,              // the extrusion depth
    0               // inter-character spacing
    translate <-0.32, -0.3, -0.1>
    scale <10, 10, 10>
}

//#object {Huelle}  


//Definition of object filling up the container (small "A"s in different colours

#declare Agruen = text {
    ttf             // font type (only TrueType format for now)
    "arial.ttf",  // Microsoft Windows-format TrueType font file name
    "A",      // the string to create
    0.2,              // the extrusion depth
    0               // inter-character spacing
    translate <-0.32, -0.3, -0.1>
    scale <0.25, 0.25, 0.25>
    pigment {
        color rgb <0,1,0>     // solid color pigment
    }
} 
  
  
#declare Agelb = text {
    ttf             // font type (only TrueType format for now)
    "arial.ttf",  // Microsoft Windows-format TrueType font file name
    "A",      // the string to create
    0.2,              // the extrusion depth
    0               // inter-character spacing
    translate <-0.32, -0.3, -0.1>
    scale <0.25, 0.25, 0.25>
    pigment {
        color rgb <1,1,0>     // solid color pigment
    }
} 

#declare Arot = text {
    ttf             // font type (only TrueType format for now)
    "arial.ttf",  // Microsoft Windows-format TrueType font file name
    "A",      // the string to create
    0.2,              // the extrusion depth
    0               // inter-character spacing
    translate <-0.32, -0.3, -0.1>
    scale <0.25, 0.25, 0.25>
    pigment {
        color rgb <1,0,0>     // solid color pigment
    }
} 

#declare Ablau = text {
    ttf             // font type (only TrueType format for now)
    "arial.ttf",  // Microsoft Windows-format TrueType font file name
    "A",      // the string to create
    0.2,              // the extrusion depth
    0               // inter-character spacing
    translate <-0.32, -0.3, -0.1>
    scale <0.25, 0.25, 0.25>
    pigment {
        color rgb <0,0,1>     // solid color pigment
    }
}

//-----------------------Invoking the macro---------------------------------------------------------------------        

xyzDistributionInsideArray (Huelle, <-3.3, -3.1, -1.1>, 30, 30, 10, 0.25, 0.25, 0.25, 1)

//The macro has created an array named "Positions" of the size "Sum".


//-----------------------Pre-defined objects are placed on the positions from the macro---------------------------------------------------------------------        


#declare chance1 = seed(4);

#declare ticker = 0;  //This loop runs through all elements of the array "Positions".
#while (ticker<Sum)

    #declare P1 = Positions[ticker];
    #declare Var1 = rand(chance1); 

    #if (Var1<0.25)       //if-clauses make sure that for each position, each of the four coloured objects has an equal chance (0.25) of appearing.

        #object{
            Agruen
            rotate <360 * rand(chance1), 360 * rand(chance1), 0>
            translate P1 
        } 

    #else

        #if (Var1<0.5)

            #object{
                Agelb
                rotate <360 * rand(chance1), 360 * rand(chance1), 0>
                translate P1 
            } 

        #else

            #if (Var1<0.75)

                #object{
                Ablau
                rotate <360 * rand(chance1), 360 * rand(chance1), 0>
                translate P1 
                } 

            #else


                #object{
                    Arot
                    rotate <360 * rand(chance1), 360 * rand(chance1), 0>
                    translate P1 
                } 


            #end
        #end
    #end

#declare ticker = ticker +1;
#end   

