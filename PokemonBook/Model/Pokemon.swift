//
//  Pokemon.swift
//  PokemonBook
//
//  Created by 전성진 on 8/5/24.
//

import Foundation

struct Result: Codable {
  let name: String
  let url: String
  
  var id: String {
    if let id = url.split(separator: "/").last {
      return String(id)
    } else {
      return ""
    }
  }
}

struct PokemonListResponse: Codable {
  let results: [Result]
}

struct SlotElement: Codable {
  let slot: Int
  let type: TypeElement
}

struct TypeElement: Codable {
  let name: PokemonTypeName
}

struct PokemonResponse: Codable {
  let id: Int
  let name: String
  let types: [SlotElement]
  let height: Int
  let weight: Int
}
