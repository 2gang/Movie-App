//
//  DramaViewController.swift
//  MovieLgh
//
//  Created by 이경호 on 2023/06/07.
//

import UIKit
import WebKit

class DramaViewController: UIViewController {
    @IBOutlet weak var dramaView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://www.netflix.com/kr/browse/genre/11714"
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        dramaView.load(request)
        
        

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
