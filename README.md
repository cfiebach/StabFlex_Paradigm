**The StabFlex-Paradigm** (Armbruster, Ueltzhöffer, Basten, & Fiebach
2012)

... is programmed with „Presentation“ software, version ....

... is available in a „right“ version, i.e., the ongoing task (=odd/even
decision) is performed by the right hand, and the „switch“ task
(=smaller/larger than 5 decision) is performed by the left hand and in a
„left“ version, where the tasks are performed vice versa.

... is provided here in the way we applied it in the above-cited fMRI
study, i.e., involving training outside the scanner, refresher and main
task inside the scanner.

**Required material:**

-   Presentation files

-   Randomization files (.txt files) - in the same folder as the
    respective presentation files

-   PC with Presentation software installed and marked buttons („x“,
    „c“, „n“, „m“)

CAVE: First adjust the directories to the logfiles and presentation
files in the .exp files!

**Buttons (using a German or English keyboard)**

-   **Odd / even decision:**\
    right rando: right index finger on „n“ (=odd),\
    right middle finger on „m“ (=even)\
    left rando: left index finger on „c“ (=even),\
    left middle finger on „x“ (=odd)

-   **Smaller / larger 5 decision:**\
    right rando: left index finger on „c“ (=larger 5)\
    left middle finger on „x“ (=smaller 5)\
    left Rando: right index finger on „n“ (=smaller 5)\
    right middle finger on „m“ (=larger 5)

**TRAINING**

-   Go into the *“training\_outside”* directory and decide whether you
    want to train your subject with the “right” or “left” version (see
    above).

-   Double click on the *Flex\_right\_singleNo.exp /
    Flex\_left\_singleNo.exp* file, respectively, and click on “Run
    nonstop”:\
    The subject reads the instructions and then, first, trains the
    odd/even decision (20 trials with a number appearing above the
    fixation cross)\
    In a second block, the subject trains the smaller/larger than 5
    decision (20 trials with a number appearing beyond the fixation
    cross)\
    At the end, the percent correct is shown on the screen. If it is low
    (e.g., smaller than 80% correct), you can decide, whether the
    subject should repeat one or both blocks of training.

-   Double click on the *Flex\_Training\_right\_all.exp /
    Flex\_Training\_left\_all.exp* file, respectively, and click on “Run
    nonstop”:\
    The subject reads the instructions. You can decide, whether you want
    to let the subject repeat and explain in his / her own words, how he
    / she understood the task. We always pointed out, that at the
    beginning the task is quite difficult as it is very fast, but that
    the subject should keep on concentrating and that after a few trials
    it will probably work out fine.\
    The subject now works through 3 blocks of training:\
    1. block: 60 trials with right / wrong feedback, no ambiguous
    trials\
    2. block: 80 trials with right / wrong feedback, no ambiguous
    trials\
    3. block: 100 trials without feedback, ambiguous trials included
    (but the subject only gets the information that differences in
    brightness might now be harder to recognize).\
    Again, at the end, the percent correct is shown on the screen. If
    for example, at the end of the third block it is low (e.g., smaller
    than 80% correct), you can decide, whether the subject should repeat
    the last block of training.\
    Finally, you can point out that the subject will be able to train
    again a few trials of the task, after positioned into the
    fMRI-scanner (refresher), that it should always try to answer and
    press a button, even if it finds it hard to decide, and that it
    should lay very still during the whole scanning session.

**MAIN TASK (in the fMRI scanner)**

**1. Refresher**: short training to familiarize the subject with the
assignment of keys in the scanner (60 trials including all conditions)

-   Go into the *“refresher\_scanner”* directory and decide whether you
    want to train your subject with the “right” or “left” version (see
    above).

-   Double click on *Flex\_ScannerTrain\_right\_exp.exp /
    Flex\_ScannerTrain\_left\_exp.exp* respectively and start with RUN

-   To allow for correct positioning of the screen in the scanner, the
    experiment starts with a fixation cross and two \#. Ask the subject
    whether he / she can recognize everything well.

    -   If subject answers with yes, continue by pressing „c“ on the
        presentation PC

    -   If no: adjust screen etc.

-   Next, the subjects sees a small reminder of the assignment of keys
    and is asked to press with the right index finger if he / she is
    ready for the refresher. The refresher starts then automatically. If
    the subject is not ready or presses another button, you should ask
    if everything is fine and then start the refresher again.

**2. Main task**

-   Go into the *“main\_experiment”* directory. Go into the *“woman”* or
    *“men”* directory (this is to allow for balancing sex more easily),
    respectively. Double click on *Flex\_main\_women\_exp.exp /
    Flex\_main\_men\_exp.exp* and start by clicking on “RUN NONSTOP”\
    (Note: ‘women’ and ‘men’ are two different randomizations; this is
    simply a left over of how we balanced different randomizations
    across participants’ genders.)

-   1\. popup-window: enter the subject code

<!-- -->

-   2\. popup-window: enter the name of the textfile containing the
    randomization.\
    men: mX\_r\_b1 or mX\_l\_b1, with X = consecutive number of men and r =
    right, l = left\
    women: fX\_r\_b1 or fX\_l\_b1, with X = consecutive number of women and
    r = right, l = left (CAVE: odd X is always a right rando, and even X is
    always a left rando)\
    (this is to make sure, that randomizations are counterbalances across
    men & women)

<!-- -->

-   At the beginning of the block the subject is asked to press with
    right index finger when he / she is ready to continue. If he / she
    does so, the scanner starts and the Presentation waits for 3 pulses
    before it starts the experiment.

---------- **1. BLOCK** \[5 min; healthy controls: 150 trials, patients:
100 trials\] --------------

-   start the 2. block, by entering into the popup-window:\
    men: mX\_r\_b2 or mX\_l\_b2 with X = consecutive number of men and r
    = right, l = left\
    women: fX\_r\_b2 or fX\_l\_b2, with X = consecutive number of women
    and r = right, l = left\
    (CAVE: odd X is always a right rando, and even X is always a left
    rando)

---------- **2. BLOCK** \[5 min; healthy controls: 150 trials, patients:
100 trials\] -------------

The End

These materials were developed by Diana Armbruster-Genc, Kai
Ueltzhöffer, Ulrike Basten, and Christian Fiebach, 2011-2015; Fiebach
Lab for Cognitive Neuroscience, Dept. of Psychology, Goethe University
Frankfurt.

When using these materilas, please cite:

Armbruster, D. J. N., Ueltzhöffer, K., Basten, U., & Fiebach, C. J.
(2012). Prefrontal cortical mechanisms underlying individual differences
in cognitive flexibility and stability. *Journal of Cognitive
Neuroscience*. 24, 2385-2399.

See also:

Ueltzhöffer, K., Armbruster-Genc, D. J., & Fiebach, C. J. (2015).
Stochastic dynamics underlying cognitive stability and flexibility.
*PLOS Computational Biology*, e1004331.
