//
//  TagVC.swift
//  BJMarket
//
//  Created by 이청준 on 2022/09/21.
//

import Foundation
import UIKit
import TagListView


class TagVC : UIViewController, TagListViewDelegate{
    
    var tagList = [String]()
    let saveTag = UserDefaults.standard
    
    @IBOutlet weak var textFiled: UITextField!//텍스트필드
    
    @IBOutlet weak var addBtn: UIButton!//추가버튼
    
    @IBOutlet weak var myTabListView: TagListView! //태그입력하면보이는뷰//
    // 닫기
    @IBAction func close(_ sender: Any) {
//        passString(tagList:tagList)
        // 화면 전환 애니메이션의 타입
        // 태그값 set으로저장
        saveTag.set(tagList, forKey: "tag")
        self.saveTag.synchronize()//동기화처리
        self.dismiss(animated: true)
    }
    
    
    override func viewDidLoad() {
        myTabListView.delegate = self
        //추가버튼액션
        addBtn.addTarget(self, action: #selector(addTag), for: .touchUpInside)
    }



    
    //MARK: - 태그액션(누르면 하단에 추가)
    @objc fileprivate func addTag(){
        print("addTag")
        let userInput = textFiled.text
        //언래핑
        if let input = userInput{
            
            if input.count > 1{
                myTabListView.addTag(input)
                textFiled.text = ""
                tagList.append(input)
                print(tagList)
                
            }else{
                print("값이없음")
            }
        }
    }
    
    
    //태그버튼을 눌렀을때(태그의타이플, 해당태그의뷰, 태그리스트뷰)
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        tagView.isSelected.toggle()
    }
    
    //태그삭제버튼 클릭시
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        sender.removeTagView(tagView)
//        tagList.remove(at: <#T##Int#>)
        print("삭제버튼누른단어 :\(title)")
        
        let checkWord = title
        //리스트에서 제거
        tagList.removeAll(where: { $0 == checkWord })
        print(tagList)
        }
    }

