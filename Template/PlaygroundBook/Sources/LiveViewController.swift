import UIKit
import CoreBluetooth
import PlaygroundBluetooth
import PlaygroundSupport

@objc(Book_Sources_LiveViewController)
public class LiveViewController: UIViewController, PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer {
    
    private var scanBtn: UIButton?//测试用扫描按钮，隐藏备用
    
    public var expression = [UInt8]()
    public var expressionArray = [[UInt8]]()
    fileprivate var retriveServiceIndex = 0
    open var isFree = false
    fileprivate var curPeripheral:CBPeripheral?
    fileprivate lazy var containCharacteristics = [CBCharacteristic]()
    fileprivate var completeHandle: (() -> Void)?
    
    private let centralManager = PlaygroundBluetoothCentralManager(services: nil, queue: .main)
    private var connectionView : PlaygroundBluetoothConnectionView?
    public var evaluator : MatataEvaluator?
    public var connect_str : String!
    public var disconnect_str : String!
    
    private var bleImageView : UIImageView?

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    public convenience init(_ con:String,_ discon:String) {
        self.init(nibName:nil, bundle:nil)
        self.connect_str = con
        self.disconnect_str = discon
        
    }
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        evaluator = MatataEvaluator()
        if (connect_str == nil) {connect_str = "connect.png"}
        if (disconnect_str == nil) {disconnect_str = "disconnect.png"}
        
