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
 Goal：Lead Matatabot to bypass obstacles and go out of the maze No.2 .
 
 Try using moveFoward(Step.Three) and see how Matatabot will move.
 > Connect to your MatataBot before you start!!
 */
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, moveForward(), moveForward(_:), turnLeft(), turnRight())
//#-code-completion(identifier, show, Step, One, Two, Three, Four, Five, Six)
//#-code-completion(identifier, show, .)
//#-hidden-code
setup()
cleancode()
//#-end-hidden-code
//#-editable-code Tap to enter your Code!!
moveForward(Step.Three)
turnRight()
moveForward(Step.Three)
//#-end-editable-code
//#-hidden-code
runcode()
//#-end-hidden-code

