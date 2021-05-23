//
//  FCBPeripheralManagerDelegate.swift
//  fuikit
//
//  Created by Calvin Collins on 12/7/20.
//

import Foundation
import CoreBluetooth

open class FCBPeripheralManagerDelegate: NSObject, CBPeripheralManagerDelegate {
  
  /**
   This class implements CBPeripheralManagerDelegate, with some important exceptions. One iOS 13 method was not able to be implemented in this functional framework because of parameters that are only available in iOS 13. This methods is:
   
   1. peripheralManager(CBPeripheralManager, didOpen: CBL2CAPChannel?, error: Error?)
   
   */
  
  public var onDidUpdateState: ((CBPeripheralManager) -> Void)? = nil
  public var onWillRestoreState: ((CBPeripheralManager, [String:Any]) -> Void)? = nil
  public var onDidStartAdvertising: ((CBPeripheralManager, Error?) -> Void)? = nil
  public var onDidAddService: ((CBPeripheralManager, CBService, Error?) -> Void)? = nil
  public var onDidSubscribeToCharacteristic: ((CBPeripheralManager, CBCentral, CBCharacteristic) -> Void)? = nil
  public var onDidUnsubscribeFromCharacteristic: ((CBPeripheralManager, CBCentral, CBCharacteristic) -> Void)? = nil
  public var onDidReceiveRead: ((CBPeripheralManager, CBATTRequest) -> Void)? = nil
  public var onDidReceiveWrite: ((CBPeripheralManager, [CBATTRequest]) -> Void)? = nil
  public var onPeripheralManagerReady: ((CBPeripheralManager) -> Void)? = nil
  public var onDidPublishL2CAPChannel: ((CBPeripheralManager, CBL2CAPPSM, Error?) -> Void)? = nil
  public var onDidUnpublishL2CAPChannel: ((CBPeripheralManager, CBL2CAPPSM, Error?) -> Void)? = nil
  
  @available(iOS 6.0, *)
  open func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
    onDidUpdateState?(peripheral)
  }
  
  @available(iOS 6.0, *)
  open func peripheralManager(_ peripheral: CBPeripheralManager, willRestoreState dict: [String : Any]) {
    onWillRestoreState?(peripheral, dict)
  }
  @available(iOS 6.0, *)
  open func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
    onDidStartAdvertising?(peripheral, error)
  }
  @available(iOS 6.0, *)
  open func peripheralManager(_ peripheral: CBPeripheralManager, didAdd service: CBService, error: Error?) {
    onDidAddService?(peripheral, service, error)
  }
  @available(iOS 6.0, *)
  open func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
    onDidSubscribeToCharacteristic?(peripheral, central, characteristic)
  }
  @available(iOS 6.0, *)
  open func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didUnsubscribeFrom characteristic: CBCharacteristic) {
    onDidUnsubscribeFromCharacteristic?(peripheral, central, characteristic)
  }
  @available(iOS 6.0, *)
  open func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveRead request: CBATTRequest) {
    onDidReceiveRead?(peripheral, request)
  }
  @available(iOS 6.0, *)
  open func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
    onDidReceiveWrite?(peripheral, requests)
  }
  @available(iOS 6.0, *)
  open func peripheralManagerIsReady(toUpdateSubscribers peripheral: CBPeripheralManager) {
    onPeripheralManagerReady?(peripheral)
  }
  @available(iOS 6.0, *)
  open func peripheralManager(_ peripheral: CBPeripheralManager, didPublishL2CAPChannel PSM: CBL2CAPPSM, error: Error?) {
    onDidPublishL2CAPChannel?(peripheral, PSM, error)
  }
  @available(iOS 6.0, *)
  open func peripheralManager(_ peripheral: CBPeripheralManager, didUnpublishL2CAPChannel PSM: CBL2CAPPSM, error: Error?) {
    onDidUnpublishL2CAPChannel?(peripheral, PSM, error)
  }
  
}
