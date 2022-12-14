//
//  SearchResultVC.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/24.
//

import Foundation
import UIKit
import MaterialComponents.MaterialBottomSheet

class SearchResultVC : UIViewController{
    
    var searchModel:SearchModel?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var fillterBTN: UIView!
    
    @IBOutlet weak var lowTitle: UIView!
    @IBOutlet weak var highTitle: UIView!
    
    // 노티3.DetailVC에서 보낸 값을 받기위해 DissmissWrite의 노티피케이션을 정의해 받을 준비한다.
    let lowfillter = Notification.Name("lowfillter")
    // 노티3.DetailVC에서 보낸 값을 받기위해 DissmissWrite의 노티피케이션을 정의해 받을 준비한다.
    let highfillter = Notification.Name("highfillter")
    
    //닫기
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
        //창닫힐때 노티삭제
        NotificationCenter.default.removeObserver(self, name: lowfillter, object: nil)
        NotificationCenter.default.removeObserver(self, name: highfillter, object: nil)
    }

    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib(nibName: TableViewCellFirst.className, bundle: nil), forCellReuseIdentifier: TableViewCellFirst.cellId)
        
        tableView.register(UINib(nibName: TableViewCellSecond.className, bundle: nil), forCellReuseIdentifier: TableViewCellSecond.cellId)
        
        // 상단컬렉션뷰셀
        collectionView.register(productCell.nib(), forCellWithReuseIdentifier: productCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //필터투명버튼
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonAction))
        fillterBTN.addGestureRecognizer(tapGestureRecognizer)
        
        lowTitle.isHidden = true
        highTitle.isHidden = true
        
        // 기본검색API호출
        print("viewDidload")
        searchWord()
        
        }

    
    override func viewWillAppear(_ animated: Bool) {
        
        print("viewWillAppear")
        // 노티4.옵저버를 등록하고,lowfillter가 오면 writeVCNotification함수를 실행한다.
        NotificationCenter.default.addObserver(self, selector: #selector(self.action(_:)), name: lowfillter, object: nil)
        // 노티4.옵저버를 등록하고,lowfillter가 오면 writeVCNotification함수를 실행한다.
        NotificationCenter.default.addObserver(self, selector: #selector(self.highaction(_:)), name: highfillter, object: nil)
        
    }
    
    // 낮은순서필터 서버호출실행
    @objc func action(_ noti: Notification) {
        //정확도순글자 ->낮은가격순으로 바꾸기??
        
        searchWordlow()
        OperationQueue.main.addOperation { // DispatchQueue도 가능.
            // 업데이트
            self.collectionView.reloadData()
        }
        lowTitle.isHidden = false
        highTitle.isHidden = true
    }
    
    // 높은순서필터 서버호출실행
    @objc func highaction(_ noti: Notification) {
        //정확도순글자 ->낮은가격순으로 바꾸기??
        
        searchWordhigh()
        OperationQueue.main.addOperation { // DispatchQueue도 가능.
            // 업데이트
            self.collectionView.reloadData()
        }
        lowTitle.isHidden = true
        highTitle.isHidden = false
    }
  
  
    
    //필터투명버튼
    @objc func buttonAction(_ button: UIButton) {
        print("필터투명버튼")
        let vc = storyboard?.instantiateViewController(withIdentifier: "fillterVC") as! fillterVC
        
        // MDC 바텀 시트로 설정
        let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: vc)
        
        // 보여주기
        present(bottomSheet, animated: true, completion: nil)
    }
    
    // 검색요청 API
    func searchWord(success: (()->Void)? = nil, fail: ((String)->Void)? = nil) {
        
        // URL세선 시작
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
  
        // 한글이 있는 URL
        let someURLString = "https://dev.wogus4048.shop/search/accuracy/패딩"
        // 한글이 있는 URL String을 addingPercentEncoding으로 string으로 변경한다.(urlQueryAllowed를 사용)
        let result = someURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        // 컴포넌트에 남아서 보내기
        var components = URLComponents(string: result!)
        
        print("components:\(components)")
        
//        let word = URLQueryItem(name: "word", value: word)
//        components?.queryItems = [word]
        
        // url이 없으면 리턴한다. 여기서 끝
        guard let url = components?.url else { return }
        
        // 값이 있다면 받아와서 넣음.
        var request = URLRequest(url: url)
        
        print("정확도순: 검색 url :\(request)")
        
        request.httpMethod = "GET" //GET방식이다. 컨텐츠타입이 없고, 담아서 보내는 내용이 없음, URL호출만!
        
        let task = session.dataTask(with: request) { data, response, error in
            print( (response as! HTTPURLResponse).statusCode )
            
            // 데이터가 있을때만 파싱한다.
            if let hasData = data {
                // 모델만든것 가져다가 디코더해준다.
                do{
                    // 만들어놓은 피드모델에 담음, 데이터를 디코딩해서, 디코딩은 try catch문 써줘야함
                    // 여기서 실행을 하고 오류가 나면 catch로 던져서 프린트해주겠다.
                    self.searchModel = try JSONDecoder().decode(SearchModel.self, from: hasData)
                    print("정확도순 검색결과 :\(String(describing: self.searchModel))")
                    
                    // 모든UI 작업은 메인쓰레드에서 이루어져야한다.
                    DispatchQueue.main.async {
                        // 테이블뷰 갱신
                        self.collectionView.reloadData()
                    }
                    
                } catch {
                    print("error: ", error)
                }
            }else{
                // sucess가 0이면
                print("응답실패")
            }
        }
        // task를 실행한다.
        task.resume()
        // 세션끝내기
        session.finishTasksAndInvalidate()
        
    }//함수 끝
    
    
    // 검색요청 API
    func searchWordhigh(success: (()->Void)? = nil, fail: ((String)->Void)? = nil) {
        
        // URL세선 시작
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
  
        // 한글이 있는 URL
        let someURLString = "https://dev.wogus4048.shop/search/highprice/패딩"
        // 한글이 있는 URL String을 addingPercentEncoding으로 string으로 변경한다.(urlQueryAllowed를 사용)
        let result = someURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        // 컴포넌트에 남아서 보내기
        var components = URLComponents(string: result!)
        
        print("components:\(components)")
        
//        let word = URLQueryItem(name: "word", value: word)
//        components?.queryItems = [word]
        
        // url이 없으면 리턴한다. 여기서 끝
        guard let url = components?.url else { return }
        
        // 값이 있다면 받아와서 넣음.
        var request = URLRequest(url: url)
        
        print("낮은가격순: 검색 url :\(request)")
        
        request.httpMethod = "GET" //GET방식이다. 컨텐츠타입이 없고, 담아서 보내는 내용이 없음, URL호출만!
        
        let task = session.dataTask(with: request) { data, response, error in
            print( (response as! HTTPURLResponse).statusCode )
            
            // 데이터가 있을때만 파싱한다.
            if let hasData = data {
                // 모델만든것 가져다가 디코더해준다.
                do{
                    // 만들어놓은 피드모델에 담음, 데이터를 디코딩해서, 디코딩은 try catch문 써줘야함
                    // 여기서 실행을 하고 오류가 나면 catch로 던져서 프린트해주겠다.
                    self.searchModel = try JSONDecoder().decode(SearchModel.self, from: hasData)
                    print("높은가격순 검색결과 :\(String(describing: self.searchModel))")
                    
                    //모든UI 작업은 메인쓰레드에서 이루어져야한다.
                    DispatchQueue.main.async {
                        // 테이블뷰 갱신
                        self.collectionView.reloadData()
                    }
                    
                } catch {
                    print("error: ", error)
                }
            }else{
                // sucess가 0이면
                print("응답실패")
            }
        }
        // task를 실행한다.
        task.resume()
        // 세션끝내기
        session.finishTasksAndInvalidate()
        
    }//함수 끝
    
    // low검색요청 API
    func searchWordlow(success: (()->Void)? = nil, fail: ((String)->Void)? = nil) {

        // URL세선 시작
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)

        // 한글이 있는 URL
        let someURLString = "https://dev.wogus4048.shop/search/lowprice/패딩"
        // 한글이 있는 URL String을 addingPercentEncoding으로 string으로 변경한다.(urlQueryAllowed를 사용)
        let result = someURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        // 컴포넌트에 남아서 보내기
        var components = URLComponents(string: result!)

        print("components:\(components)")

//        let word = URLQueryItem(name: "word", value: word)
//        components?.queryItems = [word]

        // url이 없으면 리턴한다. 여기서 끝
        guard let url = components?.url else { return }

        // 값이 있다면 받아와서 넣음.
        var request = URLRequest(url: url)

        print("firstTabVC : 검색 url :\(request)")

        request.httpMethod = "GET" //GET방식이다. 컨텐츠타입이 없고, 담아서 보내는 내용이 없음, URL호출만!

        let task = session.dataTask(with: request) { data, response, error in
            print( (response as! HTTPURLResponse).statusCode )

            // 데이터가 있을때만 파싱한다.
            if let hasData = data {
                // 모델만든것 가져다가 디코더해준다.
                do{
                    // 만들어놓은 피드모델에 담음, 데이터를 디코딩해서, 디코딩은 try catch문 써줘야함
                    // 여기서 실행을 하고 오류가 나면 catch로 던져서 프린트해주겠다.
                    self.searchModel = try JSONDecoder().decode(SearchModel.self, from: hasData)
                    print("searchTabVC : 검색결과 :\(String(describing: self.searchModel))")

                    // 모든UI 작업은 메인쓰레드에서 이루어져야한다.
                    DispatchQueue.main.async {
                         //테이블뷰 갱신
                        self.collectionView.reloadData()
                    }

                } catch {
                    print("error: ", error)
                }
            }else{
                // sucess가 0이면
                print("응답실패")
            }
        }
        // task를 실행한다.
        task.resume()
        // 세션끝내기
        session.finishTasksAndInvalidate()

    }//함수 끝

    

}


