import sys
import numpy
import scipy
import scipy.stats.stats
import matplotlib.pyplot as plt
import math

def ambiCorrect(response, stim1, stim2, li = 0):
    
    res = int(response)%10
    
    stim1 = int(stim1)
    stim2 = int(stim2)
    
    li = int(li)
    
    if res == 4 and li == 0 and stim2 > 5:
        return 1
    elif res == 3 and li == 0 and stim2 < 5:
        return 1
    elif res == 1 and li == 0 and stim1%2 == 1:
        return 1
    elif res == 2 and li == 0 and stim1%2 == 0:
        return 1
    if res == 4 and li == 1 and stim1%2 == 0:
        return 1
    elif res == 3 and li == 1 and stim1%2 == 1:
        return 1
    elif res == 1 and li == 1 and stim2 < 5:
        return 1
    elif res == 2 and li == 1 and stim2 > 5:
        return 1
    else:
        return 0
    
    return 0

    
def ambiSwitch(response, brightness, li = 0):
    if li == 0 and response%10 > 2:
        return 1
    elif li == 1 and response%10 < 3:
        return 1
    else:
        return 0
        
    return 0

    
def ambiSwitches(conditions, responses, brightness, stim1, stim2, li = 0): # nehme mir conditions, responses u. brightness
    CorrectAmbiSwitches = []
    IncorrectAmbiSwitches = []
    CorrectAmbiNonSwitches = []
    IncorrectAmbiNonSwitches = []
    misses = []
    
    for i in range(0,len(conditions)):
            
        if conditions[i] == 4:
            if ambiCorrect(responses[i], stim1[i], stim2[i],li) == 1 and ambiSwitch(responses[i], brightness[i],li) == 1:
                CorrectAmbiSwitches.append(1)
            elif ambiCorrect(responses[i], stim1[i], stim2[i],li) == 0 and ambiSwitch(responses[i], brightness[i],li) == 1:
                IncorrectAmbiSwitches.append(1)
            elif ambiCorrect(responses[i], stim1[i], stim2[i],li) == 1 and ambiSwitch(responses[i], brightness[i],li) == 0:
                CorrectAmbiNonSwitches.append(1)
            elif ambiCorrect(responses[i], stim1[i], stim2[i],li) == 0 and ambiSwitch(responses[i], brightness[i],li) == 0:
                IncorrectAmbiNonSwitches.append(1)
            else:
                misses.append(1)
    
    return len(CorrectAmbiSwitches), len(IncorrectAmbiSwitches), len(CorrectAmbiNonSwitches), len(IncorrectAmbiNonSwitches), len(misses)


def ambiSwitchesRT(conditions, responses, reactionTimesTotal, stim1, stim2, li = 0): # nehme mir conditions, responses u. brightness
    CorrectAmbiSwitchesRT = []
    CorrectAmbiNonSwitchesRT = []
    misses = []
    
    for i in range(0,len(conditions)):
        
        if conditions[i] == 4:
            if ambiCorrect(responses[i], stim1[i], stim2[i],li) == 1 and ambiSwitch(responses[i], li) == 1:
                CorrectAmbiSwitchesRT.append(reactionTimesTotal[i])
            elif ambiCorrect(responses[i], stim1[i], stim2[i],li) == 1 and ambiSwitch(responses[i], li) == 0:
                CorrectAmbiNonSwitchesRT.append(reactionTimesTotal[i])
    
    return numpy.average(CorrectAmbiSwitchesRT), numpy.average(CorrectAmbiNonSwitchesRT)


