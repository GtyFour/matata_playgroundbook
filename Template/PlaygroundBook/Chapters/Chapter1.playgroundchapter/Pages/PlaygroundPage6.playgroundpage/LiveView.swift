import UIKit
import Foundation
import PlaygroundSupport
import PlaygroundBluetooth

public let viewController : LiveViewController = LiveViewController("connect.png", "disconnect.png")
PlaygroundPage.current.liveView = viewController
