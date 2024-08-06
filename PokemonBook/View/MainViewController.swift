//
//  ViewController.swift
//  PokemonBook
//
//  Created by 전성진 on 8/4/24.
//

import UIKit

import SnapKit
import RxSwift

class MainViewController: UIViewController {
  private var pokemonList: [Result] = []
  
  private let viewModel = MainViewModel()
  private let disposeBag = DisposeBag()
  
  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    collectionView.register(PokemonCell.self, forCellWithReuseIdentifier: PokemonCell.cellId)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = UIColor(red: 120/255, green: 30/255, blue: 30/255, alpha: 1.0)
    collectionView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    return collectionView
  }()
  
  private let titleView: UIView = {
    let view = UIView()
    return view
  }()
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = .pokemonBall
    imageView.contentMode = .scaleAspectFit
    
    return imageView
  }()
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: false)
  }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    bind()
    configureUI()
    configureView()
  }
  
  private func configureView() {
    view.backgroundColor = UIColor(red: 190/255, green: 30/255, blue: 40/255, alpha: 1.0)
  }
  
  private func configureUI() {
    [collectionView, titleView].forEach {
      view.addSubview($0)
    }
    titleView.addSubview(imageView)
    
    titleView.snp.makeConstraints {
      $0.top.left.right.equalTo(view.safeAreaLayoutGuide)
      $0.height.equalTo(150)
    }
    
    collectionView.snp.makeConstraints {
      $0.bottom.left.right.equalTo(view.safeAreaLayoutGuide)
      $0.top.equalTo(titleView.snp.bottom)
    }
    
    imageView.snp.makeConstraints {
      $0.size.equalTo(CGSize(width: 100, height: 100))
      $0.center.equalToSuperview()
    }
  }
  
  private func bind() {
    viewModel.pokemonListSubject
      .observe(on: MainScheduler.instance)
      .subscribe(
        onNext: { [weak self] pokemonList in
          self?.pokemonList = pokemonList
          self?.collectionView.reloadData()
        }, onError: { error in
          print("에러 발생: \(error)")
        }).disposed(by: disposeBag)
  }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let cell = collectionView.cellForItem(at: indexPath) as? PokemonCell else { return }
    self.navigationController?.pushViewController(DetailViewController(id: cell.id), animated: true)
  }
}

extension MainViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return pokemonList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCell.cellId, for: indexPath) as? PokemonCell else {
      return UICollectionViewCell()
    }
    cell.configure(id: pokemonList[indexPath.item].id)
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width: Int = Int((collectionView.bounds.width - 30) / 3 )
    let height: Int = width
    return CGSize(width: width, height: height)
  }
  
//  func scrollViewDidScroll(_ scrollView: UIScrollView) {
//    let offsetY = scrollView.contentOffset.y
//    let contentHeight = scrollView.contentSize.height
//    let height = scrollView.bounds.height
//    
//    if offsetY > contentHeight - height {
//      viewModel.fetchPokemonList(offset: (pokemonList.count + 1) + 20 )
//      collectionView.reloadData()
//    }
//  }
}
