//
//  MatataEvaluator.swift
//  Book_Sources
//
//  Created by GtyFour on 2019/1/3.
//

import Foundation
import CoreBluetooth
import PlaygroundSupport
import PlaygroundBluetooth

public protocol MatataPauseDelegate {
    var readyToMove: Bool { get set }
    var returnValue: Bool { get set }
}
extension MatataPauseDelegate {
    /// Waits until `isReadyForMoreCommands` is set to true.
    func wait() {
        repeat {
            RunLoop.main.run(mode: .default, before: Date(timeIntervalSinceNow: 0.1))
        } while !readyToMove
    }
}
public class MatataEvaluator : NSObject, MatataPauseDelegate{

    var command: PlaygroundValue = .string("")
    
    public var readyToMove = true
    public var returnValue = false
    
    
    public override init(){
    }
    
    public func sendCommand(_ commandData:PlaygroundValue) {
        let page = PlaygroundPage.current
        if let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy {
            proxy.send(commandData)
        }
        // Spin the runloop until the LiveView process has completed the current command.
        readyToMove = false
        wait()
    }

    //MARK: 基础运动

    public func moveForward(_ step: Step){
        switch step {
        case .Default:  command = .string(FORWARD_0); break
        case .One:      command = .string(FORWARD_1); break
        case .Two:      command = .string(FORWARD_2); break
        case .Three:    command = .string(FORWARD_3); break
        case .Four:     command = .string(FORWARD_4); break
        case .Five:     command = .string(FORWARD_5); break
        case .Six:      command = .string(FORWARD_6); break
        }
        sendCommand(command)
    }
    
    public func moveBackward(_ step: Step){
        switch step {
        case .Default:  command = .string(BACKWARD_0); break
        case .One:      command = .string(BACKWARD_1); break
        case .Two:      command = .string(BACKWARD_2); break
        case .Three:    command = .string(BACKWARD_3); break
        case .Four:     command = .string(BACKWARD_4); break
        case .Five:     command = .string(BACKWARD_5); break
        case .Six:      command = .string(BACKWARD_6); break
        }
        sendCommand(command)
    }
    
    public func turnLeft(_ angle: Angle){
        switch angle {
        case .Default:  command = .string(TURNLEFT_0); break
        case .Degree30:  command = .string(TURNLEFT_30); break
        case .Degree36:  command = .string(TURNLEFT_36); break
        case .Degree45:  command = .string(TURNLEFT_45); break
        case .Degree60:  command = .string(TURNLEFT_60); break
        case .Degree72:  command = .string(TURNLEFT_72); break
        case .Degree90:  command = .string(TURNLEFT_90); break
        case .Degree108: command = .string(TURNLEFT_108);break
        case .Degree120: command = .string(TURNLEFT_120);break
        case .Degree135: command = .string(TURNLEFT_135);break
        case .Degree144: command = .string(TURNLEFT_144);break
        case .Degree150: command = .string(TURNLEFT_150);break
        }
        sendCommand(command)
    }
    
    public func turnRight(_ angle: Angle){
        switch angle {
        case .Default:  command = .string(TURNRIGHT_0); break
        case .Degree30:  command = .string(TURNRIGHT_30); break
        case .Degree36:  command = .string(TURNRIGHT_36); break
        case .Degree45:  command = .string(TURNRIGHT_45); break
        case .Degree60:  command = .string(TURNRIGHT_60); break
        case .Degree72:  command = .string(TURNRIGHT_72); break
        case .Degree90:  command = .string(TURNRIGHT_90); break
        case .Degree108: command = .string(TURNRIGHT_108);break
        case .Degree120: command = .string(TURNRIGHT_120);break
        case .Degree135: command = .string(TURNRIGHT_135);break
        case .Degree144: command = .string(TURNRIGHT_144);break
        case .Degree150: command = .string(TURNRIGHT_150);break
        }
        sendCommand(command)
    }
    public func doAction(_ action:Action){
        switch action {
        case .Default:  command = .string(ACTION_1); break
        case .One:      command = .string(ACTION_1); break
        case .Two:      command = .string(ACTION_2); break
        case .Three:    command = .string(ACTION_3); break
        case .Four:     command = .string(ACTION_4); break
        case .Five:     command = .string(ACTION_5); break
        case .Six:      command = .string(ACTION_6); break
        }
        sendCommand(command)
    }
    
    
    //MARK: 艺术模块
    public func playMusic(_ music:Music){
        switch music {
        case .Default:  command = .string(MUSIC_1); break
        case .One:      command = .string(MUSIC_1); break
        case .Two:      command = .string(MUSIC_2); break
        case .Three:    command = .string(MUSIC_3); break
        case .Four:     command = .string(MUSIC_4); break
        case .Five:     command = .string(MUSIC_5); break
        case .Six:      command = .string(MUSIC_6); break
        }
        sendCommand(command)
    }
    
