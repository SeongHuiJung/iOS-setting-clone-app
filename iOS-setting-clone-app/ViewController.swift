//
//  ViewController.swift
//  iOS-setting-clone-app
//
//  Created by 정성희 on 2024/02/13.
//

import UIKit

class ViewController: UIViewController {
    
    var settingModel = [[SettingModel]]() //[[]] 이렇게 해주면 이중배열 구조

    func makeData(){
        settingModel.append(
        [SettingModel(leftImageName: "person.circle", menuTitle: "Sign in to your iPhone", subTitle: "Set up iCloud, the App Store, and more.", rightImageName: nil)]
        )
        
        settingModel.append(
        [SettingModel(leftImageName: "gear", menuTitle: "General", subTitle: nil, rightImageName: "chevron.right"),
        SettingModel(leftImageName: "person.fill", menuTitle: "Accessibility", subTitle: nil, rightImageName: "chevron.right"),
        SettingModel(leftImageName: "hand.raised.fill", menuTitle: "Privacy", subTitle: nil, rightImageName: "chevron.right")]
        )
        
    }
    
    @IBOutlet weak var settingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //++ 해당 작업을 하는 이유 찾아보기
        settingTableView.delegate=self
        settingTableView.dataSource=self

        //xib파일 등록?
        let nib = UINib(nibName: "PrifileViewCell", bundle: nil)
        //현재 viewcontroller에서의 tableview에 nib 뷰를 추가
        settingTableView.register(nib, forCellReuseIdentifier: "PrifileViewCell")
        
        settingTableView.register(UINib(nibName: "MenuCell", bundle: nil), forCellReuseIdentifier: "MenuCell")
        
        //섹션 별 구간 나눌때, table view 의 인스펙터에서 style 을 group 으로 바꾼 후 배경색을 지정하면 구간 별로 나눠주는 효과를 볼 수 있음
        settingTableView.backgroundColor = UIColor(white: 245/255, alpha: 1)
        
        makeData()
    }
}

//프로토콜을 준수해야함
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    //필수, 셀 개수//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //섹션에서의 row 개수 리턴
        print("line: \(settingModel[section].count)")
        return settingModel[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        settingModel.count
    }
    
    //필수, indexPath는 순서. 최종?적으로 출력해주는 곳//
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //맨 첫번째 cell 의 경우 PrifileViewCell 를 보여줌
        if(indexPath.section == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "PrifileViewCell", for: indexPath) as! PrifileViewCell
            cell.topTitle.text = settingModel[indexPath.section][indexPath.row].menuTitle
            cell.profileImageView.image = UIImage(systemName: settingModel[indexPath.section][indexPath.row].leftImageName)
            cell.bottomDescription.text = settingModel[indexPath.section][indexPath.row].subTitle
            return cell
        }
        
        //나머지 cell 들의 경우 MenuCell 을 보여줌
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.leftImage.image = UIImage(systemName: settingModel[indexPath.section][indexPath.row].leftImageName)
        cell.middleTitle.text = settingModel[indexPath.section][indexPath.row].menuTitle
        cell.rightImage.image = UIImage(systemName: settingModel[indexPath.section][indexPath.row].rightImageName ?? "")
        
        //아이콘 색상 변경
        cell.leftImage.tintColor = .red
        
        return cell
    
    }
    
    //셀 높이 지정 방법1 : 아래 함수 이용
    //셀 높이 지정 방법2는 이미지뷰 constrait 값을 위아래로 지정해주면됨
    /*
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    */
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0){
            //기본값 그대로 출력하겠다는 의미
            return UITableView.automaticDimension
        }
        return 60
    }
}
