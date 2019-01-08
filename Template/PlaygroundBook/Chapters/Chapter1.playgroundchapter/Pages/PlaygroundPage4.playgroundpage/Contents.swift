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
 Goal：let Matatabot play music.
 
 Matatabot is happy to sing! Use music instruction to sing.
 > Connect to your MatataBot before you start!!
 */
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, doDance(_:), playMusic(_:), playMelody(_:), playAlto(_:), playTreble(_:), playAlto(_:, _:), playTreble(_:, _:))
//#-code-completion(identifier, show, Meter, Dance, Music, One, Two, Three, Four, Five, Six)
//#-code-completion(identifier, show, Melody, Seven, Eight, Nine, Ten)
//#-code-completion(identifier, show, Tone, Do, Re, Mi, Fa, Sol, La, Ti)
//#-code-completion(identifier, show, ., func)
//#-hidden-code
setup()
cleancode()
//#-end-hidden-code
//#-editable-code Tap to enter your Code!!
playAlto(Tone.Do)
playAlto(Tone.Do)
playAlto(Tone.Sol)
playAlto(Tone.Sol)
playAlto(Tone.La)
playAlto(Tone.La)
playAlto(Tone.Sol,Meter.Two)
    
playAlto(Tone.Fa)
playAlto(Tone.Fa)
playAlto(Tone.Mi)
playAlto(Tone.Mi)
playAlto(Tone.Re)
playAlto(Tone.Re)
playAlto(Tone.Do,Meter.Two)
//#-end-editable-code
//#-hidden-code
runcode()
//#-end-hidden-code