    public func doDance(_ dance:Dance){
        switch dance {
        case .Default:  command = .string(DANCE_1); break
        case .One:      command = .string(DANCE_1); break
        case .Two:      command = .string(DANCE_2); break
        case .Three:    command = .string(DANCE_3); break
        case .Four:     command = .string(DANCE_4); break
        case .Five:     command = .string(DANCE_5); break
        case .Six:      command = .string(DANCE_6); break
        }
        sendCommand(command)
    }
    public func playMelody(_ melody: Melody){
        switch melody {
        case .Default:  command = .string(MELODY_1); break
        case .One:      command = .string(MELODY_1); break
        case .Two:      command = .string(MELODY_2); break
        case .Three:    command = .string(MELODY_3); break
        case .Four:     command = .string(MELODY_4); break
        case .Five:     command = .string(MELODY_5); break
        case .Six:      command = .string(MELODY_6); break
        case .Seven:    command = .string(MELODY_7); break
        case .Eight:    command = .string(MELODY_8); break
        case .Nine:     command = .string(MELODY_9); break
        case .Ten:      command = .string(MELODY_10);break
        }
        sendCommand(command)
    }
    public func playAlto(_ alto:Tone,_ meter:Meter){
        var str : String!
        switch alto {
        case .Default:  str = ALTO_1; break
        case .Do:       str = ALTO_1; break
        case .Re:       str = ALTO_2; break
        case .Mi:       str = ALTO_3; break
        case .Fa:       str = ALTO_4; break
        case .Sol:      str = ALTO_5; break
        case .La:       str = ALTO_6; break
        case .Ti:       str = ALTO_7; break
        }
        switch meter {
        case .Default:  command = .string(str + METER_1); break
        case .One:      command = .string(str + METER_1); break
        case .Two:      command = .string(str + METER_2); break
        case .Three:    command = .string(str + METER_3); break
        case .Four:     command = .string(str + METER_4); break
        case .Five:     command = .string(str + METER_5); break
        case .Six:      command = .string(str + METER_6); break
        }
        sendCommand(command)
    }
    public func playAlto(_ alto:Tone){
        var str : String!
        switch alto {
        case .Default:  str = ALTO_1; break
        case .Do:       str = ALTO_1; break
        case .Re:       str = ALTO_2; break
        case .Mi:       str = ALTO_3; break
        case .Fa:       str = ALTO_4; break
        case .Sol:      str = ALTO_5; break
        case .La:       str = ALTO_6; break
        case .Ti:       str = ALTO_7; break
        }
        command = .string(str)
        sendCommand(command)
    }
    public func playTreble(_ treble:Tone,_ meter:Meter){
        var str : String!
        switch treble {
        case .Default:  str = TREBLE_1; break
        case .Do:       str = TREBLE_1; break
        case .Re:       str = TREBLE_2; break
        case .Mi:       str = TREBLE_3; break
        case .Fa:       str = TREBLE_4; break
        case .Sol:      str = TREBLE_5; break
        case .La:       str = TREBLE_6; break
        case .Ti:       str = TREBLE_7; break
        }
        switch meter {
        case .Default:  command = .string(str + METER_1); break
        case .One:      command = .string(str + METER_1); break
        case .Two:      command = .string(str + METER_2); break
        case .Three:    command = .string(str + METER_3); break
        case .Four:     command = .string(str + METER_4); break
        case .Five:     command = .string(str + METER_5); break
        case .Six:      command = .string(str + METER_6); break
        }
        sendCommand(command)
    }
    public func playTreble(_ treble: Tone){
        var str : String!
        switch treble {
        case .Default:  str = TREBLE_1; break
        case .Do:       str = TREBLE_1; break
        case .Re:       str = TREBLE_2; break
        case .Mi:       str = TREBLE_3; break
        case .Fa:       str = TREBLE_4; break
        case .Sol:      str = TREBLE_5; break
        case .La:       str = TREBLE_6; break
        case .Ti:       str = TREBLE_7; break
        }
        command = .string(str)
        sendCommand(command)
    }
    //MARK: 控制
    public func cleancode(){
        command = .string(CLEANCODE)
        sendCommand(command)
    }
    public func runcode(){
        command = .string(RUNCODE)
        sendCommand(command)
    }
    public func stop(){
        command = .string(STOP)
        sendCommand(command)
    }
    public func start(){
        command = .string(START)
        sendCommand(command)
    }
    public func adjustmentTurn(_ direction: Direction,_ angle:Angle,_ step: AdjustStep){
        var str : String!
        if direction == Direction.Left{
            switch angle {
            case .Degree30:     str = ADJUSTMENT_TURN + TURNLEFT_30; break
            case .Degree36:     str = ADJUSTMENT_TURN + TURNLEFT_36; break
            case .Degree45:     str = ADJUSTMENT_TURN + TURNLEFT_45; break
            case .Degree60:     str = ADJUSTMENT_TURN + TURNLEFT_60; break
            case .Degree72:     str = ADJUSTMENT_TURN + TURNLEFT_72; break
            case .Degree90:     str = ADJUSTMENT_TURN + TURNLEFT_90; break
            case .Degree108:    str = ADJUSTMENT_TURN + TURNLEFT_108; break
            case .Degree120:    str = ADJUSTMENT_TURN + TURNLEFT_120; break
            case .Degree135:    str = ADJUSTMENT_TURN + TURNLEFT_135; break
            case .Degree144:    str = ADJUSTMENT_TURN + TURNLEFT_144; break
            case .Degree150:    str = ADJUSTMENT_TURN + TURNLEFT_150; break
            case .Default:      str = ADJUSTMENT_TURN + TURNLEFT_90; break
            }
        }else if direction == Direction.Right{
            switch angle {
            case .Degree30:     str = ADJUSTMENT_TURN + TURNRIGHT_30; break
            case .Degree36:     str = ADJUSTMENT_TURN + TURNRIGHT_36; break
            case .Degree45:     str = ADJUSTMENT_TURN + TURNRIGHT_45; break
            case .Degree60:     str = ADJUSTMENT_TURN + TURNRIGHT_60; break
            case .Degree72:     str = ADJUSTMENT_TURN + TURNRIGHT_72; break
            case .Degree90:     str = ADJUSTMENT_TURN + TURNRIGHT_90; break
            case .Degree108:    str = ADJUSTMENT_TURN + TURNRIGHT_108; break
            case .Degree120:    str = ADJUSTMENT_TURN + TURNRIGHT_120; break
            case .Degree135:    str = ADJUSTMENT_TURN + TURNRIGHT_135; break
            case .Degree144:    str = ADJUSTMENT_TURN + TURNRIGHT_144; break
            case .Degree150:    str = ADJUSTMENT_TURN + TURNRIGHT_150; break
            case .Default:      str = ADJUSTMENT_TURN + TURNRIGHT_90; break
            }
        }else if direction == Direction.Right{
            str = ADJUSTMENT_LINE
        }

        switch step {
        case .PlusStep:
            command = .string(str + PLUSSTEP)
            break
        case .MinusStep:
            command = .string(str + MINUSSTEP)
            break
        }
        sendCommand(command)
    }
}
