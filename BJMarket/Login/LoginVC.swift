//
//  LoginVC.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/20.
//

import Foundation
import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import Alamofire

class LoginVC :UIViewController, UIScrollViewDelegate{
    
    var loginModel: LoginModel?
    var presentToken = ""
    //저장소
    let plist = UserDefaults.standard
    
    //상단이미지
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    var images = [UIImage(named: "login_01"),UIImage(named: "login_02"),UIImage(named: "login_03"),UIImage(named: "login_04")]
    var imageViews = [UIImageView]()
    
    
    override func viewDidLoad() {
        
        //상단스크롤이미지
        scrollView.delegate = self
        addContentScrollView()
        setPageControl()
        
    }//뷰디드끝
    
    // MARK: - 이미지스크롤
    private func addContentScrollView() {
        for i in 0..<images.count {
            let imageView = UIImageView()
            let xPos = scrollView.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPos, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
            imageView.image = images[i]
            scrollView.addSubview(imageView)
            scrollView.contentSize.width = imageView.frame.width * CGFloat(i + 1)
        }
    }
    
    private func setPageControl() {
        pageControl.numberOfPages = images.count
    }
    
    private func setPageControlSelectedPage(currentPage:Int) {
        pageControl.currentPage = currentPage
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = scrollView.contentOffset.x/scrollView.frame.size.width
        setPageControlSelectedPage(currentPage: Int(round(value)))
    }
    
    
    //애플로그인에 걸려있음.
    @IBAction func testLogin(_ sender: Any) {
        //        if (UserApi.isKakaoTalkLoginAvailable()) {
        //            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
        //                if let error = error {
        //                    print(error)
        //                }
        //                else {
        //                    print("loginWithKakaoTalk() success.")
        //
        //                    //do something
        //                    _ = oauthToken
        //                }
        //            }
        //        }
    }
   
    
    //로그아웃
    @IBAction func logout(_ sender: Any) {
//        UserApi.shared.logout {(error) in
//            if let error = error {
//                print(error)
//            }
//            else {
//                print("logout() success.")
//            }
//        }
    }
    
    // 북마크 모음 호출
    func postToken() {
        
        //서버로 토큰보내기
        let token = presentToken
        
        let param: Parameters = [ "access_token" :token ]
        
        // API 호출 URL
        let url = "https://dev.wogus4048.shop/oauth/kakao/login"
        let call = AF.request(url, method: .post, parameters: param,
                              encoding: JSONEncoding.default)
        //                call.responseJSON { res in
        call.responseJSON { res in
            
            print("로그인토큰 서버전달")
            
//            guard let jsonObject = try! res.result.get() as? [String :Any] else {
//                print("올바른 응답값이 아닙니다.")
//                return
//            }
            
            if let jsonObject = try? res.result.get() as? [String :Any] {
                let code = jsonObject["code"] as? Int ?? 0
                
                if code == 1000 {
                    do{
                        // Any를 JSON으로 변경
                        let dataJSON = try JSONSerialization.data(withJSONObject:try! res.result.get(), options: .prettyPrinted)
                        //                        print(dataJSON)
                        // JSON디코더 사용
                        self.loginModel = try JSONDecoder().decode(LoginModel.self, from: dataJSON)
                        
//                        print("서버 로그인응답 Sucess \(self.loginModel)")
                        //받아온값
                        let kakaoID = self.loginModel?.result?.kakaoID
                        let userID = self.loginModel?.result?.userID
                        let jwt = self.loginModel?.result?.jwt
                        
                        print("카카오ID: \(kakaoID!)")
                        print("userID: \(userID!)")
                        print("jwt: \(jwt!)")
                        // 저장하고 화면이동하기
                        self.plist.set(kakaoID, forKey: "kakaoID")
                        self.plist.set(userID, forKey: "userID")
                        self.plist.set(jwt, forKey: "jwt")
                        
                        print("아이디jwt저장")
                    
                        
                        if let nextScene = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarVC" ){
                                nextScene.modalPresentationStyle = .fullScreen
                                // 화면 전환 애니메이션의 타입
                                self.present(nextScene, animated : true)
                            }
                        
                        
                    }// 디코딩 에러잡기
                    catch let DecodingError.dataCorrupted(context) {
                        print(context)
                    } catch let DecodingError.keyNotFound(key, context) {
                        print("Key '\(key)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.valueNotFound(value, context) {
                        print("Value '\(value)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.typeMismatch(type, context)  {
                        print("Type '\(type)' mismatch:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch {
                        print("error: ", error)
                    }
                }
                else if(code != 1000){
                    //sucess가 0이면
                    print("응답실패")
                }
            }
        }
    }//함수 끝
    
    
    //로그인버튼(화면이동)
    @IBAction func loginBtn(_ sender: Any) {
        
        // 웹으로 로그인
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
                
                //do something
                _ = oauthToken
                
                // 어세스토큰
                let accessToken = oauthToken?.accessToken
                
                self.presentToken = accessToken ?? "토큰없음"
                //API호출
                self.postToken()
                
                print("토큰정보 :\(accessToken)")
            }
        }
    }
}
