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
 Goal：Lead Matatabot to bypass obstacles and go out of the maze No.3.
 
 Try using Loop, which called by the keyword 'for'.
 > Connect to your MatataBot before you start!!
 */
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, moveForward(), moveBackward(), moveForward(_:), moveBackward(_:), turnLeft(), turnRight())
//#-code-completion(keyword, show, for, repeat, while, var, let, func)
//#-code-completion(identifier, show, Step, One, Two, Three, Four, Five, Six)
//#-code-completion(identifier, show, .)
//#-hidden-code
setup()
cleancode()
//#-end-hidden-code
//#-editable-code Tap to enter your Code!!
for i in 1...3{
    moveForward(Step.Three)
    turnRight()
}
//#-end-editable-code
//#-hidden-code
runcode()
//#-end-hidden-code
