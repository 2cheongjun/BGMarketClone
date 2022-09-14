//
//  ViewController.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/14.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
//    let tag: [String] = ["같이해요","동네질문","동네맛집","동네소식","취미생활","실시간동네날씨","분실/실종센터"]
    var models = [Model]()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 이미지예제(컬렉션뷰에 들어가는 모델데이터)
        models.append(Model(text: "1", imageName:"02"))
        models.append(Model(text: "2", imageName:"01"))
        models.append(Model(text: "3", imageName:"04"))
        models.append(Model(text: "4", imageName:"03"))

        collectionView.register(CollectionViewCell.nib(), forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    
    
    // 비주얼 콜렉션뷰
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        
//        cell.imageView.image = UIImage(named: "01")
        cell.imageView.image = UIImage(named: models[indexPath.item].imageName)
        cell.label.text = models[indexPath.item].text + "/4"
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        return CGSize(width: 80, height: 40)
    }

}

