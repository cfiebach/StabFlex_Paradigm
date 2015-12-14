#####################################################################################################################
#####################################################################################################################

# SDL-File fuer Flex-Experiment

#####################################################################################################################
#####################################################################################################################

scenario = "Flex_ScannerTrain_left";
pcl_file = "Flex_ScannerTrain_left.pcl";

scenario_type = trials;
#scenario_type = fMRI;
#scenario_type = fMRI_emulation;
#scan_period = 2000;
#pulses_per_scan = 1;
#pulse_code = 99; 

active_buttons = 5;
button_codes = 1,2,3,4,5; 							            # codes for incorrect responses
target_button_codes = 101,102,103,104,105;		      	# codes for correct responses

response_logging = log_active;				
response_matching = simple_matching;		# WICHTIG! Damit auch inkorrekte Responses mit den Stimuli verbunden werden

#####################################################################################################################
### Voreinstellungen Formatierung
#####################################################################################################################

default_background_color = 0, 0, 0; 
default_font = "Arial";

$inputitem_duration = 1000;
$item_font_size = 36;
$fixcross_duration = 1000;

#####################################################################################################################
begin;
#####################################################################################################################


### Definiere alles moegliche

# Fixcross
text { caption = "+"; font = "Arial"; font_size = 30; font_color = 255, 255, 255;}fixcross;
picture {text fixcross; x=0; y=0;} cross_pic;


#Item-Letter OBEN, hier erstmal mit fixer Farbe
text {caption = "#"; font = "Arial"; font_size = $item_font_size; font_color = 127, 127, 127;}inputitem_oben; #in PCL: set_caption & set_font_color

#Item-Letter UNTEN, hier MUSS Farbe in PCL gesetzt werden 
text {caption = "#"; font = "Arial"; font_size = $item_font_size; font_color = 127, 127, 127;}inputitem_unten; #in PCL: set_caption & set_font_color

# Ende
text {caption = "That was a block of training \nWe will continue in a second. "; font = "Arial"; font_size = 20; font_color = 255, 255, 255;} ende_text;

# eigentliches Stimulus picture
picture {
   text inputitem_oben;  x=0; y=70;     #in PCL spezifischen Input setzen
	text inputitem_unten; x=0; y=-70;    #in PCL spezifischen Input setzen
	text fixcross;        x = 0; y = 0;
} item_pic;

#  blank screen
text {caption ="-"; font = "Arial"; font_size = $item_font_size; font_color = 0, 0, 0;} blank_text;
picture {text blank_text; x = 0; y = 0;} blank_pic;

#ProbeScreen
picture {
   text {caption = "c fuer weiter druecken";
         font_size = 10;}; left_x = -780; y = -480;
   text inputitem_oben;  x=0; y=50;     #in PCL spezifischen Input setzen
	text inputitem_unten; x=0; y=-50;    #in PCL spezifischen Input setzen
	text fixcross;        x = 0; y = 0;
} ProbeScreen_pic;

#Alles okay?
picture {
   text {caption = "Now, one more block of training will follow. \nYou won't get any feedback now. \n\nleft middle finger = odd \nleft index finger = even \nright index finger = smaller than 5 \nright middle finger = larger than 5 \n\n\n\nAre you ready? \nYES = right index finger \nNO = left index finger. ";
         font_size = 20;} instruc_reminder_text;
   x = 0; y = 0;
} instruction_reminder_pic;


#Gleich geht's los Picture
picture {
   text {caption = "Now we will start!";
         font_size = 20;} warning_text1;
   x = 0; y = 0;
   text {caption = "-";
         font_size = 15;
			font_color = 0,0,0;} warning_text2;
   x = -450; y = -280;
} warning_pic;


# Ende
picture {text ende_text;
x=0; y=0;
} ende_pic;


### Zu Anfang: Probe (zum Anpassen der Beamer-Position)
trial {
	all_responses = true;   
   trial_duration = forever;
   trial_type = specific_response;  
   terminator_button = 5; 
		
	picture ProbeScreen_pic;
 	code = "ProbeScreenA";
} ProbeScreen_trial;

### Erinnerung an die Instruktion
 trial {
   trial_duration = forever;
	trial_type = first_response; 
   
   picture instruction_reminder_pic; 					
   code = "instructreminder";							
   time = 0;
	target_button = 1;
}instruction_reminder_trial;	

### Warnung: Gleich geht es los! 
trial {
	trial_type = fixed; 					
  #trial_duration = 4000;
   picture warning_pic;  					
   code = "warning";							
   time = 0;
	duration = 2000;		#					
}warning_trial;	

## Fixcross-Trial (nur beim allerersten Trial)
trial {
trial_type = fixed;
	stimulus_event {
			picture cross_pic;
			time = 0;
			duration = 2000;	
			code = "beginning_fix";
			};
} fix_trial;

### TASK-Trial

trial {						

   stimulus_event {	
      picture item_pic;						  
      code = "input_number"; 						 #set in PCL to at least "oben" oder "unten"
      time=0;        					      
      duration = $inputitem_duration; 
      target_button = 1; 					       #wird in PCL gesetzt
   }task_event;
   
	stimulus_event {	
      picture cross_pic;
      code = "ITI";   						        #set in PCL with condition info  
      delta_time=$inputitem_duration;
      duration = $fixcross_duration;
		target_button = 1;	                    #wird in PCL gesetzt
   }iti_event ;
   
}main_trial;


###########
### Ende###
###########

trial {
trial_type = first_response;
trial_duration = forever;

stimulus_event {	
      picture blank_pic;
      code = "ITI";   						 #set in PCL with condition info  
      time=0;
      duration = 2000; 						 #wird in PCL gesetzt: 2000, 4000, 6000
   }blank_event ;
   
   stimulus_event {	
      picture ende_pic;						  
      code = "ENDE"; 						 #set in PCL to at least "oben" oder "unten"
      time=2000;        					 
		target_button = 1;
   }ende_event;
   
} ende_trial;      