        scanBtn = UIButton(frame: CGRect(x: view.frame.midX - 100, y: view.frame.minY + 20, width: 100, height: 30))
        scanBtn?.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5)
        scanBtn?.tintColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.5)
        scanBtn?.titleLabel?.text = "TEST"
        scanBtn?.titleLabel?.tintColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.5)
        scanBtn!.addTarget(self, action: #selector(scan), for: .touchUpInside)
        
        self.bleImageView = UIImageView(frame: CGRect(x: view.frame.minX, y: view.frame.minY, width: view.frame.height*0.667, height: view.frame.height))
        self.bleImageView?.image = UIImage(named: disconnect_str)
        view.addSubview(bleImageView!)
//        view.addSubview(scanBtn!)
        
        centralManager.delegate = self
        
        let connectionView = PlaygroundBluetoothConnectionView(centralManager: centralManager)
        connectionView.delegate = self
        connectionView.dataSource = self
        
        view.addSubview(connectionView)
        NSLayoutConstraint.activate([
            connectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            connectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            ])
        
        self.connectionView = connectionView
    }
    
    @IBAction func scan(_ sender: UIButton) {
        setBleImage(con: "page_0.png", discon: "page_0.png")
    }
    
    public func setBleImage(con: String, discon: String){
        connect_str = con
        disconnect_str = discon
    }
    public func liveViewMessageConnectionOpened() {
        self.send(.string("Greetings from the always-on live view."))
    }
 
    public func liveViewMessageConnectionClosed() {
        self.send(.string("Bye!"))
    }

    public func receive(_ message: PlaygroundValue) {
//        if let curPer : CBPeripheral = centralManager.connectedPeripherals.first {
//
//        }else{
//            //暂时未添加蓝牙状态判断
//        }
        if case let .string(command) = message { // Commands
            if command.isEqual(RUNCODE){
               runcode()
            }else if command.isEqual(CLEANCODE){
                cleancode()
            }else if command.isEqual(STOP){
                stop()
            }else if command.isEqual(START){
                start()
            }else{
                let array : Array = command.components(separatedBy: "_")
                switch array.first {
                    
                case FORWARD :
                    switch array.last{
                    case Step.Default.rawValue: moveForward();break
                    case Step.One.rawValue: moveForward(Step.One);break
                    case Step.Two.rawValue: moveForward(Step.Two); break
                    case Step.Three.rawValue: moveForward(Step.Three); break
                    case Step.Four.rawValue: moveForward(Step.Four); break
                    case Step.Five.rawValue: moveForward(Step.Five); break
                    case Step.Six.rawValue: moveForward(Step.Six); break
                    case .none: break
                    case .some(_): break
                    }
                    break
                    
                case BACKWARD :
                    switch array.last{
                    case Step.Default.rawValue: moveBackward(); break
                    case Step.One.rawValue: moveBackward(Step.One); break
                    case Step.Two.rawValue: moveBackward(Step.Two); break
                    case Step.Three.rawValue: moveBackward(Step.Three); break
                    case Step.Four.rawValue: moveBackward(Step.Four); break
                    case Step.Five.rawValue: moveBackward(Step.Five); break
                    case Step.Six.rawValue: moveBackward(Step.Six); break
                    case .none: break
                    case .some(_): break
                    }
                    break
                    
                case TURNLEFT :
                    switch array.last{
                    case Angle.Default.rawValue: turnLeft(); break
                    case Angle.Degree30.rawValue: turnLeft(Angle.Degree30); break
                    case Angle.Degree36.rawValue: turnLeft(Angle.Degree36); break
                    case Angle.Degree45.rawValue: turnLeft(Angle.Degree45); break
                    case Angle.Degree60.rawValue: turnLeft(Angle.Degree60); break
                    case Angle.Degree72.rawValue: turnLeft(Angle.Degree72); break
                    case Angle.Degree90.rawValue: turnLeft(Angle.Degree90); break
                    case Angle.Degree108.rawValue: turnLeft(Angle.Degree108); break
                    case Angle.Degree120.rawValue: turnLeft(Angle.Degree120); break
                    case Angle.Degree135.rawValue: turnLeft(Angle.Degree135); break
                    case Angle.Degree144.rawValue: turnLeft(Angle.Degree144); break
                    case Angle.Degree150.rawValue: turnLeft(Angle.Degree150); break
                    case .none: break
                    case .some(_): break
                    }
                    break
                    
                case TURNRIGHT :
                    switch array.last{
                    case Angle.Default.rawValue: turnRight(); break
                    case Angle.Degree30.rawValue: turnRight(Angle.Degree30); break
                    case Angle.Degree36.rawValue: turnRight(Angle.Degree36); break
                    case Angle.Degree45.rawValue: turnRight(Angle.Degree45); break
                    case Angle.Degree60.rawValue: turnRight(Angle.Degree60); break
                    case Angle.Degree72.rawValue: turnRight(Angle.Degree72); break
                    case Angle.Degree90.rawValue: turnRight(Angle.Degree90); break
                    case Angle.Degree108.rawValue: turnRight(Angle.Degree108); break
                    case Angle.Degree120.rawValue: turnRight(Angle.Degree120); break
                    case Angle.Degree135.rawValue: turnRight(Angle.Degree135); break
                    case Angle.Degree144.rawValue: turnRight(Angle.Degree144); break
                    case Angle.Degree150.rawValue: turnRight(Angle.Degree150); break
                    case .none: break
                    case .some(_): break
                    }
                    break
                    
                case MELODY :
                    switch array.last{
                    case Melody.Default.rawValue: playMelody(Melody.One); break
                    case Melody.One.rawValue: playMelody(Melody.One); break
                    case Melody.Two.rawValue: playMelody(Melody.Two); break
                    case Melody.Three.rawValue: playMelody(Melody.Three); break
                    case Melody.Four.rawValue: playMelody(Melody.Four); break
                    case Melody.Five.rawValue: playMelody(Melody.Five); break
                    case Melody.Six.rawValue: playMelody(Melody.Six); break
                    case Melody.Seven.rawValue: playMelody(Melody.Seven); break
                    case Melody.Eight.rawValue: playMelody(Melody.Eight); break
                    case Melody.Nine.rawValue: playMelody(Melody.Nine); break
                    case Melody.Ten.rawValue: playMelody(Melody.Ten); break
                    case .none: break
                    case .some(_): break
                    }
                    break
                    
                case ACTION :
                    switch array.last{
                    case Action.Default.rawValue: doAction(Action.One); break
                    case Action.One.rawValue: doAction(Action.One); break
                    case Action.Two.rawValue: doAction(Action.Two); break
                    case Action.Three.rawValue: doAction(Action.Three); break
                    case Action.Four.rawValue: doAction(Action.Four); break
                    case Action.Five.rawValue: doAction(Action.Five); break
                    case Action.Six.rawValue: doAction(Action.Six); break
                    case .none: break
                    case .some(_): break
                    }
                    break
                    
                case MUSIC :
                    switch array.last{
                    case Music.Default.rawValue: playMusic(Music.One); break
                    case Music.One.rawValue: playMusic(Music.One); break
                    case Music.Two.rawValue: playMusic(Music.Two); break
                    case Music.Three.rawValue: playMusic(Music.Three); break
                    case Music.Four.rawValue: playMusic(Music.Four); break
                    case Music.Five.rawValue: playMusic(Music.Five); break
                    case Music.Six.rawValue: playMusic(Music.Six); break
                    case .none: break
                    case .some(_): break
                    }
                    break
                    
                case DANCE :
                    switch array.last{
                    case Dance.Default.rawValue: doDance(Dance.One); break
                    case Dance.One.rawValue: doDance(Dance.One); break
                    case Dance.Two.rawValue: doDance(Dance.Two); break
                    case Dance.Three.rawValue: doDance(Dance.Three); break
                    case Dance.Four.rawValue: doDance(Dance.Four); break
                    case Dance.Five.rawValue: doDance(Dance.Five); break
                    case Dance.Six.rawValue: doDance(Dance.Six); break
                    case .none: break
                    case .some(_): break
                    }
                    break
                    
                case ALTO :
                    if(array.count == 2){
                        switch array.last{
                        case Tone.Default.rawValue: playAlto(Tone.Do); break
                        case Tone.Do.rawValue: playAlto(Tone.Do); break
                        case Tone.Re.rawValue: playAlto(Tone.Re); break
                        case Tone.Mi.rawValue: playAlto(Tone.Mi); break
                        case Tone.Fa.rawValue: playAlto(Tone.Fa); break
                        case Tone.Sol.rawValue: playAlto(Tone.Sol); break
                        case Tone.La.rawValue: playAlto(Tone.La); break
                        case Tone.Ti.rawValue: playAlto(Tone.Ti); break
                        default: break
                        }
                    }else if(array.count == 4){
                        var t : Tone? = .Default
                        var m : Meter? = .Default
                        
                        switch array[1]{
                        case Tone.Default.rawValue: t = Tone.Do; break
                        case Tone.Do.rawValue: t = Tone.Do; break
                        case Tone.Re.rawValue: t = Tone.Re; break
                        case Tone.Mi.rawValue: t = Tone.Mi; break
                        case Tone.Fa.rawValue: t = Tone.Fa; break
                        case Tone.Sol.rawValue: t = Tone.Sol; break
                        case Tone.La.rawValue: t = Tone.La; break
                        case Tone.Ti.rawValue: t = Tone.Ti; break
                        default:break
                        }
                        switch array.last{
                        case Meter.Default.rawValue: m = Meter.One; break
                        case Meter.One.rawValue: m = Meter.One; break
                        case Meter.Two.rawValue: m = Meter.Two; break
                        case Meter.Three.rawValue: m = Meter.Three; break
                        case Meter.Four.rawValue: m = Meter.Four; break
                        case Meter.Five.rawValue: m = Meter.Five; break
                        case Meter.Six.rawValue: m = Meter.Six; break
                        default:break
                        }
                        playAlto(t!,m!)
                    }else{
                        //data broken, do nothing
                    }
                   
                    break
                    
                case TREBLE :
                    if(array.count == 2){
                        switch array.last{
                        case Tone.Default.rawValue: playTreble(Tone.Do); break
                        case Tone.Do.rawValue: playTreble(Tone.Do); break
                        case Tone.Re.rawValue: playTreble(Tone.Re); break
                        case Tone.Mi.rawValue: playTreble(Tone.Mi); break
                        case Tone.Fa.rawValue: playTreble(Tone.Fa); break
                        case Tone.Sol.rawValue: playTreble(Tone.Sol); break
                        case Tone.La.rawValue: playTreble(Tone.La); break
                        case Tone.Ti.rawValue: playTreble(Tone.Ti); break
                        default:break
                        }
                    }else if(array.count == 4){
                        var t : Tone? = .Default
                        var m : Meter? = .Default
                        
                        switch array[1]{
                        case Tone.Default.rawValue: t = Tone.Do; break
                        case Tone.Do.rawValue: t = Tone.Do; break
                        case Tone.Re.rawValue: t = Tone.Re; break
                        case Tone.Mi.rawValue: t = Tone.Mi; break
                        case Tone.Fa.rawValue: t = Tone.Fa; break
                        case Tone.Sol.rawValue: t = Tone.Sol; break
                        case Tone.La.rawValue: t = Tone.La; break
                        case Tone.Ti.rawValue: t = Tone.Ti; break
                        default:break
                        }
                        switch array.last{
                        case Meter.Default.rawValue: m = Meter.One; break
                        case Meter.One.rawValue: m = Meter.One; break
                        case Meter.Two.rawValue: m = Meter.Two; break
                        case Meter.Three.rawValue: m = Meter.Three; break
                        case Meter.Four.rawValue: m = Meter.Four; break
                        case Meter.Five.rawValue: m = Meter.Five; break
                        case Meter.Six.rawValue: m = Meter.Six; break
                        default:break
                        }
                        playTreble(t!,m!)
                    }else{
                        //data broken, do nothing
                    }
                    break
                    
                case ADJUSTMENT :
                    if array.count == 3{
                        switch array.last{
                        case AdjustStep.PlusStep.rawValue: adjustmentLine(AdjustStep.PlusStep); break
                        case AdjustStep.MinusStep.rawValue: adjustmentLine(AdjustStep.MinusStep); break
                        default:break
                        }
                    }else if array.count == 4{
                        
                        var d : Direction? = .Left
                        var a : Angle? = .Default
                        var s : AdjustStep? = .PlusStep
                        switch array[1]{
                        case Direction.Left.rawValue: d = Direction.Left; break
                        case Direction.Right.rawValue: d = Direction.Right; break
                        default: break
                        }
                        switch array[2]{
                        case "30": a = Angle.Degree30; break
                        case "36": a = Angle.Degree36; break
                        case "45": a = Angle.Degree45; break
                        case "60": a = Angle.Degree60; break
                        case "72": a = Angle.Degree72; break
                        case "90": a = Angle.Degree90; break
                        case "108": a = Angle.Degree108; break
                        case "120": a = Angle.Degree120; break
                        case "135": a = Angle.Degree135; break
                        case "144": a = Angle.Degree144; break
                        case "150": a = Angle.Degree150; break
                        default: a = Angle.Degree90;break
                        }
                        switch array.last{
                        case AdjustStep.PlusStep.rawValue: s = AdjustStep.PlusStep; break
                        case AdjustStep.MinusStep.rawValue: s = AdjustStep.MinusStep;break
                        default:break
                        }
                        adjustmentTurn(d!,a!,s!);
                    }
                    break
                    
                case .none:
                    break
                    
                case .some(_):
                    break
                }
            }
        }
        // Send a message in response.
        self.send(.string("MessageReceived"))
    }
    
    public func sendMessage(_ message: PlaygroundValue) {
        send(message)
    }
}

