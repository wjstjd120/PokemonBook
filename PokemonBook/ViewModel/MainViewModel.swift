//
//  MainViewModel.swift
//  PokemonBook
//
//  Created by 전성진 on 8/5/24.
//

import Foundation

import RxSwift

class MainViewModel {
  private let disposeBag = DisposeBag()
  
  let pokemonListSubject = BehaviorSubject(value: [Result]())
  
  init() {
    fetchPokemonList(offset: 0)
  }
  
  func fetchPokemonList(offset: Int) {
    guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=20&offset=\(offset)") else {
      pokemonListSubject.onError(NetworkError.invalidUrl)
      return
    }
    
    NetworkManager.shared.fetch(url: url)
      .subscribe(onSuccess: { [weak self] (pokemonListResponse: PokemonListResponse) in
        self?.pokemonListSubject.onNext(pokemonListResponse.results)
      }, onFailure: { [weak self] error in
        self?.pokemonListSubject.onError(error)
      }).disposed(by: disposeBag)
  }
}
