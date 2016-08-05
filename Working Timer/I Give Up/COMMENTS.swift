/* This is a project that I made to try to fit the different pieces of code that we have together. 
 -I made a storyboard that has a Welcome (Start) Screen and a Program (Running) Screen.
    The Welcome Screen consists of a "Let's Go" button that segues to the next screen.
    The Program Screen has only the timer because of reasons that I explain below.
 -About the Timer: I used the SimpleStopDemo from Ravi Shankar. I took out the milliseconds display on the timer because I found it distracting. This file's class is SWViewController.
 -About the Lion Animation: this I have not incorporated into the main code. Although it is possible to create a split view on the Program Screen (not using a SplitView Controller), the class of the Controller is set at the top in the yellow-circle "Program" section. Therefore, both views have the same class and if the buttons in the working view call the timer, the remaining view cannot call on the code in the file GameScene.swift because it is a different class.
 -Closing words
    This is endlessly frustrating to me and I tried to rewrite the code so that the two fragments could be in the same class without success.
    At this point, I'm not sure what direction to take next. So far every attempt that we have made to collate our disparate pieces of code has ended in failure. That is not to say that we will continue to fail, but I foresee a long and difficult process before we succeed and I think we may be forced to rewrite some of the code to reach that point. I will be at a more optimistic point in the morning so I will see you guys then.
 */