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
 Goal：Lead Matatabot to bypass obstacles and go out of the maze No.1.
 
 Obsacles appear on the map, find the path to bypass them.
 
 Call moveForward(),turnRight(),turnLeft(), and moveBackward(), which is the Basic Motion Funtion, to arrive at the destination.
 > Connect to your MatataBot before you start!!
 */
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, moveForward(), moveBackward(), turnLeft(), turnRight())
//#-hidden-code
setup()
cleancode()
//#-end-hidden-code
//#-editable-code Tap to enter your Code!!
moveForward()
turnRight()
moveForward()
turnRight()
moveForward()
//#-end-editable-code
//#-hidden-code
runcode()
//#-end-hidden-code

