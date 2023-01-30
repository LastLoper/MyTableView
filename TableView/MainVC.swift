//
//  ViewController.swift
//  TableView
//
//  Created by Walter J on 2023/01/27.
//

import UIKit
import SnapKit

class MainVC: UIViewController {

    //MARK: - Custom Views
    private let gameList = UITableView(frame: .zero, style: .grouped)
    //style이 .plain일 때는 headerView가 고정되어 움직이지 않는다.
    //.grouped로 변경해줘야 스크롤할 때 같이 움직인다. (기본은 .plain)
    //.insetGrouped는 각 item들의 모서리가 둥글러지며, 양 옆에 inset이 들어간다.
    
    //MARK: - Local Variables
    let gameVM = GameVM()
    var sectionTitles: [String] = []
    var itemsInSection: [[GameModel]] = [[]]
    
    //MARK: - ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setUpLayout()
        setUpAttributes()
        setUpHeaderTitles()
    }
}

private extension MainVC {
    func setUpAttributes() {
        view.backgroundColor = .systemBackground
        
        /* Attributes for tableView */
        gameList.delegate = self
        gameList.dataSource = self
        
        //TableView Cell 등록
        gameList.register(GameListCell.self, forCellReuseIdentifier: GameListCell.id)
        
        //TableView Header 등록
        gameList.register(GameListHeader.self, forHeaderFooterViewReuseIdentifier: GameListHeader.id)
    }
    
    func setUpLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(gameList)
        gameList.snp.makeConstraints {
            $0.edges.equalTo(safeArea)
        }
    }
    
    func setUpHeaderTitles() {
        //Section Title
        //원본의 순서를 바꾸는 sort, 사본을 만드는 것은 sorted(by:)
        sectionTitles = gameVM.getDateForHeader().sorted {
            $0 < $1
        }
    }
}

extension MainVC: UITableViewDataSource {
    //각 Section별 item 갯수 정의
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return itemsInSection[section].count
        return gameVM.getCountOfGames()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //기본 TableCell의 모양 속성
//        let cell = tableView.dequeueReusableCell(withIdentifier: GameListCell.id)
//        cell?.accessoryType = .checkmark
//        cell?.accessoryType = .detailButton
//        cell?.accessoryType = .detailDisclosureButton
//        cell?.accessoryType = .disclosureIndicator
        
        //Custom Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: GameListCell.id, for: indexPath) as? GameListCell
        let item = gameVM.getGame(idx: indexPath.item)
        
        
        
        cell?.prepare(game: item)        
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    //TableView에서 지원하는 Header의 Title설정
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        var dateForHeader:[String] = []
//        gameVM.getDateForHeader().forEach {
//            dateForHeader.append($0)
//        }
//        return dateForHeader[section]
//    }
}

extension MainVC: UITableViewDelegate {
    
//    Custom HeaderView는 UITableViewDelegate에서 오버라이드
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: GameListHeader.id) as? GameListHeader
        print("section???? \(section), \(sectionTitles[section])")
        headerView?.prepare(title: sectionTitles[section])
        
        return headerView ?? UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
}