//MARK: PlaygroundBluetoothConnectionViewDelegate
extension LiveViewController: PlaygroundBluetoothConnectionViewDelegate {
    
    open  func connectionView(_ connectionView: PlaygroundBluetoothConnectionView, shouldDisplayDiscovered peripheral: CBPeripheral, withAdvertisementData advertisementData: [String : Any]?, rssi: Double) -> Bool {
        if peripheral.name == "Matalab"{
            return true
        }else{
            return false
        }
    }
    
    open func connectionView(_ connectionView: PlaygroundBluetoothConnectionView, shouldConnectTo peripheral: CBPeripheral, withAdvertisementData advertisementData: [String : Any]?, rssi: Double) -> Bool {
        return true
    }
    
    open  func connectionView(_ connectionView: PlaygroundBluetoothConnectionView, willDisconnectFrom peripheral: CBPeripheral) {
    }
    
    open  func connectionView(_ connectionView: PlaygroundBluetoothConnectionView, titleFor state: PlaygroundBluetoothConnectionView.State) -> String {
        return "\(state)"
    }
    
    open  func connectionView(_ connectionView: PlaygroundBluetoothConnectionView, firmwareUpdateInstructionsFor peripheral: CBPeripheral) -> String {
        return #function
    }
}

//MARK: PlaygroundBluetoothConnectionViewDataSource
extension LiveViewController: PlaygroundBluetoothConnectionViewDataSource {
    
