//
//  GameVM.swift
//  TableView
//
//  Created by Walter J on 2023/01/27.
//

import Foundation

struct GameVM {
    var games: [GameModel] = []
    
    init() {
        //plist에서 데이터를 가져와서
        //games 객체에 삽입
        games = fetchData()
    }
    
    func getCountOfGames() -> Int {
        return games.count
    }
    
    func getGame(idx: Int) -> GameModel {
        return games[idx]
    }
    
    func getDateForHeader() -> Set<String> {
        //games의 date(2022-01-01)를 가져와서
        //마지막 일자를 띠어내고 년, 월만 가져온다.
        //년,월을 중복되지 않기 위해 임의의 set collction에 담는다
        //set collection을 리턴한다.
        
        var year_month = Set<String>()
        games.forEach {
            let startIdx = $0.date.startIndex
            let range = $0.date.index(startIdx, offsetBy: 6)
            let ym = $0.date[startIdx...range]
            year_month.insert(String(ym))
        }
        
        return year_month
    }
}

//plist parsing
private extension GameVM {
    func fetchData() -> [GameModel] {
        guard let url = Bundle.main.url(forResource: "Games", withExtension: "plist") else { return [] }
        
        do {
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode([GameModel].self, from: data)
            return result
        } catch let error {
            print("error: \(error.localizedDescription)")
        }
        
        return []
    }
}
