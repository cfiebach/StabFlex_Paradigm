##########################################################################################################################################
#
# These files were developed by Diana Armbruster-Genc and Kai Ueltzhöffer, 2011-2015; Fiebach Lab for Cognitive Neuroscience, Dept. of Psychology, Goethe University Frankfurt.
#
# When using these materials, please cite: Armbruster, D. J. N., Ueltzhöffer, K., Basten, U., & Fiebach, C. J. (2012). Prefrontal cortical mechanisms underlying individual differences in cognitive flexibility and stability. Journal of Cognitive Neuroscience. 24, 2385-2399.
#
# Thank you!!!
#
############ HOW TO USE THIS PYTHON SCRIPT ##############    Diana Armbruster-Genc, Oct 2015, diana.armbruster at gmx.de
# if you have any questions, trouble, or find bugs please let me know!
#
# this script is for the analysis of behavioral data of the StabFlex paradigm (Armbruster et al., 2012) and outputs mean RTs and error rates as well as the number of switches in the ambiguous condition (2 outputs: correct ambis switches and all ambis switches, i.e., also those ambi switches where sbjs switched but pressed the wrong button)
# parts that have to be adjusted according to the names of your logfiles etc. are marked with ### UPDATE
# there are 3 parts that HAVE TO BE UPDATED: subject number lists, logfile names and content of output files (at the end of this script)
# logfiles should be copied to the log folder in the analysis folder
#
# output textfiles with the results are saved in the folder results
# the current data of 4 subjects are example data to get an idea how it should look like :)
#
##########################################################################################################################################

from StabFlex_functions import * 
# the StabFlex_functions file contains all relevant functions needed for this script, it must be in the same folder as this StabFlex_RUNscript

#########################################################################################################################################
## UPDATE these two LISTS (numbers are the subject numbers with right or left randomization)
#########################################################################################################################################

right = [1, 3] 
left = [2, 4]

## this stays the same
subjects_unsorted = right + left
subjects_sorted = sorted(subjects_unsorted)

right_randos = []
for i in subjects_sorted:
    for j in right:
        if i == j:
            right_randos.append(subjects_sorted.index(i))


left_randos = []
for i in subjects_sorted:
    for j in left:
        if i == j:
            left_randos.append(subjects_sorted.index(i))


##################

block1 = []
block2 = []

##### UPDATE this part! ################ i.e. insert the name of your logfiles and adjust directory if necessary

block1.append( readLogFile("../logs/example_logfile_sbj1_right_block1.log") ) 
block2.append( readLogFile("../logs/example_logfile_sbj1_right_block2.log") )

block1.append( readLogFile("../logs/example_logfile_sbj2_left_block1.log") ) 
block2.append( readLogFile("../logs/example_logfile_sbj2_left_block2.log") )

block1.append( readLogFile("../logs/example_logfile_sbj3_right_block1.log") ) 
block2.append( readLogFile("../logs/example_logfile_sbj3_right_block2.log") )

block1.append( readLogFile("../logs/example_logfile_sbj4_left_block1.log") ) 
block2.append( readLogFile("../logs/example_logfile_sbj4_left_block2.log") )

# and so on

##################################################
## this stays the same 
##################################################

#function readLogFile returns [conditionsTotal, errorsTotal, responsesTotal, reactionTimesTotal, brightnessTotal, stim1Total, stim2Total, stickTimesTotal]

## ERRORS #####
# 1) first create list with 1 for each error (for each condition separately) 
errors_list = []
for i in range(0, len(block1)):
    errors_list.append(sortErrors(block1[i][0] + block2[i][0], block1[i][1] + block2[i][1]))

# 2) sum up these lists to get absolute number of errors per subject and condition
errorsNormal = []  
for i in range(0, len(block1)):
    errorsNormal.append(sum(errors_list[i][0]))
# nochmal aufsummieren
errorsNormalTotal = sum(errorsNormal) # eine Zahl

errorsDistr = []
for i in range(0, len(block1)):
    errorsDistr.append(sum(errors_list[i][1]))
errorsDistrTotal = sum(errorsDistr)

errorsSwitch = []
for i in range(0, len(block1)):
    errorsSwitch.append(sum(errors_list[i][2]))
errorsSwitchTotal = sum(errorsSwitch)


# 3) lists with error rates
errorsNormalPercent = []
for i in range(0, len(block1)):
    errorsNormalPercent.append(errorsNormal[i] * 100.0 / 240.0)  # CAVE: adjust if you change absolute number of trials, e.g., when using patient paradigm (less trials!)

errorsDistrPercent = []
for i in range(0, len(block1)):
    errorsDistrPercent.append(errorsDistr[i] * 100.0 / 20.0)
   
errorsSwitchPercent = []
for i in range(0, len(block1)):
    errorsSwitchPercent.append(errorsSwitch[i] * 100.0 / 20.0)


