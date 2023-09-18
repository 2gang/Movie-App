//
//  MapViewController.swift
//  MovieLgh
//
//  Created by 이경호 on 2023/06/07.
//

import UIKit
import WebKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlKorString = "https://map.naver.com/v5/search/영회관"
        let urlString = urlKorString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        mapView.load(request)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
