//#-hidden-code
//
//  Contents.swift
//
//  Creat by GtyFour 2019-01-02 15:33:23
//


import UIKit
import CoreBluetooth
import PlaygroundBluetooth
import PlaygroundSupport

//clearCode()
//#-end-hidden-code
/*:
 Goal：let Matatabot draw.
 
 In motion, Matatabot can turn to more angles. Using Motion, Digital Parameters, Angle Parameters, Loops and some other blocks to let Matatabot pick up brush and create drawings.
 > Connect to your MatataBot before you start!!
 */
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, moveForward(), moveBackward(), turnLeft(), turnRight(), moveForward(_:), moveBackward(_:), turnLeft(_:), turnRight(_:),for)
//#-code-completion(identifier, show, Step, One, Two, Three, Four, Five, Six)
//#-code-completion(identifier, show, Angle, Degree30, Degree36, Degree45, Degree60, Degree72, Degree90, Degree108, Degree120, Degree135, Degree144, Degree150)
//#-code-completion(identifier, show, .,func)
//#-hidden-code
setup()
cleancode()
//#-end-hidden-code
//#-editable-code Tap to enter your Code!!
for i in 1...3{
    moveForward()
    turnLeft(Angle.Degree120)
}
turnRight()
for i in 1...3{
    moveForward()
    turnLeft()
}
//#-end-editable-code
//#-hidden-code
runcode()
//#-end-hidden-code
