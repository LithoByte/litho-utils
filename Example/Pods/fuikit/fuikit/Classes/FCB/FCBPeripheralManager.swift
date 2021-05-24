//
//  FCBPeripheralManager.swift
//  fuikit
//
//  Created by Calvin Collins on 12/7/20
//

import Foundation
import CoreBluetooth

open class FCBPeripheralManager: CBPeripheralManager {
  
  /**
   This class implements CBPeripheralManager. All functions call their corresponding super methods in CBPeripheralManager
   If this is not desired behavior, you should subclass this class and override the methods, and making sure your self-defined, functional methods are sufficient and make sure the manager works.
   
   */
  
  public var onStartAdvertising: (([String:Any]?) -> Void)? = nil
  public var onStopAdvertising: (() -> Void)? = nil
  public var onSetDesiredConnectionLatency: ((CBPeripheralManagerConnectionLatency, CBCentral) -> Void)? = nil
  public var onAddService: ((CBMutableService) -> Void)? = nil
  public var onRemoveService: ((CBMutableService) -> Void)? = nil
  public var onRemoveAllServices: (() -> Void)? = nil
  public var onRespondToRequest: ((CBATTRequest, CBATTError.Code) -> Void)? = nil
  public var onUpdateValue: ((Data, CBMutableCharacteristic, [CBCentral]?) -> Bool) = {
    _, _ ,_ in
    return true
  }
  public var onPublishL2CAPChannel: ((Bool) -> Void)? = nil
  public var onUnpublichL2CAPChannel: ((CBL2CAPPSM) -> Void)? = nil
  
  open override func startAdvertising(_ advertisementData: [String : Any]?) {
    super.startAdvertising(advertisementData)
    onStartAdvertising?(advertisementData)
  }
  
  open override func stopAdvertising() {
    super.stopAdvertising()
    onStopAdvertising?()
  }
  
  open override func setDesiredConnectionLatency(_ latency: CBPeripheralManagerConnectionLatency, for central: CBCentral) {
    super.setDesiredConnectionLatency(latency, for: central)
    onSetDesiredConnectionLatency?(latency, central)
  }
  open override func add(_ service: CBMutableService) {
    super.add(service)
    onAddService?(service)
  }
  
  open override func remove(_ service: CBMutableService) {
    super.remove(service)
    onRemoveService?(service)
  }
  
  open override func removeAllServices() {
    super.removeAllServices()
    onRemoveAllServices?()
  }
  
  open override func respond(to request: CBATTRequest, withResult result: CBATTError.Code) {
    super.respond(to: request, withResult: result)
    onRespondToRequest?(request, result)
  }
  
  open override func updateValue(_ value: Data, for characteristic: CBMutableCharacteristic, onSubscribedCentrals centrals: [CBCentral]?) -> Bool {
    super.updateValue(value, for: characteristic, onSubscribedCentrals: centrals)
    return onUpdateValue(value, characteristic, centrals)
  }
  @available(iOS 11.0, *)
  open override func publishL2CAPChannel(withEncryption encryptionRequired: Bool) {
    super.publishL2CAPChannel(withEncryption: encryptionRequired)
    onPublishL2CAPChannel?(encryptionRequired)
  }
  @available(iOS 11.0, *)
  open override func unpublishL2CAPChannel(_ PSM: CBL2CAPPSM) {
    super.unpublishL2CAPChannel(PSM)
    onUnpublichL2CAPChannel?(PSM)
  }
  
}
