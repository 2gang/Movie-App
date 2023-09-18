//
//  ViewController.swift
//  MovieLgh
//
//  Created by 이경호 on 2023/05/03.
//

import UIKit

let name = ["슈퍼 마리오 브라더스", "드림", "존 윅4", "스즈메의 문단속", "옥수역 귀신", "리바운드", "더 퍼스트 슬램덩크", "렌필드", "킬링 로맨스", "무명"]

struct MovieData : Codable {
    let boxOfficeResult : BoxOfficeResult
}
struct BoxOfficeResult : Codable {
    let dailyBoxOfficeList : [DailyBoxOfficeList]
}
struct DailyBoxOfficeList : Codable {
    let movieNm : String
    let audiCnt : String
    let audiAcc : String
    
}

class ViewController: UIViewController {
    func getData(){
        guard let url = URL(string: movieURL) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) {(data, response, error) in
            if error != nil {
                print(error!)
                return
            }
        guard let JSONdata = data else { return }
        let dataString = String(data: JSONdata, encoding : .utf8)
        print(dataString!)
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(MovieData.self, from: JSONdata)
            self.movieData = decodedData
            DispatchQueue.main.async{
            self.table.reloadData()
            }
        }catch {
            print(error)
            }
        }
        task.resume()
    }
    
    func getYesterdayDateString() -> String {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) // 어제 날짜 계산
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd" // 원하는 날짜 형식 지정
        let yesterdayString = dateFormatter.string(from: yesterday!) // String으로 변환
        return yesterdayString
    }
    
    func getYesterdayDate() -> String {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) // 어제 날짜 계산
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // 원하는 날짜 형식 지정
        let yesterdayString = dateFormatter.string(from: yesterday!) // String으로 변환
        return yesterdayString
    }
    
    @IBOutlet weak var table: UITableView!
    var movieData : MovieData?
    var movieURL = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=19f09333c6cda3f1a25fad0ca3b68b8a&targetDt="
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        
        movieURL += getYesterdayDateString()
        getData()
        // Do any additional setup after loading the view.
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.description)
    }
}

extension ViewController: UITableViewDataSource {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dest = segue.destination as? DetailViewController else {
            return
        }
        let myIndexPath = table.indexPathForSelectedRow!
        dest.movieName = (movieData?.boxOfficeResult.dailyBoxOfficeList[myIndexPath.row].movieNm)!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "박스오피스(영화진흥위원회제공:" + getYesterdayDate() + ")"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyTableViewCell
        //cell.movieName.text = name[indexPath.row]
        cell.movieName.text = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].movieNm
        if let aCnt = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].audiCnt {
            let numF = NumberFormatter()
            numF.numberStyle = .decimal
            let aCount = Int(aCnt)!
            let result = numF.string(for: aCount)! + "명"
            cell.audiCount.text = "어제: \(result)"
        }
        if let aAcc = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].audiAcc {
            let numF = NumberFormatter()
            numF.numberStyle = .decimal
            let aAccumulate = Int(aAcc)!
            let result = numF.string(for: aAccumulate)! + "명"
            cell.audiAccumulate.text = "누적: \(result)"
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
