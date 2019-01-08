import UIKit
import Foundation
import PlaygroundBluetooth
import PlaygroundSupport

public func cleancode(){
    matataEvaluator.cleancode()
}

public func runcode(){
    matataEvaluator.runcode()
}

public func start(){
    matataEvaluator.start()
}

public func stop(){
    matataEvaluator.stop()
}

public func moveForward(){
    matataEvaluator.moveForward(Step.Default)
}

public func moveForward(_ step:Step){
    matataEvaluator.moveForward(step)
}

public func moveBackward(){
    matataEvaluator.moveBackward(Step.Default)
}

public func moveBackward(_ step:Step){
    matataEvaluator.moveForward(step)
}

public func turnLeft(){
    matataEvaluator.turnLeft(Angle.Default)
}

public func turnLeft(_ angle:Angle){
    matataEvaluator.turnLeft(angle)
}

public func turnRight(){
    matataEvaluator.turnRight(Angle.Default)
}

public func turnRight(_ angle:Angle){
    matataEvaluator.turnRight(angle)
}

public func doAction(_ Number:Action){
    matataEvaluator.doAction(Number)
}

public func doDance(_ Number:Dance){
    matataEvaluator.doDance(Number)
}

public func playMusic(_ Number:Music){
    matataEvaluator.playMusic(Number)
}

public func playMelody(_ Number:Melody){
    matataEvaluator.playMelody(Number)
}

public func playAlto(_ alto:Tone){
    matataEvaluator.playAlto(alto)
}

public func playTreble(_ treble:Tone){
    matataEvaluator.playTreble(treble)
}

public func playAlto(_ alto:Tone,_ meter:Meter){
    matataEvaluator.playAlto(alto, meter)
}

public func playTreble(_ treble:Tone, _  meter:Meter){
    matataEvaluator.playTreble(treble, meter)
}