    open  func connectionView(_ connectionView: PlaygroundBluetoothConnectionView, itemForPeripheral peripheral: CBPeripheral, withAdvertisementData advertisementData: [String : Any]?) -> PlaygroundBluetoothConnectionView.Item {
        let name = peripheral.name ?? "Unknown"
        let icon = UIImage(named: "ble_icon.png")
        let item = PlaygroundBluetoothConnectionView.Item(name: name, icon: icon!, issueIcon: icon!, firmwareStatus: nil, batteryLevel: nil)
        return item
    }
}
//MARK: PlaygroundBluetoothCentralManagerDelegate
extension LiveViewController: PlaygroundBluetoothCentralManagerDelegate {
    
    open  func centralManagerStateDidChange(_ centralManager: PlaygroundBluetoothCentralManager) {
    }
    
    open  func centralManager(_ centralManager: PlaygroundBluetoothCentralManager, didDiscover peripheral: CBPeripheral, withAdvertisementData advertisementData: [String : Any]?, rssi: Double) {
    }
    
    open  func centralManager(_ centralManager: PlaygroundBluetoothCentralManager, willConnectTo peripheral: CBPeripheral) {
    }
    
    open  func centralManager(_ centralManager: PlaygroundBluetoothCentralManager, didConnectTo peripheral: CBPeripheral) {
        peripheral.delegate = self
        peripheral.discoverServices([CBUUID.MatataServiceUUID])
        self.bleImageView?.image =  UIImage(named: connect_str)
    }
    