extension SearchResultVC : UITableViewDelegate,
                           UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
    UITableViewCell {
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellFirst.cellId, for: indexPath) as! TableViewCellFirst
            cell.configure()
            return cell
            
        case 1:
            let cell =
            tableView.dequeueReusableCell(withIdentifier: TableViewCellSecond.cellId, for: indexPath) as! TableViewCellSecond
            // 최근검색어 가져와 뿌리기
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_tableView: UITableView, heightForRowAt indexPath: IndexPath) ->
    CGFloat {
        let interval:CGFloat = 3
        let width: CGFloat = (UIScreen.main.bounds.width - interval * 3)/2
        
        switch indexPath.row{
        case 0:
            return 250
        case 1:
            return (width + 40 + 3) * 5 + 40
    
        default:
            return 0
        }
    }
}


// MARK: - extension
extension SearchResultVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // 상단컬렉션뷰 셀설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return models.count
        return searchModel?.result?.count ?? 0
    }
    
 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productCell.identifier, for: indexPath) as! productCell

        cell.price.text = self.searchModel?.result?[indexPath.row].price?.description
        cell.pdTitle.text = self.searchModel?.result?[indexPath.row].title
        
        // 킹피셔를 사용한 이미지 처리방법
       if let imageURL =  self.searchModel?.result?[indexPath.row].images  {
           // 이미지처리방법
           guard let url = URL(string: imageURL) else {
               //리턴할 셀지정하기
               return cell
           }
           // 이미지를 다운받는동안 인디케이터보여주기
           cell.mImgView.kf.indicatorType = .activity
           //            print("이미지url \(url)")
           cell.mImgView.kf.setImage(
               with: url,
               placeholder: UIImage(named: "placeholderImage"),
               options: [
                   .scaleFactor(UIScreen.main.scale),
                   .transition(.fade(1)),
                   .cacheOriginalImage
               ])
           {
               result in
               switch result {
               case .success(let value):
                   print("")
               case .failure(let err):
                   print(err.localizedDescription)
               }
           }
       }
        
        return cell
            
    }
}

