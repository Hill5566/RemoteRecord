//
//  BLEConnectVC.swift
//  HealthCare
//
//  Created by Lin Hill on 2019/5/22.
//  Copyright © 2019 extreamax. All rights reserved.
//

import UIKit
import CoreBluetooth

class BLEConnectVC: UIViewController {
   
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    private var centralManager: CBCentralManager?
    private var peripheralUmi: CBPeripheral?
    private var characteristicUmi: CBCharacteristic?
    private var peripheralName = "Umi Talk"

    private let umiUUID = "FFE1"

    enum umiTouchCase {
        case 一下
        case 一上
        case 二下
        case 二上
    }
    private let 一下:[UInt8] = [250, 2, 1, 253, 175]
    private let 一上:[UInt8] = [250, 2, 0, 252, 175]
    private let 二下:[UInt8] = [250, 1, 1, 252, 175]
    private let 二上:[UInt8] = [250, 1, 0, 251, 175]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self)
        
        let queue = DispatchQueue.global()
        centralManager = CBCentralManager(delegate: self, queue: queue)
        
    }
}

extension BLEConnectVC: CBCentralManagerDelegate, CBPeripheralDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("Bluetooth status is UNKNOWN")
        case .resetting:
            print("Bluetooth status is RESETTING")
        case .unsupported:
            print("Bluetooth status is UNSUPPORTED")
        case .unauthorized:
            print("Bluetooth status is UNAUTHORIZED")
        case .poweredOff:
            print("Bluetooth status is POWERED OFF")
        case .poweredOn:
            print("Bluetooth status is POWERED ON")
           
            centralManager?.scanForPeripherals(withServices: [])
        @unknown default:
            print("ERROR")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        if let pName = peripheral.name {
            print(pName)
//            nameLabel.text = pName
            centralManager?.stopScan()
            peripheralUmi = peripheral
            centralManager?.connect(peripheralUmi!, options: nil)
            
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        
        peripheral.delegate = self
        peripheral.discoverServices(nil)
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        DispatchQueue.main.async {
            
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let servicePeripheral = peripheral.services as [CBService]? { //get the services of the perifereal
            for service in servicePeripheral {
                peripheral.discoverCharacteristics(nil, for: service)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        if let characteristics = service.characteristics as [CBCharacteristic]? {
            
            for cc in characteristics {
//                print("cc:", cc.uuid.uuidString)
                if cc.uuid.uuidString == umiUUID {
                    
                    peripheral.setNotifyValue(true, for: cc)
                    
                    peripheral.readValue(for: cc)
                }
               
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
        if characteristic.uuid.uuidString == umiUUID {
            guard let readValue = characteristic.value else { return }

            let umiCommand = [UInt8](readValue)
            if umiCommand == 一下 {
                print("一下")
                
            } else if umiCommand == 一上 {
                print("一上")
            } else if umiCommand == 二下 {
                print("二下")
            } else if umiCommand == 二上 {
                print("二上")
            }
            
        } else {
            print("readValue false")
        }
    }
    
}
