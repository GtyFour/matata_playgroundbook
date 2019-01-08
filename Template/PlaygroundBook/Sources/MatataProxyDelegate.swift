//
//  MatataProxyDelegate.swift
//  Book_Sources
//
//  Created by GtyFour on 2019/1/5.
//
import PlaygroundSupport

public class MatataProxyDelegate: PlaygroundRemoteLiveViewProxyDelegate {
    
    public var pauseHandler: MatataPauseDelegate?
    
    public init(pauseHandler: MatataPauseDelegate?) {
        self.pauseHandler = pauseHandler
    }
    
    public var onAssessment:((PlaygroundValue)->Bool)?
    
    public init() {
        
    }
    
    //On live view connection closed
    public func remoteLiveViewProxyConnectionClosed(_ remoteLiveViewProxy: PlaygroundRemoteLiveViewProxy) {
        // Kill user process if LiveView process closed.
        PlaygroundPage.current.finishExecution()
    }
    
    //Receive message from live view
    public func remoteLiveViewProxy(_ remoteLiveViewProxy: PlaygroundRemoteLiveViewProxy, received message: PlaygroundValue) {
        if case let .string(text) = message {
            if text.isEqual("MessageReceived"){
                pauseHandler?.readyToMove = true
            }
        }
//        if case let .dictionary(dict) = message {
//            if case let .string(sensorValue) = dict["SensorReceived"]! {
//                let data:Bool = (sensorValue == "true")
//                pauseHandler?.returnValue = data;
//                pauseHandler?.readyToMove = true
//            }
//        }
//        // Update Hints and Assessments
//        if case let .array(commands) = message {
//            let result:Bool = (onAssessment?(message))!
//            //Send Result to live view
//            let resultValue: PlaygroundValue = .boolean(result)
//            remoteLiveViewProxy.send(resultValue)
//        }
        // Kill user process if LiveView process closed.
        if case let .string(text) = message {
            if text.isEqual("ProgramFinished"){
                PlaygroundPage.current.finishExecution()
            }
        }
    }
}
