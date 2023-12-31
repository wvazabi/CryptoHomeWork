//
//  ViewController.swift
//  KriptoParaUygulamasi
//
//  Created by Enes Kaya on 21.10.2023.

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var collectionView: UICollectionView?
    var cryptoList: [Crypto]?
    let myCrypyoViewModel = CryptoViewModel()
    let disposeBag = DisposeBag()
    let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        viewControllerBind()
        myCrypyoViewModel.requestData()
        collectionViewFunc()
        funcUISetup()
        
        
        
    }
    func funcUISetup(){
        view.addSubview(activityIndicator)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.widthAnchor.constraint(equalToConstant: 100).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 100).isActive = true
       
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        

        let label = UILabel()
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
  
label.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
    label.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    label.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    label.heightAnchor.constraint(equalToConstant: 100).isActive = true

    }
    
    func collectionViewFunc(){
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10 , bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 10

        layout.itemSize = CGSize(width: 200, height: 100)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(TableViewCell.self, forCellWithReuseIdentifier: "tableViewCell")
        collectionView?.backgroundColor = .white
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
        
        view.addSubview(collectionView!)
collectionView?.translatesAutoresizingMaskIntoConstraints = false

    collectionView!.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
collectionView!.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    collectionView!.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    collectionView!.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cryptoList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        cell.setup(indexPath: indexPath, cryptos: cryptoList ?? [])
        return cell
    }
    
    
    
    private func viewControllerBind() {
        _ = myCrypyoViewModel
            .cryptos
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { data in
                self.cryptoList = data
                self.collectionView?.reloadData()
            }).disposed(by: disposeBag)
        
        _ = myCrypyoViewModel
            .error
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { errorString in
                
            }).disposed(by: disposeBag)
        
        _ = myCrypyoViewModel
            .loading
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { bool in
                if bool == true{
                    self.activityIndicator.startAnimating()
                }else{
                    self.activityIndicator.stopAnimating()
                }
            }).disposed(by: disposeBag)
    }
}
