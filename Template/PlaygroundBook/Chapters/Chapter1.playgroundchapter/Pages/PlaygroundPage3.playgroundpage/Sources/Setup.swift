import Foundation
import PlaygroundSupport
import PlaygroundBluetooth


var delegate: MatataProxyDelegate?
let matataEvaluator:MatataEvaluator = MatataEvaluator()

public func setup(){
    let page = PlaygroundPage.current
    page.needsIndefiniteExecution = true
    let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy
    delegate = MatataProxyDelegate(pauseHandler: matataEvaluator)
    delegate?.onAssessment = assessment
    proxy?.delegate = delegate
}

public func assessment(_ playgroundValue:PlaygroundValue)->Bool{
    // Assessment
    let result:Bool = true
    //Update assessment status
    PlaygroundPage.current.assessmentStatus = .pass(message: NSLocalizedString("### Nice one! \nDash has got the moves!\n\n[**Learn More**](http://makewonder.com/playbook) about Dash.", comment: ""))
    return result
}