    open  func centralManager(_ centralManager: PlaygroundBluetoothCentralManager, didFailToConnectTo peripheral: CBPeripheral, error: Error?) {
        
        self.bleImageView?.image =  UIImage(named: disconnect_str)
    }
    
    open  func centralManager(_ centralManager: PlaygroundBluetoothCentralManager, didDisconnectFrom peripheral: CBPeripheral, error: Error?) {
        
        self.bleImageView?.image =  UIImage(named: disconnect_str)
    }
    
}

//MARK: - CBPeripheralDelegate
extension LiveViewController: CBPeripheralDelegate {
    
    open func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        containCharacteristics.removeAll()
        guard let services = peripheral.services else { return }
        _ = services.map {
            peripheral.discoverCharacteristics(nil, for: $0)
        }
    }
    
    open func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?)  {
        guard let characteristics = service.characteristics else { return }
        containCharacteristics = characteristics.reduce(containCharacteristics) {
            if $1.properties.contains(CBCharacteristicProperties.notify) {
                peripheral.setNotifyValue(true, for: $1)
            }
            return $0 + [$1]
        }
        
        retriveServiceIndex += 1
        if retriveServiceIndex == peripheral.services!.count {
            self.isFree = true
            self.completeHandle?()
        }
    }
    
    open func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        
    }
    
    open func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        guard (error == nil) else { return }
    }
    open func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let value = characteristic.value?.first {
            print(value)
        }
    }
    
    /**
     define types for writing data to BLE device, like this
     */
    open func writeDataWithResponse(_ data: Data) {
        do {
            try self.writeData(data, characterUUIDStr: CBUUID.MatataWriteUUID.uuidString, withResponse: true)
        } catch let error {
            print("[Error: ]__Write Data Error    " + "\(error)")
        }
    }
    /**
     write data to BLE without Response
     */
    open func writeDataWithoutResponse(_ data: Data) {
        do {
            //            print("writeDataWithoutResponse")
            try self.writeData(data, characterUUIDStr:CBUUID.MatataWriteUUID.uuidString, withResponse: false)
        } catch let error {
            print("[Error: ]__Write Data Error    " + "\(error)")
        }
    }
    /**
     read data, such as read battery/ read heart rate
     */
    open func readData(_ characterUUIDStr: String) {
        do {
            try self.readCharacteristic(characterUUIDStr)
            
        } catch let error {
            print("[Error: ]__Read Data Error    " + "\(error)")
        }
    }
    
    open func writeData(_ data: Data, characterUUIDStr: String, withResponse: Bool) throws {
        do {
            let (per, chara) = try self.prepareForAction(characterUUIDStr)
            let type: CBCharacteristicWriteType = withResponse ? .withResponse : .withoutResponse
            per.writeValue(data, for: chara, type: type)
        } catch let error {
            throw error
        }
    }
    
    open func readCharacteristic(_ characterUUIDStr: String) throws {
        do {
            let (per, chara) = try self.prepareForAction(characterUUIDStr)
            per.readValue(for: chara)
        } catch let error {
            throw error
        }
    }
    
    fileprivate func prepareForAction(_ UUIDStr: String) throws -> (CBPeripheral, CBCharacteristic) {
        guard let curPeripheral = centralManager.connectedPeripherals.first else {
            throw CBError(.peripheralDisconnected)
        }
        let flatResults = containCharacteristics.compactMap { (chara) -> CBCharacteristic? in
            if chara.uuid.uuidString.lowercased() == UUIDStr.lowercased() {
                return chara
            }
            return nil
        }
        if flatResults.count == 0 {
            throw CBError(.uuidNotAllowed)
        }
        return (curPeripheral, flatResults.first!)
    }
    
}

