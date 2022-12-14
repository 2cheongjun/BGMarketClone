//
//  registerVC.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/15.
//

import UIKit
import Foundation
import Photos
import Alamofire
import MaterialComponents.MaterialBottomSheet

// 글작성
class registerVC : UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var productModel: ProductModel?
    let plist = UserDefaults.standard
    let saveTag = UserDefaults.standard
    //string
    var tags = ""
    var str  = ""
    
    // UI이미지 담을 변수(갤러리에서 가져온이미지)
    var newImage: UIImage? = nil
    var resultImg: UIImage? = nil
    // 이미지들 담은 배열
    var photoArray = [UIImage]()
    
    @IBOutlet weak var close: UIBarButtonItem!
    
    @IBOutlet weak var BtnPhoto: UIButton!
    
    @IBOutlet weak var imgPreview: UIImageView!
    
    @IBOutlet weak var textFildTitle: UITextField! //상품명
    
    @IBOutlet weak var labelCategory: UILabel!
    //카테고리 휠로선택하기 어떻게??
    
    @IBOutlet weak var tag: UILabel!
    
    @IBOutlet weak var textFieldPrice: UITextField!
    
    @IBOutlet weak var safePayBtn: UIButton! //클릭시 테두리컬러 레드로?
    
    @IBOutlet weak var checkImg: UIImageView!
    
    @IBOutlet weak var checkBtn: UIButton! //체크버튼
    
    @IBOutlet weak var optionBtn: UIButton!
    @IBOutlet weak var optionText: UILabel!
    
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var cameraBtn: UIButton!
    
    var textViewPlaceHolder = "여러 장의 상품과 구입연도, 브랜드, 사용감, 하자 유무 등 구매자에게 필요한 정보를 꼭 포함해주세요. 문의를 줄이고 더 쉽게 판매할 수 있어요.(10자 이상) "
    var subTextPlaceHolder = "안전하고 건전한 거래 환경을 위해 과학기술정보통신부, 한국인터넷진흥원과 번개장터(주)가 함께 합니다"
    
    
    // 텍스트뷰클릭시 지워진뒤에 -> 블랙으로 폰트색 변경해야함
    @IBOutlet weak var textView: UITextView!{
        didSet{
            textView.font = .systemFont(ofSize: 15)
            textView.text = textViewPlaceHolder
            textView.textColor = UIColor.lightGray //처음보이는색
            textView.delegate = self
            subText.font = .systemFont(ofSize: 13)
            subText.text = subTextPlaceHolder
            subText.textColor = UIColor.lightGray //처음보이는색
            subText.delegate = self
        }
    }
    @IBOutlet weak var subText: UITextView!//밑에작은글씨
    
    //MARK: - option
    @IBAction func optionBtn(_ sender: Any) {
        //바텀시트띄우기
        // 바텀 시트로 쓰일 뷰컨트롤러 생성
          let vc = storyboard?.instantiateViewController(withIdentifier: "OptionVC") as! OptionVC
          
          // MDC 바텀 시트로 설정
          let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: vc)
          
          // 보여주기
          present(bottomSheet, animated: true, completion: nil)
    }
    
    
    
    //MARK: - 태그화면으로 넘어가기
    @IBAction func gotoTagVC(_ sender: Any) {
        if let nextScene = self.storyboard?.instantiateViewController(withIdentifier: "TagVC" ){
            // 화면 전환 애니메이션의 타입
            
            nextScene.modalPresentationStyle = .fullScreen
            self.present(nextScene, animated : true)
        }
    }
    
    
    @IBAction func close(_ sender: Any) {
        //카테고리 내용 삭제
        //카테고리 내용 삭제
        UserDefaults.standard.removeObject(forKey: "category")
        self.saveTag.synchronize()
        print("reigsterVC-태그 삭제")

        self.dismiss(animated: true, completion: nil)//뷰컨닫기
        
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        //옵션버튼설정
        optionBtn.layer.borderColor = UIColor.systemGray4.cgColor
        optionBtn.layer.borderWidth = 1
        optionBtn.layer.cornerRadius = 6
//        optionBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 11)
        //
        safePayBtn.layer.borderColor = UIColor.systemGray4.cgColor
        safePayBtn.layer.borderWidth = 1
        safePayBtn.layer.cornerRadius = 6
        checkImg.image = UIImage(named: "checkGray")
        
        btnSave.layer.cornerRadius = 6
        cameraBtn.layer.cornerRadius = 6
        //        optionBtn.setTitle("옵션선택", for: .normal)
        //        optionBtn.titleLabel?.font = UIFont.ystemFont(ofSize: 14)//두께
        //        print(tagList)
        // 텍스트뷰,필드델리게이트
        textView.delegate = self
        textFildTitle.delegate = self
        textFieldPrice.delegate = self
        textViewSetupView()
        
        //안전결제버튼
        safePayBtn.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        
        
        UserDefaults.standard.removeObject(forKey: "tag")
        UserDefaults.standard.removeObject(forKey: "category")
    }
    
    
    // MARK: - viewillAppear
    override func viewWillAppear(_ animated: Bool) {
        //        let Str = saveTag.string(forKey: "tag")
        
        if let item = saveTag.object(forKey: "tag") as? [String] {
            //object에서 꺼내기
            print("2 :\(item)") // ["A", "B", "C"]
            
            for word in item {
                tags.append("#"+word)
            }
            //텍스트에 추가..
            self.tag.text = tags
        
            
            if tags.isEmpty{
                tag.text = "# 태그"
                tag.textColor = UIColor.lightGray
            }else{
                tag.textColor = UIColor.black
            }
        }
        
        let categoryName = plist.string(forKey: "category")
        if (categoryName != nil) {
            labelCategory.text = categoryName
            labelCategory.textColor = UIColor.black
        }else{
            labelCategory.text = "카테고리"
            labelCategory.textColor = UIColor.lightGray
        }
    }
    
    
    
    // MARK: -  UITextView PlaceHolder 설정
    func textViewSetupView() {
        if textView.text == textViewPlaceHolder {
            //            textView.text = ""
            textView.textColor = UIColor.lightGray
            
        } else if textView.text == "" {
            textView.text = textViewPlaceHolder
            subText.text = subTextPlaceHolder
            textView.textColor = UIColor.lightGray
        }
    }
    
    //MARK: - changeColor(토글은?)
    @objc fileprivate func changeColor(){
        
        safePayBtn.layer.borderColor = UIColor.systemRed.cgColor
        safePayBtn.layer.borderWidth = 1
        checkImg.image = UIImage(named: "checkRed")
    }

    
    
    // MARK: - 카메라호출
    @IBAction func cameraBtn(_ sender: Any) {
        // 기본이미지 피커 인스턴스를 생성한다.
        let picker = UIImagePickerController()
        
        picker.delegate = self // 이미지피커컨트롤러 인스턴스의 델리게이트 속성 현재뷰 컨트롤러 인스턴스로설정
        picker.allowsEditing = true // 피커이미지편집 허용
        
        // 이미지피커 화면을 표시한다.
        self.present(picker, animated: true)
    }
    
    // 사용자가 이미지를 선택하면 자동으로 이 메소드가 호출된다.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 선택된이미지를 미리보기에 출력한다.
        self.imgPreview.image = info[.editedImage] as? UIImage
        
        // 갤러리에서 받아온이미지를 글로벌변수 newImage에 넣는다.
        newImage = info[.editedImage] as? UIImage
        
        // print("UIImage :\(info[.editedImage] as? UIImage)")
        
        // 이미지 피커 컨트롤러를 닫는다.
        picker.dismiss(animated: false)
    }
    
    
    
    // MARK: - saveBTn(태그삭제, 얼럿)
    //완료버튼(누르면,result로 이동) 화면완전히덮기 -> 등록한 이미지화면으로 넘어가기
    @IBAction func btnSave(_ sender: Any) {
        // 태그값 저장된것 삭제
        UserDefaults.standard.removeObject(forKey: "tag")
        //카테고리 내용 삭제
        UserDefaults.standard.removeObject(forKey: "category")
        print("reigsterVC-태그 삭제")
        
                    if let getImage = newImage{
                        upLoadImg(getImage)
                    }
                        print("upload")
       
        
        }
 
 
    // MARK: - saveBTn 등록API호출
    func upLoadImg(_ image: UIImage?) {
        
        guard let jwt = plist.string(forKey: "jwt") else{
               return
           }
        // UI이미지를 가져오자마자, 가로200픽셀로 resize
               let newImage = image?.resized(toWidth: 400.0)
               
               let resultImg = newImage?.jpegData(compressionQuality: 0.9)!
               print("이미지사이즈:\(image!)")
               //이미지를 데이터로 변환한뒤에, JSON형태로 전송하기 위해서 base64로 인코딩한다.
               let imageStr = resultImg!.base64EncodedString()
        
        let json: [String: Any] = [
           "encoded_image" : imageStr,
           "title": textFildTitle.text ?? "",
           "region": "동작구",
           "category_large":1 ,
           "category_middle":6,
           "category_small":1,
           "tags": [tags],
           "price" :textFieldPrice.text ?? "",
           "content": textView.text ?? "",
           "count" :1,
           "is_exchanble": 0,
           "safepay":1,
           "delivery_fee":0,
           "pcondition":0
               ]
       let url = "https://dev.wogus4048.shop/app/post"
       let headers : HTTPHeaders = [
//           "Content-Type" :"multipart/form-data",
           "Content-type" :"application/json;charset=UTF-8",
           "accept" : "application/json",
           "X-ACCESS-TOKEN" : jwt]
        
//             let headers: HTTPHeaders = ["Authorization" : KeychainSwift().get("access_key")!]
        
              //이미지 전송
              let call = AF.request(url, method: .post, parameters: json,
                                    encoding: JSONEncoding.default,
                                    headers: headers)
              //                call.responseJSON { res in
              call.responseJSON { [self] res in
                  
                  // 성공실패케이스문 작성하기
                  print("서버로 보냄!!!!!")
                  
                  guard (try? res.result.get() as? NSDictionary) != nil else {
                      print("올바른 응답값이 아닙니다.")
                      return
                  }
      //
                  if let jsonObject = try? res.result.get() as? [String :Any]{
                      let code = jsonObject["code"] as? Int ?? 0
                      if code == 1000 {
                          print( "JSON= : \(try! res.result.get())!")
//                          print(res)
//                          debugPrint(res)
//                          self.dismiss(animated: true, completion: nil)
                          
//                          let postID = jsonObject["result"]["post_id"] as Any?
//                        print("게시글번호: \(postID)")
                          
                          DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                            // 1초 후 실행될 부분
                              if let nextScene = self.storyboard?.instantiateViewController(withIdentifier: "registerDetailVC" ){
                                         nextScene.modalPresentationStyle = .fullScreen
                                         // 화면 전환 애니메이션의 타입
                                         self.present(nextScene, animated : true)
                                     }
                              
                          }
                      
                                      
                      }else{
                          //sucess가 0이면
                          print(res)
//                          debugPrint(res)
                      }
                  }
              }
        }
     
                  
    
     //카테고리띄우기
    @IBAction func categoryMove(_ sender: Any) {
//        if let nextScene = self.storyboard?.instantiateViewController(withIdentifier: "BigCategoryVC" ){
//                nextScene.modalPresentationStyle = .fullScreen
//                // 화면 전환 애니메이션의 타입
//                self.present(nextScene, animated : true)
//            }
    }
    

}//뷰컨끝


// MARK: - 이미지 사이즈 줄이기
extension UIImage {
    func resized(withPercentage percentage: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    func resized(toWidth width: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
}


// MARK: - 텍스트뷰
extension registerVC: UITextViewDelegate, UITextFieldDelegate {
    
    // 편집이 시작될때
    func textViewDidBeginEditing(_ textView: UITextView) {
        //        textViewSetupView()
        textView.text = ""
        subText.text = ""
        textView.textColor = .black
        textFildTitle.textColor = .black
        textFieldPrice.textColor = .black
    }
    
    // 편집이 종료될때
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textViewSetupView()
        }
    }
    
    //텍스트필드편집이 시작될때
    func textFieldDidBeginEditing(_ textField: UITextField){
        textFildTitle.textColor = .black
        textFieldPrice.textColor = .black
    }
}