def ambiSwitchesRT_trimmed(conditions, responses, reactionTimesTotal, stim1, stim2, li = 0):
    CorrectAmbiSwitchesRT = []
    CorrectAmbiNonSwitchesRT = []
    misses = []
    
    for i in range(0,len(conditions)):
        
        if conditions[i] == 4:
            if ambiCorrect(responses[i], stim1[i], stim2[i],li) == 1 and ambiSwitch(responses[i], li) == 1 and reactionTimesTotal[i] > 1500:
                CorrectAmbiSwitchesRT.append(reactionTimesTotal[i])
            elif ambiCorrect(responses[i], stim1[i], stim2[i],li) == 1 and ambiSwitch(responses[i], li) == 0 and reactionTimesTotal[i] > 1500:
                CorrectAmbiNonSwitchesRT.append(reactionTimesTotal[i])
    
    return numpy.average(CorrectAmbiSwitchesRT), numpy.average(CorrectAmbiNonSwitchesRT)


def sortReactionTimes(conditionsTotal, reactionTimesTotal, errorsTotal):
    
    reactionTimesNormal = []
    reactionTimesDistract = []
    reactionTimesSwitch = []
    reactionTimesAmbiguous = []
    
    for i in range(0,len(conditionsTotal)):
        if conditionsTotal[i] == 1 and errorsTotal[i] == 0:
            reactionTimesNormal.append(reactionTimesTotal[i])
        elif conditionsTotal[i] == 2 and errorsTotal[i] == 0:
            reactionTimesDistract.append(reactionTimesTotal[i])
        elif conditionsTotal[i] == 3 and errorsTotal[i] == 0:
            reactionTimesSwitch.append(reactionTimesTotal[i])
        elif conditionsTotal[i] == 4 and errorsTotal[i] == 0:
            reactionTimesAmbiguous.append(reactionTimesTotal[i])
    
    return [reactionTimesNormal, reactionTimesDistract, reactionTimesSwitch, reactionTimesAmbiguous]


def sortReactionTimes_trimmed(conditionsTotal, reactionTimesTotal, errorsTotal):
    
    reactionTimesNormal = []
    reactionTimesDistract = []
    reactionTimesSwitch = []
    reactionTimesAmbiguous = []

    for i in range(0,len(conditionsTotal)):
        if conditionsTotal[i] == 1 and errorsTotal[i] == 0 and reactionTimesTotal[i] > 1500:
            reactionTimesNormal.append(reactionTimesTotal[i])
        elif conditionsTotal[i] == 2 and errorsTotal[i] == 0 and reactionTimesTotal[i] > 1500:
            reactionTimesDistract.append(reactionTimesTotal[i])
        elif conditionsTotal[i] == 3 and errorsTotal[i] == 0 and reactionTimesTotal[i] > 1500:
            reactionTimesSwitch.append(reactionTimesTotal[i])
        elif conditionsTotal[i] == 4 and errorsTotal[i] == 0 and reactionTimesTotal[i] > 1500:
            reactionTimesAmbiguous.append(reactionTimesTotal[i])
            
    return [reactionTimesNormal, reactionTimesDistract, reactionTimesSwitch, reactionTimesAmbiguous]


def sortErrors(conditionsTotal, errorsTotal):
    
    errorsNormal = []
    errorsDistract = []
    errorsSwitch = []
    errorsAmbiguous = []
    
    for i in range(0,len(conditionsTotal)):
        if conditionsTotal[i] == 1 and errorsTotal[i] == 1:
            errorsNormal.append(1)
        elif conditionsTotal[i] == 1 and errorsTotal[i] == 2:
            errorsNormal.append(1)
        
        elif conditionsTotal[i] == 2 and errorsTotal[i] == 1: 
            errorsDistract.append(1)
        elif conditionsTotal[i] == 2 and errorsTotal[i] == 2:
            errorsDistract.append(1)
        
        elif conditionsTotal[i] == 3 and errorsTotal[i] == 1:
            errorsSwitch.append(1)
        elif conditionsTotal[i] == 3 and errorsTotal[i] == 2:
            errorsSwitch.append(1)
        
        elif conditionsTotal[i] == 4 and errorsTotal[i] == 1:
            errorsAmbiguous.append(1)
        elif conditionsTotal[i] == 4 and errorsTotal[i] == 2:
            errorsAmbiguous.append(1)
    
    return [errorsNormal, errorsDistract, errorsSwitch, errorsAmbiguous]

    
    
