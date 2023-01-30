//
//  GameListCell.swift
//  TableView
//
//  Created by Walter J on 2023/01/27.
//

import UIKit
import SnapKit

class GameListCell: UITableViewCell {
    static let id = "GameListCell"
    
    //MARK: - Custom Views
    private let gameTitle = UILabel()
    private let gameLogo = UIImageView()
    
    //MARK: - Local Variables
   
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpAttributes()
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepare(game: GameModel) {
        gameTitle.text = game.title
        gameLogo.image = UIImage(named: game.logo)
    }
}

private extension GameListCell {
    func setUpAttributes() {
        //Cell 기본 설정
        selectionStyle = .none            //선택했을 때 회색으로 선택 표시되는 것 없애기
        
        //gameLogo Attributes
        gameLogo.contentMode = .scaleAspectFill
        gameLogo.sizeToFit()
        gameLogo.clipsToBounds = true
        gameLogo.autoresizesSubviews = true
        
        //gameTitle Attributes
        gameTitle.text = "게임 타이틀"
        gameTitle.font = .systemFont(ofSize: 17, weight: .bold)
        gameTitle.textColor = .label
        gameTitle.textAlignment = .left
    }
    
    func setUpLayout() {
        [gameLogo, gameTitle].forEach {
            contentView.addSubview($0)
        }
        
        gameLogo.snp.makeConstraints {
            $0.width.equalTo(60)
            $0.height.equalTo(gameLogo.snp.width)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(5)
        }
        
        gameTitle.snp.makeConstraints {
            $0.leading.equalTo(gameLogo.snp.trailing).offset(5)
            $0.top.trailing.bottom.equalToSuperview().offset(5)
        }
    }
}
