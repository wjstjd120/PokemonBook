//
//  DetailViewController.swift
//  PokemonBook
//
//  Created by 전성진 on 8/6/24.
//

import Foundation
import UIKit

import SnapKit
import RxSwift
import Kingfisher

class DetailViewController: UIViewController {
  private let viewModel = DetailViewModel()
  private let disposeBag = DisposeBag()
  
  init(id: String) {
    viewModel.fetchPokemon(id: id)
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.clipsToBounds = true
    stackView.layer.cornerRadius = 15
    stackView.backgroundColor = UIColor(red: 120/255, green: 30/255, blue: 30/255, alpha: 1.0)
    return stackView
  }()
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 30)
    label.textAlignment = .center
    label.textColor = .white
    return label
  }()
  
  private let typeLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 15)
    label.textAlignment = .center
    label.textColor = .white
    return label
  }()
  
  private let heightLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 15)
    label.textAlignment = .center
    label.textColor = .white
    return label
  }()
  
  private let weightLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 15)
    label.textAlignment = .center
    label.textColor = .white
    return label
  }()
  
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.setNavigationBarHidden(false, animated: false)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bind()
    configureUI()
    configureView()
  }
  
  private func bind() {
    viewModel.pokemonSubject
      .observe(on: MainScheduler.instance)
      .subscribe(
        onNext: { [weak self] pokemon in
          let urlString = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(pokemon.id).png"
          guard let url = URL(string: urlString) else { return }
          self?.imageView.kf.setImage(with: url)
          self?.nameLabel.text = "No.\(pokemon.id) \(PokemonTranslator.getKoreanName(for: pokemon.name))"
          self?.typeLabel.text = "타입: \(pokemon.types[0].type.name.displayName)"
          self?.heightLabel.text = "키: \(self?.formatToDecimal(pokemon.height) ?? "0") m"
          self?.weightLabel.text = "몸무게: \(self?.formatToDecimal(pokemon.weight) ?? "0") kg"
        }, onError: { error in
          print("에러 발생: \(error)")
        }).disposed(by: disposeBag)
  }
  
  func configureView() {
    view.backgroundColor = UIColor(red: 190/255, green: 30/255, blue: 40/255, alpha: 1.0)
  }
  
  func configureUI() {
    view.addSubview(stackView)
    
    [imageView, nameLabel, typeLabel, heightLabel, weightLabel].forEach {
      stackView.addArrangedSubview($0)
    }
    
    stackView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(330)
      //      $0.height.equalTo(430)
    }
    
    imageView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(30)
      $0.height.equalTo(200)
      $0.centerX.equalToSuperview()
    }
    
    nameLabel.snp.makeConstraints {
      $0.height.equalTo(50)
    }
    
    typeLabel.snp.makeConstraints {
      $0.height.equalTo(30)
    }
    
    heightLabel.snp.makeConstraints {
      $0.height.equalTo(30)
    }
    
    weightLabel.snp.makeConstraints {
      $0.height.equalTo(30)
    }
  }
  
  func formatToDecimal(_ num: Int) -> String {
    let str = String(num)
    
    guard str.count > 1 else {
      return "0.\(num)"
    }
    
    let integerPart = str.dropLast()
    let decimalPart = str.suffix(1)
    
    return "\(integerPart).\(decimalPart)"
  }
}
