#####################################################################################################################
#####################################################################################################################

# SDL-File fuer Flex-Experiment
## TRAINING 2: ohne direktes Feedback auf Trials, nur Prozent Korrekt am Ende

#####################################################################################################################
#####################################################################################################################

scenario = "Flex_left_Training3";
pcl_file = "Flex_left_Training3.pcl";

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
text {caption = "#"; font = "Arial"; font_size = $item_font_size; font_color = 150, 150, 150;}inputitem_oben; #in PCL: set_caption & set_font_color

#Item-Letter UNTEN, hier MUSS Farbe in PCL gesetzt werden 
text {caption = "#"; font = "Arial"; font_size = $item_font_size; font_color = 255, 255, 255;}inputitem_unten; #in PCL: set_caption & set_font_color

# Ende
text {caption = "END %correct"; font = "Arial"; font_size = 30; font_color = 255, 255, 255;} ende_text1; #set in PCL auf tatsaechlich korrekten
text {caption = "
Now you will continue to the fMRI-scanner. 

- Please try to lay as still as possible during scanning!
  
- Please also try to not move your eyes a lot as also these movements can cause artifacts!"; 
font = "Arial Black"; font_size = 18; font_color = 255, 255, 255; text_align = align_left;} ende_text2;

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
picture {
text ende_text1; x=0; y=150;
text ende_text2; left_x = -620; y = -60;
} ende_pic1;


# FEEDBACKS
text {caption = "falsch"; font = "Arial"; font_size = $item_font_size; font_color = 255, 0, 0;} falsch_text;
picture {text falsch_text; x = 0; y = 0;} falsch_pic;

text {caption = "richtig"; font = "Arial"; font_size = $item_font_size; font_color = 0, 170, 0;} richtig_text;
picture {text richtig_text; x = 0; y = 0;} richtig_pic;

text {caption = "zu langsam"; font = "Arial"; font_size = $item_font_size; font_color = 255, 255, 255;} zulangsam_text;
picture {text zulangsam_text; x = 0; y = 0;} zulangsam_pic;


## Instruktionen
text {caption = "
Nun folgt nochmals ein Trainingsdurchgang, in dem Sie kein direktes Feedback mehr über die Korrektkeit 
Ihrer Antwort erhalten werden. 
Außerdem werden die Helligkeitsunterschiede noch etwas feiner abgestuft sein - versuchen Sie dennoch 
IMMER eine Entscheidung zu treffen!
Die Aufgabe, die Sie später im MRT-Scanner bearbeiten sollen, wird genauso aussehen. 


Bitte denken Sie daran, immer so schnell, aber auch so korrekt wie möglich zu antworten!


Bei Fragen wenden Sie sich jetzt bitte an den Versuchsleiter / die Versuchsleiterin.


Zum Starten der Übung drücken Sie bitte die Leertaste.";
font = "Arial"; font_size = 18; font_color = 255, 255, 255; text_align = align_left;} instruction1_text; ## ANPASSEN: Fingerbelegung & heller / dunkler

picture { text instruction1_text; left_x = -600; y = 40;} instruction1_pic;


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


### TASK-Trial - hier OHNE Feedback, da auch ambigue dabei > kein eindeutiges Feedback moeglich

trial {
#no_response_feedback = timeout_trial;
#incorrect_feedback = wrong_trial;
#correct_feedback = right_trial;

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
      picture ende_pic1;						  
      code = "ENDE1"; 						 #set in PCL to at least "oben" oder "unten"
      time=2000;        					 
   }ende_event1;
   
} ende_trial1;   
  
   
