#####################################################################################################################
#####################################################################################################################

# SDL-File fuer Flex-Experiment

#####################################################################################################################
#####################################################################################################################

scenario = "Flex_main_women_2";
pcl_file = "Flex_main_women_2.pcl";

#scenario_type = trials;
scenario_type = fMRI;
#scenario_type = fMRI_emulation;
scan_period = 1800;
pulses_per_scan = 1;
pulse_code = 99; 

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
$ITI_duration = 1000;
$item_font_size = 36;


#####################################################################################################################
begin;
#####################################################################################################################


### Definiere alles moegliche

# Fixcross
text { caption = "+"; font = "Arial"; font_size = 30; font_color = 255, 255, 255;}fixcross;
picture {text fixcross; x=0; y=0;} cross_pic;

# DEFAULT picture = fixcross
picture {text fixcross; x=0; y=0;} default;

#Item-Letter OBEN, hier erstmal mit fixer Farbe
text {caption = "#"; font = "Arial"; font_size = $item_font_size; font_color = 127, 127, 127;}inputitem_oben_start; #in PCL: set_caption & set_font_color
text {caption = "#"; font = "Arial"; font_size = $item_font_size; font_color = 127, 127, 127;}inputitem_oben; #in PCL: set_caption & set_font_color

#Item-Letter UNTEN, hier MUSS Farbe in PCL gesetzt werden 
text {caption = "#"; font = "Arial"; font_size = $item_font_size; font_color = 127, 127, 127;}inputitem_unten_start; #in PCL: set_caption & set_font_color
text {caption = "#"; font = "Arial"; font_size = $item_font_size; font_color = 127, 127, 127;}inputitem_unten; #in PCL: set_caption & set_font_color

# Ende
text {caption = "-"; font = "Arial"; font_size = $item_font_size; font_color = 0,0,0;} ende_text;

# eigentliches Stimulus picture
picture {
   text inputitem_oben;  x=0; y=70;     #in PCL spezifischen Input setzen
	text inputitem_unten; x=0; y=-70;    #in PCL spezifischen Input setzen
	text fixcross;        x = 0; y = 0;
} item_pic;

picture {
   text inputitem_oben_start;  x=0; y=70;     #in PCL spezifischen Input setzen
	text inputitem_unten_start; x=0; y=-70;    #in PCL spezifischen Input setzen
	text fixcross;        x = 0; y = 0;
} item_pic_start;

#  blank screen
text {caption ="-"; font = "Arial"; font_size = $item_font_size; font_color = 0, 0, 0;} blank_text;
picture {text blank_text; x = 0; y = 0;} blank_pic;


#blackscreen
picture {
background_color = 0,0,0;
   text {caption = "c druecken fuer weiter!";
         font_size = 10;};
   left_x = -780; y = -480;
} blackscreen_pic;


#Alles okay?
picture {
   text {caption = "Bitte liegen Sie so still wie möglich! \nKann es losgehen? \n\nJA = rechter Zeigefinger \nNEIN = linker Zeigefinger. "; 
         font_size = 18;} instruc_reminder_text;
   x = 0; y = 0;
} instruction_reminder_pic;

#Gleich geht's los Picture
picture {
   text {caption = "Gleich geht's los!";
         font_size = 20;} warning_text1;
   x = 0; y = 0;
   text {caption = "Scanner starten";
         font_size = 6;} warning_text2;
   x = -450; y = -280;
} warning_pic;

#Dummy Scans -> leerer Bildschirm für 2 TR
picture {
   text {caption = "-"; font_color = 0, 0, 0;};
   left_x = -780; y = -480;
} dummy_pic;

# Ende
picture {
	text ende_text;
	x=0; y=170;
	#text {caption = "Ende 1. Block - 6 Pulse abwarten DANN Scanner AUS!";};
	#left_x = -500; y = -280;
} ende_pic;

picture {
	text { caption = "Ende des 2. Aufgabenblocks!"; font_size = 32;};
	x = 0; y = 0;
} ende_info_pic;

### Zu Anfang: Schwarzer Bildschirm
trial {
	all_responses = true;   
   trial_duration = forever;
   trial_type = specific_response;  
   terminator_button = 5; 
		
	picture blackscreen_pic;
 	code = "BlackScreenA";
} BlackScreen_trial;

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
	trial_duration = stimuli_length;
   picture warning_pic;  					
   code = "warning";							
   time = 0;
	duration = next_picture;		#					
}warning_trial;	

#Dummy-Scans
trial {
	trial_mri_pulse = 1;	      #
	picture dummy_pic;
	code = "dummyscans";
	time = 0; 
	duration = 3700; 
} trial_dummyscans;

## Fixcross-Trial (nur beim allerersten Trial)
trial {
trial_mri_pulse = 3;
	stimulus_event {
			picture cross_pic;
			time = 0;
			duration = next_picture;	
			code = "beginning_fix";
			};
} fix_trial;

### START TASK-Trial

trial {
trial_mri_pulse = 4;	
trial_duration = stimuli_length;							 # set in PCL
trial_type = fixed;  

   stimulus_event {	
      picture item_pic_start;						  
      code = "input_number"; 						 #set in PCL to at least "oben" oder "unten"
      time=0;        					      
      duration = $inputitem_duration; 
      target_button = 1; 					       #wird in PCL gesetzt
   }task_event_start;
   
	stimulus_event {	
      picture cross_pic;
		code = "ITI";   						        #set in PCL with condition info  
      delta_time=$inputitem_duration;
      target_button = 1;  
		duration = $ITI_duration;  					  #wird in PCL gesetzt
	 }iti_event_start;	                             	                  
   
}start_main_trial;

### alle anderen TASK-Trials

trial {
trial_duration = stimuli_length;							 # set in PCL
trial_type = fixed;  

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
      target_button = 1;  
		duration = $ITI_duration;  					  #wird in PCL gesetzt
	 }iti_event ;	                             	                  
   
}main_trial;

###########
### Ende###
###########

trial {
trial_mri_pulse = 9999;	   ##set in PCL
   
   stimulus_event {	
      picture ende_pic;						  
      code = "ENDE"; 
      time=0; 
		duration = 3000;						
   }ende_event;
   
} ende_trial;      

trial {
trial_type = specific_response;
trial_duration = forever;
terminator_button = 5;
picture ende_info_pic;
code = "ende info";
} ende_info_trial;
