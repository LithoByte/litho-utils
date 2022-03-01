//
//  LUXJsonProvider.swift
//  ThryvUXComponents
//
//  Created by Elliot Schrock on 10/13/18.
//

import UIKit

public class JsonProvider {
    public static var jsonEncoder = defaultJsonEncoder()
    public static var jsonDecoder = defaultJsonDecoder()
    
    public static func defaultJsonEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }
    
    public static func defaultJsonDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
    
    public static func encode<T>(_ value: T) -> Data? where T: Encodable {
        return try? jsonEncoder.encode(value)
    }
    
    public static func decode<T>(_ type: T.Type, from data: Data) -> T? where T: Decodable {
        return try? jsonDecoder.decode(T.self, from: data)
    }
    
    public static func forceEncode<T>(_ value: T) throws -> Data? where T: Encodable {
        return try jsonEncoder.encode(value)
    }
    
    public static func forceDecode<T>(_ type: T.Type, from data: Data) throws -> T? where T: Decodable {
        return try jsonDecoder.decode(T.self, from: data)
    }
}