//MARK: - MatataParser
extension LiveViewController{
    public func expressionClear(){
        expression.removeAll()
    }
    public func evaluate(_ expr:[UInt8]) -> Data {
        
        return Data(bytes: expr)
    }
    //MARK: 基础运动
    public func moveForward(){
        expression.append(0)
    }
    public func moveForward(_ step: Step){
        expression.append(32)
        switch step {
        case .Default: expression.append(1); break
        case .One: expression.append(1); break
        case .Two: expression.append(2); break
        case .Three: expression.append(3); break
        case .Four: expression.append(4); break
        case .Five: expression.append(5); break
        case .Six: expression.append(6); break
        }
    }
    public func moveBackward(){
        expression.append(3)
    }
    public func moveBackward(_ step: Step){
        expression.append(35)
        switch step {
        case .Default: expression.append(1); break
        case .One: expression.append(1); break
        case .Two: expression.append(2); break
        case .Three: expression.append(3); break
        case .Four: expression.append(4); break
        case .Five: expression.append(5); break
        case .Six: expression.append(6); break
        }
    }
    public func turnLeft(){
        expression.append(1)
    }
    public func turnRight(){
        expression.append(2)
    }
    public func turnLeft(_ angle: Angle){
        expression.append(33)
        switch angle {
        case .Default: expression.append(90); break
        case .Degree30: expression.append(30); break
        case .Degree36: expression.append(36); break
        case .Degree45: expression.append(45); break
        case .Degree60: expression.append(60); break
        case .Degree72: expression.append(72); break
        case .Degree90: expression.append(90); break
        case .Degree108: expression.append(108); break
        case .Degree120: expression.append(120); break
        case .Degree135: expression.append(135); break
        case .Degree144: expression.append(144); break
        case .Degree150: expression.append(150); break
        }
        
    }
    public func turnRight(_ angle: Angle){
        expression.append(34)
        switch angle {
        case .Default: expression.append(90); break
        case .Degree30: expression.append(30); break
        case .Degree36: expression.append(36); break
        case .Degree45: expression.append(45); break
        case .Degree60: expression.append(60); break
        case .Degree72: expression.append(72); break
        case .Degree90: expression.append(90); break
        case .Degree108: expression.append(108); break
        case .Degree120: expression.append(120); break
        case .Degree135: expression.append(135); break
        case .Degree144: expression.append(144); break
        case .Degree150: expression.append(150); break
        }
    }
    public func doAction(_ action:Action){
        expression.append(59)
        switch action {
        case .Default: expression.append(1); break
        case .One: expression.append(1); break
        case .Two: expression.append(2); break
        case .Three: expression.append(3); break
        case .Four: expression.append(4); break
        case .Five: expression.append(5); break
        case .Six: expression.append(6); break
        }
    }
    
    
    //MARK: 艺术模块
    public func playMusic(_ music:Music){
        expression.append(57)
        switch music {
        case .Default: expression.append(1); break
        case .One: expression.append(1); break
        case .Two: expression.append(2); break
        case .Three: expression.append(3); break
        case .Four: expression.append(4); break
        case .Five: expression.append(5); break
        case .Six: expression.append(6); break
        }
    }
    
