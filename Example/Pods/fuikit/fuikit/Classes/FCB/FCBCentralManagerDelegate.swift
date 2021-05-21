//
//  FCBCentralManagerDelegate.swift
//  fuikit
//
//  Created by Calvin Collins on 12/7/20.
//

import Foundation
import CoreBluetooth

open class FCentralManagerDelegate: NSObject, CBCentralManagerDelegate {
  /**
   This class implements CBCentralManagerDelegate.

   */
  public var onCentralManagerDidUpdateState: ((CBCentralManager) -> Void)? = nil
  public var onWillRestoreState: ((CBCentralManager, [String:Any]) -> Void)? = nil
  public var onDidDiscoverPeripheralAdAndRSSI: ((CBCentralManager, CBPeripheral, [String:Any], NSNumber) -> Void)? = nil
  public var onDidConnect: ((CBCentralManager, CBPeripheral) -> Void)? = nil
  public var onDidFailToConnect: ((CBCentralManager, CBPeripheral, Error?) -> Void)? = nil
  public var onDidDisconnect: ((CBCentralManager, CBPeripheral, Error?) -> Void)? = nil
  public var onConnectionEventForPeripheral: ((CBCentralManager, CBConnectionEvent, CBPeripheral) -> Void)? = nil
  public var onDidUpdateAndAuthorize: ((CBCentralManager, CBPeripheral) -> Void)? = nil
  
  
  @available(iOS 5.0, *)
  open func centralManagerDidUpdateState(_ central: CBCentralManager) {
    onCentralManagerDidUpdateState?(central)
  }
  
  @available(iOS 5.0, *)
  open func centralManager(_ central: CBCentralManager, willRestoreState dict: [String : Any]) {
    onWillRestoreState?(central, dict)
  }
  
  @available(iOS 5.0, *)
  open func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
    onDidDiscoverPeripheralAdAndRSSI?(central, peripheral, advertisementData, RSSI)
  }
  
  @available(iOS 5.0, *)
  open func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
    onDidConnect?(central, peripheral)
  }
  
  @available(iOS 5.0, *)
  open func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
    onDidFailToConnect?(central, peripheral, error)
  }
  
  @available(iOS 5.0, *)
  open func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
    onDidDisconnect?(central, peripheral, error)
  }
  
  @available(iOS 13.0, *)
  open func centralManager(_ central: CBCentralManager, connectionEventDidOccur event: CBConnectionEvent, for peripheral: CBPeripheral) {
    onConnectionEventForPeripheral?(central, event, peripheral)
  }
  
  @available(iOS 13.0, *)
  open func centralManager(_ central: CBCentralManager, didUpdateANCSAuthorizationFor peripheral: CBPeripheral) {
    onDidUpdateAndAuthorize?(central, peripheral)
  }
  
}
