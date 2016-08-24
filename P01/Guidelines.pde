/* TO DOs for a project
Fill in file header on the main tab (Project??) with your name, project number, title, and date.

Make sure that you replace the data/pic.jpg with a picture of your face. Your .jpg file should have 
roughly same dimensions as mine so the image fits in the corner. 
Your picture should be recent and should clearly show your face.

Edit the title and name at the bottom of this file with the project number, title, and your name.

Write your own code as a procedure in a separate tab. (Click on the down arrow to make a new tab)
Make sure to put a header in that tab with your name.

Be concise. Write elegant and readable code. Put brief comments as needed.

ALL CODE THAT YOU ADD SHOULD BE WRITTEN ENTIRELY AND ONLY BY YOU! NO COLLABORATION ON THE CODE.
YOU ARE NOT ALLOWED TO COPY CODE FROM ANY OTHER SOURCES UNLESS EXPLICITLY PERMITTED BY THE INSTRUCTOR OR TA.
Sources of inspiration must be clearly indicated as comments in the code and in your report.
These may include discussions with colleagues (give names and be specific as to what waw discussed), 
help from TA (state which part), cite books, papers, websites that were helpful (be specific which part was helpful).

Add commands to draw() and to the various action procedures to call your procedure(s) and support your GUI and animation.

Edit the 'guide' string as desired to explain the GUI of your program.

Capture images of the canvas (pressing '!') showing results of your program and include in the write-up for your submission.

Follow the indication below on how to make a movie showing your sketch in action.
Make sure that your movie is short (~10 secs) and that the resolution is modest, so that the file is small.
Write a very short report containing 
 - the title: CS3451-Fall 2013, Project01, 
 - author: First LASTNAME, clear image of your face.
 - project title, and short description of what was asked,
 - a short explanation of what you did and how 
   (include a code snippet showing the key pieces of what you have programmed), 
 - include images showing that your program works, 
 - explain clearly what functionality you were not able to implement and why, if any
 - clearly identify EXTRA CREDIT contributions and include explanations and images showing them.
   (only up to 25% of the extra credit points can be earned per project).
   
Include the source code sketch tabs, the data folder, the movie, and a PDF of your report inside the sketch folder.
Make sure that you DELETE the FRAMES folder and the PICTURES folder, before compressing the folder!!!
Compress the sketch folder into a .zip file and submit the zipped file on Tsquare before the deadline. (No extensions!)
*/

/**************************** to make a movie **************************
Press '~' to start filming (saving frames into the FRAMES folder)
Use the program. 
  It does not record frames when you are not moving the mouse or animating anything (see if(filming && (animating || change)) in draw())
Press '~' again to stop recording
You may press '~' again later to append more frames and again to stop 

In the Processing top menu, select the pull-down tab "Tools" and click on "Movie Maker"
  Fill in the destination or drag your FRAMES folder in the field as directed
   Pick resolution (300x300) or a bit more if necessary.
   Frame rate 30. Compressoin PNG
   Adding a sound is OK, but it sometimes fails for me, especially when the resolution is higher
   press "Create Movie"
   Call the file "3451_P1_YOURNAME.mov"
   Make and check the movie
Delete the FRAMES subfolder (to save space)
Put the movie into your sketch folder so that it is part of the zip that you will submit
************************************************************************/