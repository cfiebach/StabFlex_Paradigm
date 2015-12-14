#####################################################################################################################
#####################################################################################################################

# SDL-File fuer Flex-Experiment
## Training 1: mit direktem Feedback auf jeden Trial, dafür aber keine ambiguen Trials, am Ende Zusammenfassung mit Proz.korrekt

#####################################################################################################################
#####################################################################################################################

scenario = "Flex_left_Training1";
pcl_file = "Flex_left_Training1.pcl";

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
$item_font_size = 30;
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
text { caption = "+"; font = "Arial"; font_size = 24; font_color = 255, 255, 255;}fixcross_instr;

#Item-Letter OBEN, hier erstmal mit fixer Farbe
text {caption = "#"; font = "Arial"; font_size = $item_font_size; font_color = 150, 150, 150;}inputitem_oben; #in PCL: set_caption & set_font_color
text {caption = "3"; font = "Arial"; font_size = 24; font_color = 150, 150, 150;}inputitem_oben_instr_a; #in PCL: set_caption & set_font_color
text {caption = "3"; font = "Arial"; font_size = 24; font_color = 245, 245, 245;}inputitem_oben_instr_b; #in PCL: set_caption & set_font_color
text {caption = "3"; font = "Arial"; font_size = 24; font_color = 70, 70, 70;}inputitem_oben_instr_c; #in PCL: set_caption & set_font_color

#Item-Letter UNTEN, hier MUSS Farbe in PCL gesetzt werden 
text {caption = "#"; font = "Arial"; font_size = $item_font_size; font_color = 255, 255, 255;}inputitem_unten; #in PCL: set_caption & set_font_color
text {caption = "6"; font = "Arial"; font_size = 24; font_color = 70, 70, 70;}inputitem_unten_instr_b; #in PCL: set_caption & set_font_color
text {caption = "6"; font = "Arial"; font_size = 24; font_color = 245, 245, 245;}inputitem_unten_instr_c; #in PCL: set_caption & set_font_color

# Ende
text {caption = "ENDE %korrekt"; font = "Arial"; font_size = $item_font_size; font_color = 255, 255, 255;} ende_text; # in PCL setzen auf Prozent korrekt

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
text {caption = "falsch"; font = "Arial"; font_size = $item_font_size; font_color = 255, 0, 0;} falsch_text;
picture {text falsch_text; x = 0; y = 0;} falsch_pic;

text {caption = "richtig"; font = "Arial"; font_size = $item_font_size; font_color = 0, 170, 0;} richtig_text;
picture {text richtig_text; x = 0; y = 0;} richtig_pic;

text {caption = "zu langsam"; font = "Arial"; font_size = $item_font_size; font_color = 255, 255, 255;} zulangsam_text;
picture {text zulangsam_text; x = 0; y = 0;} zulangsam_pic;

# Box Instruktion
box { color = 255, 255, 255;
      height = 155;
      width = 185;
}instr_box1;
box { color = 0, 0, 0; 
      height = 150;
      width = 180;
}instr_box2;
## Instruktionen
text {caption = "
Now the main task follows. Here, you will always see a number above the fixation cross
and sometimes a second number, below the fixation cross.

In MOST of the trials, only one number appears
ABOVE the fixation cross in a middle grey scale.
Please decide, whether this number is odd or
even.
Please press the buttons x and c as you trained
before:
left middle finger = number is odd
left index finger = numer is even.";
font = "Arial"; font_size = 18; font_color = 255, 255, 255; text_align = align_left;} instruction1a_text;

text {caption = "
SOMETIMES the grey scale of the upper number changes and at the same time a second
number appears below the fixation cross.
In that case, please decide as follows:

- When the upper number is brighter than the lower
  number, please continue to decide whether the 
  upper number is odd or even and ignore the lower
  number.
  
- In the event that the lower number is brighter,
  please decide for the lower number whether it is
  smaller or larger than 5. Answer with the right 
  hand as trained before, with the right index
  finger indicating smaller than 5 and the right 
  middle finger indicating larger than 5. 

Please always answer as fast and as correct as possible. 

To continue, please press the blank key.";
font = "Arial"; font_size = 18; font_color = 255, 255, 255; text_align = align_left;} instruction1b_text;  ## ANPASSEN: Fingerbelegung & heller/dunkler

picture { text instruction1a_text; left_x = -620; y = 280;
			 box instr_box1; x = 90; y = 200;
			 box instr_box2; x = 90; y = 200;
			 text inputitem_oben_instr_a; x = 90; y = 240;
			 text fixcross_instr; x = 90; y = 200;
			 
			 text instruction1b_text; left_x = -620; y = -150;
			 
			 box instr_box1; x = 90; y = -40;
			 box instr_box2; x = 90; y = -40;
			 text inputitem_oben_instr_b; x = 90; y = 0;
			 text inputitem_unten_instr_b; x = 90; y = -80;
			 text fixcross_instr; x = 90; y = -40;			 

			 box instr_box1; x = 90; y = -220;
			 box instr_box2; x = 90; y = -220;
			 text inputitem_oben_instr_c; x = 90; y = -180;
			 text inputitem_unten_instr_c; x = 90; y = -260;
			 text fixcross_instr; x = 90; y = -220;					 
			 
} instruction1_pic;


text {caption = "
First, you will trian this task. During training you will get feedback about correctness after each
trial.


If you have any questions, please refer to the experimeter.


To start the training, please press the blank key.";
font = "Arial"; font_size = 18; font_color = 255, 255, 255; text_align = align_left;} instruction2_text;

picture { text instruction2_text; left_x = -620; y = 60;} instruction2_pic;


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

trial {
trial_duration = forever;        	# trial lasts until target
trial_type = specific_response;  
terminator_button = 5; 
picture instruction2_pic;
code = "instruction2";
target_button = 5;
} instruction2_trial;  

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
