//
//  ViewController.swift
//  BluetoothTutorialApp
//
//  Created by Jorge Loc Rubio on 11/26/18.
//  Copyright © 2018 jurjdev. All rights reserved.
//

import UIKit
import Bluetooth
import GATT

class ViewController: UIViewController {

    
    @IBOutlet weak var connectButton: UIButton!
    
    let central = CentralManager()
    let duration: TimeInterval = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func connecAction(_ sender: Any) {
        
        connect()
    }
    
    func connect() {
        
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            
            guard let controller = self
                else { return }
            let central = controller.central
            let duration = controller.duration
            
            do {
                print("Start Scaning")
                let scanResults = try central.scan(duration: duration)
            
                for result in scanResults {
                    
                    let peripheral = result.peripheral
                    
                    if result.advertisementData.localName == "RPI" {
                        
                        do { try central.connect(to: peripheral) }
                        catch { print("Could not connect:", error); continue }
                            try central.connect(to: peripheral)
                            let services = try central.discoverServices(for: peripheral)
                            for service in services {
                                
                                let characteristics = try central.discoverCharacteristics(for: service.uuid, peripheral: peripheral)
                                
                                for characteristic in characteristics {
                                    
                                    let bytes:[UInt8] = [0x01]
                                    do { try central.writeValue(Data(bytes), for: characteristic.uuid, service: service.uuid, peripheral: peripheral) }
                                    catch { print("Could not write value:", error) }
                                }
                            }
                            // let characteristic = BluetoothUUID(rawValue: "842D1152-1525-41E2-8E78-6A894D01DA7D")!
                            //let service = BluetoothUUID(rawValue: "DE2648BE-A651-47F1-BBF5-4295848CA79E")!
                        
                    } else {
                        
                        continue
                    }
                }
                
            } catch {
                
                print("Could not connect:", error)
            }
        }
    }
    
    func connectAlert() {
        
        let alert = UIAlertController(title: "Error", message: "Connection Error", preferredStyle: .alert)
        
        alert.show(self, sender: self);
    }
    

}


class MainViewController: UIViewController {
    
    
    @IBOutlet weak var ledSwitch: UISwitch!
    
    override func viewDidLoad() {
        
    }
    
    
    
}

