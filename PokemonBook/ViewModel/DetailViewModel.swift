//
//  MainViewModel.swift
//  PokemonBook
//
//  Created by 전성진 on 8/5/24.
//

import Foundation

import RxSwift

class DetailViewModel {
  private let disposeBag = DisposeBag()
  
  let pokemonSubject = PublishSubject<PokemonResponse>()
  
  func fetchPokemon(id: String) {
    guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)/") else {
      pokemonSubject.onError(NetworkError.invalidUrl)
      return
    }
    
    NetworkManager.shared.fetch(url: url)
      .subscribe(onSuccess: { [weak self] (pokemonResponse: PokemonResponse) in
        self?.pokemonSubject.onNext(pokemonResponse)
      }, onFailure: { [weak self] error in
        self?.pokemonSubject.onError(error)
      }).disposed(by: disposeBag)
  }
}
