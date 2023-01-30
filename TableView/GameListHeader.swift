//
//  GameListHeader.swift
//  TableView
//
//  Created by Walter J on 2023/01/27.
//

import UIKit
import SnapKit

class GameListHeader: UITableViewHeaderFooterView {
    static let id = "GameListHeader"
    
    //Custom Views
    private let headerTitle = UILabel()
    
    //Local Variables
    
    //LayoutSubviews()
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setUpAttributes()
        setUpLayout()
    }
    
    func prepare(title: String) {
        headerTitle.text = title
    }
}

private extension GameListHeader {
    func setUpAttributes() {    
        //headerTitle Attributes
        headerTitle.font = .systemFont(ofSize: 17, weight: .bold)
        headerTitle.textColor = .label
    }
    
    func setUpLayout() {
        contentView.addSubview(headerTitle)
        headerTitle.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(5)
        }
    }
}