# write name of variable at the beginning of the list
errorsNormalPercent.insert(0, "errorRates_ongoing")
errorsDistrPercent.insert(0, "errorRates_distractor")
errorsSwitchPercent.insert(0, "errorRates_switch")



## REACTION TIMES #####

# 1) sortReactionTimes > function sortReactionTimes needs: conditionsTotal, reactionTimesTotal, errorsTotal (in this order!)
# returns 4 lists with RTs per condition: ongoing, distr, switch und ambi (in this order)

RTlist = []  
for i in range(0,len(block1)):
    RTlist.append(sortReactionTimes(block1[i][0] + block2[i][0], block1[i][3] + block2[i][3], block1[i][1] + block2[i][1]))

#function ambiSwitchesRT needs: conditions, responses, reactionTimesTotal, stim1, stim2, li = 0
ambiRTlist = [] 
ambiRTlist_right = []
ambiRTlist_left = []

RTambi_switches = []
RTambi_nonSwitches = []
  
for i in right_randos:
    ambiRTlist_right.append(ambiSwitchesRT(block1[i][0] + block2[i][0], block1[i][2] + block2[i][2], block1[i][3] + block2[i][3], block1[i][5] + block2[i][5], block1[i][6] + block2[i][6]))

for i in left_randos:
    ambiRTlist_left.append(ambiSwitchesRT(block1[i][0] + block2[i][0], block1[i][2] + block2[i][2], block1[i][3] + block2[i][3], block1[i][5] + block2[i][5], block1[i][6] + block2[i][6], li = 1))

ambiRTlist = [ambiRTlist_right + ambiRTlist_left]

for i in range(0, len(block1)):
    RTambi_switches.append((ambiRTlist[0][i][0])/10.0)

for i in range(0, len(block1)):
    RTambi_nonSwitches.append((ambiRTlist[0][i][1])/10.0)

# write name of variable at the beginning of the list
RTambi_switches.insert(0, "RT_ambiSwitches")
RTambi_nonSwitches.insert(0, "RT_ambiNonSwitches")


# 2) averages of subjects per condition in one list

RTnormal_mean = []
for i in range(0, len(block1)):
    RTnormal_mean.append((numpy.average(RTlist[i][0]))/10.0)  

RTdistr_mean = []
for i in range(0, len(block1)):
    RTdistr_mean.append((numpy.average(RTlist[i][1]))/10.0)


RTswitch_mean = []
for i in range(0, len(block1)):
    RTswitch_mean.append((numpy.average(RTlist[i][2]))/10.0)


# to get ms divide by 10 

    
# write name of variable at the beginning of the list
RTnormal_mean.insert(0, "RTongoing")
RTdistr_mean.insert(0, "RTdistractor")
RTswitch_mean.insert(0, "RTswitch")

#### NUMBER of Switches in ambi-condition (=condition 4)

correctAmbiSwitches = []
totalAmbiSwitches = []

# right rando
allAmbiSwitches_right = []
for i in right_randos:
    allAmbiSwitches_right.append(ambiSwitches(block1[i][0] + block2[i][0], block1[i][2] + block2[i][2], block1[i][4] + block2[i][4], block1[i][5] + block2[i][5], block1[i][6] + block2[i][6] ))

# left rando
allAmbiSwitches_left = []
for i in left_randos:
    allAmbiSwitches_left.append(ambiSwitches(block1[i][0] + block2[i][0], block1[i][2] + block2[i][2], block1[i][4] + block2[i][4], block1[i][5] + block2[i][5], block1[i][6] + block2[i][6], li = 1 ))

# fuse right and left
allAmbiSwitches = [allAmbiSwitches_right + allAmbiSwitches_left]


for i in range(0, len(block1)):
    correctAmbiSwitches.append(allAmbiSwitches[0][i][0])
    
for i in range(0, len(block1)):
   totalAmbiSwitches.append(allAmbiSwitches[0][i][1] + allAmbiSwitches[0][i][0])


correctAmbiSwitches.insert(0, "ambiSwitches_correct")
totalAmbiSwitches.insert(0, "ambiSwitches_total")


###########################################################################################################
############## UPDATE: PRINTING out what you need   ######################
###########################################################################################################

subjects_sorted.insert(0, "sbj")
subjects_unsorted.insert(0, "sbj")

printToFile("../results/Example_behavioralData.txt", subjects_sorted, errorsNormalPercent, errorsDistrPercent, errorsSwitchPercent, RTnormal_mean, RTdistr_mean, RTswitch_mean)

printToFile("../results/Example_Ambis.txt", subjects_unsorted, RTambi_switches, RTambi_nonSwitches, totalAmbiSwitches, correctAmbiSwitches)

### two files are needed as the ambiguous data are in different subject order than the other performance data, so before fusing these to files make sure that they are in the same subject order!
### these files are saved in the folder results