def readLogFile(logfilename, second_block = 0):
    
    print "Accessing", logfilename, "..."
    
    f = file(logfilename)
    lines = f.readlines()
    
    num_lines = len(lines)
    
    pulseTimes = []
    eventTimes = []
    responseTimes = []
    
    reactionTimesTotal = []
    conditionsTotal = []
    errorsTotal = [] # 0: kein Fehler, 1: Fehler, 2: Miss
    responsesTotal = []
    brightnessTotal = []
    stim1Total = []
    stim2Total = []
    onsetTimesTotal = []
    stickTimesTotal = []
    
    resp_given = 1
    
    for i in range(num_lines):
        row = lines[i].strip().split()
        if len(row) >= 5 and row[2] == "Pulse":
            pulseTimes.append( int( row[4] ) )
            
        if len(row) >= 4 and row[3].strip().split(":")[0] == "cond":
            eventTimes.append( int( row[4] ) )
            if resp_given == 1:
                resp_given = 0 
            else:
                errorsTotal.append(2)
                reactionTimesTotal.append(-1)
                responsesTotal.append(-1)
            
            condition = int(row[3][5])                
            
            stim1 = row[3][25]
            stim2 = row[3][26]
                
            if stim2 == '*':
                stim2 = -1
                
            templist = row[3].rsplit(':')
            brightness = templist[len(templist)-1]
            stim1Total.append( stim1 )
            stim2Total.append( stim2 )
            brightnessTotal.append( int(brightness) )
            conditionsTotal.append(condition)
            
        if len(row) >= 4 and row[2] == "Response" and resp_given == 0:
            responseTimes.append( int( row[4] ) )
            resp_given = 1
            resp_time = float(row[5])
            response = int(row[3])
            if response > 100:
                errorsTotal.append(0)
            else:
                errorsTotal.append(1)
            reactionTimesTotal.append(resp_time)
            responsesTotal.append(response)
            
    for i in range(len(eventTimes)):
        mintime = math.fabs(eventTimes[i]-pulseTimes[0])
        minindex = 0
        for j in range(len(pulseTimes)):
            if math.fabs(eventTimes[i]-pulseTimes[j]) < mintime:
                mintime = math.fabs(eventTimes[i]-pulseTimes[j])
                minindex = j
        
        stickTimesTotal.append( 0.0001*(eventTimes[i] - pulseTimes[minindex]) + 1.8*(minindex - 3) )
            
    print len(pulseTimes), "Pulses counted:"
    print pulseTimes
    
    print len(eventTimes), "Events counted:"
    print eventTimes
    
    print len(responseTimes), "Responses counted:"
    print responseTimes
    
    print "Results:"
    
    print "conditions: ", conditionsTotal, len(conditionsTotal)
    print "stim1: ", stim1Total, len(stim1Total)
    print "stim2: ", stim2Total, len(stim2Total)
    print "error: ", errorsTotal, len(errorsTotal)
    print "responses:", responsesTotal, len(responsesTotal)
    print "RT: ", reactionTimesTotal, len(reactionTimesTotal)
    print "brightness: ", brightnessTotal, len(brightnessTotal)
    print "sticktimes: ", stickTimesTotal, len(stickTimesTotal)
    
    return [conditionsTotal, errorsTotal, responsesTotal, reactionTimesTotal, brightnessTotal, stim1Total, stim2Total, stickTimesTotal]



def printToFile(filename, *args):
    
    outfile = file(filename, 'w')
    
    for i in range(0,len(args[0])):
        for a in args:
            if type(a[i]) == type("y"):
                outfile.write(str(a[i]))
                outfile.write(" ")  
            else:
                outfile.write(str(float(a[i])))
                outfile.write(" ")            
        outfile.write('\n')
    
    outfile.close()
    
    return



    