    public func doDance(_ dance:Dance){
        expression.append(58)
        switch dance {
        case .Default: expression.append(1); break
        case .One: expression.append(1); break
        case .Two: expression.append(2); break
        case .Three: expression.append(3); break
        case .Four: expression.append(4); break
        case .Five: expression.append(5); break
        case .Six: expression.append(6); break
        }
    }
    public func playMelody(_ melody: Melody){
        expression.append(84)
//        switch melody {
//        case .Default: expression.append(3); break
//        case .One: expression.append(3); break
//        case .Two: expression.append(20); break
//        case .Three: expression.append(4); break
//        case .Four: expression.append(17); break
//        case .Five: expression.append(18); break
//        case .Six: expression.append(1); break
//        case .Seven: expression.append(12); break
//        case .Eight: expression.append(19); break
//        case .Nine: expression.append(9); break
//        case .Ten: expression.append(8); break
//        }
        switch melody {
        case .Default: expression.append(1); break
        case .One: expression.append(1); break
        case .Two: expression.append(2); break
        case .Three: expression.append(3); break
        case .Four: expression.append(4); break
        case .Five: expression.append(5); break
        case .Six: expression.append(6); break
        case .Seven: expression.append(7); break
        case .Eight: expression.append(8); break
        case .Nine: expression.append(9); break
        case .Ten: expression.append(10); break
        }
    }
    public func playAlto(_ alto:Tone,_ meter:Meter){
        expression.append(112)
        switch alto {
        case .Default: expression.append(1); break
        case .Do: expression.append(1); break
        case .Re: expression.append(2); break
        case .Mi: expression.append(3); break
        case .Fa: expression.append(4); break
        case .Sol: expression.append(5); break
        case .La: expression.append(6); break
        case .Ti: expression.append(7); break
        }
        switch meter {
        case .Default: expression.append(1); break
        case .One: expression.append(1); break
        case .Two: expression.append(2); break
        case .Three: expression.append(3); break
        case .Four: expression.append(4); break
        case .Five: expression.append(5); break
        case .Six: expression.append(6); break
        }
    }
    public func playAlto(_ alto:Tone){
        expression.append(80)
        switch alto {
        case .Default: expression.append(1); break
        case .Do: expression.append(1); break
        case .Re: expression.append(2); break
        case .Mi: expression.append(3); break
        case .Fa: expression.append(4); break
        case .Sol: expression.append(5); break
        case .La: expression.append(6); break
        case .Ti: expression.append(7); break
        }
    }
    public func playTreble(_ treble:Tone,_ meter:Meter){
        expression.append(112)
        switch treble {
        case .Default: expression.append(1); break
        case .Do: expression.append(1); break
        case .Re: expression.append(2); break
        case .Mi: expression.append(3); break
        case .Fa: expression.append(4); break
        case .Sol: expression.append(5); break
        case .La: expression.append(6); break
        case .Ti: expression.append(7); break
        }
        switch meter {
        case .Default: expression.append(1); break
        case .One: expression.append(1); break
        case .Two: expression.append(2); break
        case .Three: expression.append(3); break
        case .Four: expression.append(4); break
        case .Five: expression.append(5); break
        case .Six: expression.append(6); break
        }
    }
    public func playTreble(_ treble: Tone){
        expression.append(81)
        switch treble {
        case .Default: expression.append(1); break
        case .Do: expression.append(1); break
        case .Re: expression.append(2); break
        case .Mi: expression.append(3); break
        case .Fa: expression.append(4); break
        case .Sol: expression.append(5); break
        case .La: expression.append(6); break
        case .Ti: expression.append(7); break
        }
    }
    //MARK: 控制
    public func cleancode(){
        expressionClear()
    }
    public func runcode(){
        
        if expression.count <= 20 {
            self.writeDataWithoutResponse(evaluate(expression))
        }else
        {
            let c = expression.count
            let t = expression.count/20
            let tail = c - ( 20 * t )
            for _ in 1...t{
                var resultArray = [UInt8]()
                for _ in 1...20{
                    resultArray.append(expression.remove(at: 0))
                }
                self.writeDataWithoutResponse(evaluate(resultArray))
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.04){}
            }
            if(tail>0){
                var resultArray = [UInt8]()
                for _ in 1...tail{
                    resultArray.append(expression.remove(at: 0))
                }
                self.writeDataWithoutResponse(evaluate(resultArray))
            }
        }
        
