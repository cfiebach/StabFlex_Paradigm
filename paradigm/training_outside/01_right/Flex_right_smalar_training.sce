#####################################################################################################################
#####################################################################################################################

# SDL-File fuer Flex-Experiment
## Training kleiner/groesser Entscheidung

#####################################################################################################################
#####################################################################################################################

scenario = "Flex_right_smalar_training";
pcl_file = "Flex_right_smalar_training.pcl";

scenario_type = trials;
#scenario_type = fMRI;
#scenario_type = fMRI_emulation;
#scan_period = 2000;
#pulses_per_scan = 1;
#pulse_code = 99; 

active_buttons = 5;
button_codes = 1,2,3,4,5; 							      # codes for incorrect responses
target_button_codes = 101,102,103,104,105;		      	# codes for correct responses

response_logging = log_active;				
response_matching = simple_matching;		# WICHTIG! Damit auch inkorrekte Responses mit den Stimuli verbunden werden

#####################################################################################################################
### Voreinstellungen Formatierung
#####################################################################################################################

default_background_color = 0, 0, 0; 
default_font = "Arial";


$ITI_duration = 1000;
$inputitem_duration = 1000;
$item_font_size = 36;
$feedback_duration = 300;

#####################################################################################################################
begin;
#####################################################################################################################


### Definiere alles moegliche

# ready-pic
text { caption = "READY"; font = "Arial"; font_size = $item_font_size; font_color = 255, 255, 255;} ready_text;
picture {text ready_text; x = 0; y = 0;} ready_pic;

# Fixcross
text { caption = "+"; font = "Arial"; font_size = 30; font_color = 255, 255, 255;}fixcross;
picture {text fixcross; x=0; y=0;} fix_pic;


#Item-Letter OBEN, hier erstmal mit fixer Farbe
text {caption = "#"; font = "Arial"; font_size = $item_font_size; font_color = 0, 0, 0;}inputitem_oben; #in PCL: set_caption

#Item-Letter UNTEN, hier MUSS Farbe in PCL gesetzt werden 
text {caption = "#"; font = "Arial"; font_size = $item_font_size; font_color = 255, 255, 255;}inputitem_unten; #in PCL: set_caption & set_font_color

# Ende
text {caption = "END %correct"; font = "Arial"; font_size = $item_font_size; font_color = 255, 255, 255;} ende_text; # in PCL setzen auf Prozent korrekt

# eigentliches Stimulus picture
picture {
   text inputitem_oben;  x=0; y=70;     #in PCL spezifischen Input setzen
	text inputitem_unten; x=0; y=-70;    #in PCL spezifischen Input setzen
	text fixcross;        x = 0; y = 0;
} item_pic;

# blank screen
text {caption ="-"; font = "Arial"; font_size = $item_font_size; font_color = 0, 0, 0;} blank_text;
picture {text blank_text; x = 0; y = 0;} blank_pic;
	
# Ende
picture {text ende_text;
x=0; y=0;
} ende_pic;

# FEEDBACKS
text {caption = "incorrect"; font = "Arial"; font_size = $item_font_size; font_color = 255, 0, 0;} falsch_text;
picture {text falsch_text; x = 0; y = 0;} falsch_pic;

text {caption = "correct"; font = "Arial"; font_size = $item_font_size; font_color = 0, 170, 0;} richtig_text;
picture {text richtig_text; x = 0; y = 0;} richtig_pic;

text {caption = "too slow"; font = "Arial"; font_size = $item_font_size; font_color = 255, 255, 255;} zulangsam_text;
picture {text zulangsam_text; x = 0; y = 0;} zulangsam_pic;


## Instruktionen
text {caption = "
Now, the second block of training will start. Here, you will have to decide whether the number appearing 
below the fixation cross is smaller or larger than 5. 

When the number is smaller than 5, please answer by pressing the button x with your left middle finger.
When the number is larger than 5, please answer by pressing the button c with your left index finger.";
font = "Arial"; font_size = 18; font_color = 255, 255, 255; text_align = align_left;} instruction1a_text;

text {caption = "

Please always answer as fast and as correct as possible. 

If you have any questions, please refer to the experimeter.


To start, please press the blank key.";
font = "Arial"; font_size = 18; font_color = 255, 255, 255; text_align = align_left;} instruction1b_text;  ## ANPASSEN: Fingerbelegung & heller/dunkler

picture { text instruction1a_text; left_x = -620; y = 150;
			 text instruction1b_text; left_x = -620; y = -70;
} instruction1_pic;



### TRIALS ######

## Begin-Trial
trial {
trial_duration = forever;        	# trial lasts until target
trial_type = specific_response;  
terminator_button = 5; 
picture instruction1_pic;
code = "instruction1";
target_button = 5;
} instruction1_trial; 

#trial {
#trial_type = first_response;
#trial_duration = forever;
#picture instruction2_pic;
#code = "instruction2";
#duration = response;
#} instruction2_trial; 

## Fixcross-Trial
trial {
	stimulus_event {
			picture fix_pic;
			time = 0;
			duration = 1000;	
			code = "beginning_fix";
			};
} fix_trial;

## Feedback Trials

trial {
   trial_duration = $feedback_duration;
   picture richtig_pic; 
   code = "right";
} right_trial;
   
trial {
   trial_duration = $feedback_duration;
   picture falsch_pic;
   code = "wrong";
} wrong_trial;

trial {
   trial_duration = $feedback_duration;
   picture zulangsam_pic;
   code = "timeout";
} timeout_trial;


### TASK-Trial

trial {
no_response_feedback = timeout_trial;
incorrect_feedback = wrong_trial;
correct_feedback = right_trial;

   stimulus_event {	
      picture item_pic;						  
      code = "input_number"; 						 #set in PCL
      time=0;        					      
      duration = $inputitem_duration; 
      target_button = 1; 					       #wird in PCL gesetzt
   }task_event;
   
	stimulus_event {	
      picture fix_pic;
      code = "ITI";   						        #set in PCL with condition info  
      time=$inputitem_duration;
      duration = $ITI_duration;
		target_button = 1;	                    #wird in PCL gesetzt
   }itiandfix_event ;
   
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
