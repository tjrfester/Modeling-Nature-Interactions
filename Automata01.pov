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



*/
//-----------------------------------Scene settings (Camera, light, background)-------------------------------------------------

global_settings {
    assumed_gamma 1.0
    max_trace_level 5
}


#declare Hauptkameraz = camera {
    location  <0, 0, -20>
    look_at   <0, 0,  0.0>
    right     x*image_width/image_height
}


camera {Hauptkameraz}



// create a regular point light source
light_source {
    0*x                  // light's position (translated below)
    color rgb <1,1,1>    // light's color
    translate <84, 200, -200>
    shadowless
}   

light_source {
    0*x                  // light's position (translated below)
    color rgb <1,1,1>    // light's color
    translate <84, 0, -200>
    shadowless
}   


background { 
    color rgb <1, 1, 1> 
}

      

//-----------------------------------------------------------------------

#declare chance1 = seed(4); 

#declare CellsOld = array [100] 
#declare CellsNew = array [100] 


//Initial configuration of cells (10 * 10)

#declare ticker = 0; 
#while (ticker < 100) 

    #declare CellsOld[ticker] =  div (1, 0.6 + 0.8 * rand(chance1) );  //about half the cells will be "Zero", the other half "one".  

#declare ticker = ticker + 1; 
#end   




//Zyklen zur Modifikation des Zelleninhalts 

#declare ticker2 = 0; 
#while (ticker2 <1+50 * clock)                       //depending on "clock" there are between 1 and 51 cycles

    #declare ticker = 0;                                 //this loop refers to all cells
    #while (ticker < 100) 

    //For each cells the surrounding cells are checked and values (0 or 1) are written into the Variables Vala, Valb, Valc or Vald. 

        #declare a = ticker - 1; //Position left to the current cell
        #if (mod (ticker, 10) = 0)  //in case the current cell is on the left edge of the field, then the cell on the very right side of the field is evaluated
            #declare a = a + 10; 
        #else
        #end 
        #declare Vala = CellsOld[a]; //Vala stores the value of the left adjacent cell

        #declare b = ticker + 1; //Position right to the current cell
        #if (mod (ticker, 10) = 9) //In case the current cell is on the right edge of the field, then the cell on the very left side of the field is evaluated
            #declare b = b - 10; 
        #else
        #end
        #declare Valb = CellsOld[b];//Valb stores the value of the right adjacent cell  

        #declare Vale = CellsOld[ticker]; //Vale stores the value of the cell in question

        #declare c = ticker - 10; //Position above the current cell
        #if (c < 0) //In case the current position lies on the upper edge of the field, the respective cell on the very bottom of the field is evaluated
            #declare c = c +100; 
        #else
        #end
        #declare Valc = CellsOld[c];//Valc stores the value of the top adjacent cell


        #declare d = ticker + 10; //Position below the current cell
        #if (d > 99) //In case the current position lies on the lower edge of the field, the respective cell on the very top of the field is evaluated. 
            #declare d = d - 100; 
        #else
        #end
        #declare Vald = CellsOld[d];//Vald stores the value of the bottom adjacent cell.


//Calculations of the new cells

        #if (Vala + Valb + Valc + Vald > 2)//Rule determining how new values are calculated (can be changed); in this case the current cells becomes 1 when more than two adjacent cell are 1. 

            #declare CellsNew [ticker] = 1; 

        #else

            #declare CellsNew [ticker] = 0; 

        #end

    #declare ticker = ticker + 1; 
    #end 
 

    #declare CellsOld = CellsNew; //Here a new round of calculations is started 


#declare ticker2 = ticker2 + 1; 
#end




//Visualization of cell contents; the array is visualized as a field of 10 x 10 elements 

#declare counter = 0; 

#declare ticker = 0; 
#while (ticker < 10)

    #declare ticker2 = 0; 
    #while (ticker2 < 10)

        sphere { 
            <0,0,0>, 0.3
            #if (CellsNew[counter] >0)                          // An orange colour refers to 1, a blue colour to 0. 
                texture { 
                    pigment{ 
                        color rgb <255/255,102/255,0/255> 
                    }
                    finish { 
                        specular 0.9
                        reflection 0.00
                    }
                } // end of texture
            #else 
                texture { 
                    pigment{    
                        color rgb <0/255, 208/255, 255/255>
                    }
                    finish { 
                        specular 0.9
                        reflection 0.00
                    }
                } // end of texture

            #end
            scale<1,1,1>  
            rotate<0,0,0>  
            translate<ticker2,ticker,0>  
            translate <-5, -5, 0>
        }  // end of sphere ----------------------------------- 

    #declare counter = counter + 1; 

    #declare ticker2 = ticker2 + 1; 
    #end

#declare ticker = ticker + 1; 
#end

