//
//  PokemonCell.swift
//  PokemonBook
//
//  Created by 전성진 on 8/5/24.
//

import Foundation
import UIKit

import Kingfisher
import SnapKit

class PokemonCell: UICollectionViewCell {
  static let cellId = "PokemonCell"
  
  var id: String = ""
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 10
    imageView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 235/255, alpha: 1.0)
    return imageView
  }()
  
  func configureUI() {
    self.addSubview(imageView)
    
    imageView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  func configure(id: String) {
    self.id = id
    let urlString = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png"
    guard let url = URL(string: urlString) else { return }
    
    self.imageView.kf.setImage(with: url)
  } // configure() END
  
}
