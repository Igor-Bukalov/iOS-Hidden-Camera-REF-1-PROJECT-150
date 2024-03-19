//
//  BLUService.swift
//  Hidden Spy Camera Finder
//
//  Created by Evgeniy Bruchkovskiy on 08.11.2023.
//

import Foundation
import CoreBluetooth

class BLUService: NSObject, CBPeripheralDelegate, CBCentralManagerDelegate {
    var centralManager: CBCentralManager!
    
    private var didDiscoverCompletion: ((_ peripheral: CBPeripheral, _ rssi: NSNumber) -> Void)?
    private var didUpdateState: ((_ state: CBManagerState) -> Void)?
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: .main)
    }
    
    func startScan(services: [CBUUID]? = nil, options: [String: Any]? = [CBCentralManagerScanOptionAllowDuplicatesKey : true]) {
        centralManager.scanForPeripherals(withServices: nil, options: options)
    }
    
    func stopScan() {
        centralManager.stopScan()
    }
    
    func didDiscover(completion: @escaping (_ peripheral: CBPeripheral, _ rssi: NSNumber) -> Void) {
        didDiscoverCompletion = completion
    }
    
    func didUpdateState(completion: @escaping (_ state: CBManagerState) -> Void) {
        didUpdateState = completion
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        didDiscoverCompletion?(peripheral, RSSI)
//        print("Discovered \(peripheral.name ?? "")")
//        if peripheral.name == "iPhone (Evgeniy)" {
//            print("RSSI Distance: ", Int(pow(10, ((-59-Double(truncating: RSSI))/(10*2)))*3.2808))
//        }
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        didUpdateState?(central.state)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {}
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print(error!)
    }
}