        // Send a message in response.
        self.send(.string("ProgramFinished"))
    }
    public func stop(){
        expression.append(132)
    }
    public func start(){
        expression.append(133)
    }
    public func adjustmentTurn(_ direction: Direction,_ angle:Angle,_ step: AdjustStep){
        if direction == Direction.Left{
            expression.append(97)
        }else if direction == Direction.Right{
            expression.append(98)
        }
        switch angle {
        case Angle.Degree30:
            expression.append(30)
            break
        case Angle.Degree36:
            expression.append(36)
            break
        case Angle.Degree45:
            expression.append(45)
            break
        case Angle.Degree60:
            expression.append(60)
            break
        case Angle.Degree72:
            expression.append(72)
            break
        case Angle.Degree90:
            expression.append(90)
            break
        case Angle.Degree108:
            expression.append(108)
            break
        case Angle.Degree120:
            expression.append(120)
            break
        case Angle.Degree135:
            expression.append(135)
            break
        case Angle.Degree144:
            expression.append(144)
            break
        case Angle.Degree150:
            expression.append(150)
            break
        case .Default:
            expression.append(90)
        }
        switch step {
        case .PlusStep:
            expression.append(1)
            break
        case .MinusStep:
            expression.append(0)
            break
        }
    }
    public func adjustmentLine(_ step: AdjustStep){
        expression.append(96)
        expression.append(1)
        switch step {
        case .PlusStep:
            expression.append(1)
            break
        case .MinusStep:
            expression.append(0)
            break
        }
    }
}
