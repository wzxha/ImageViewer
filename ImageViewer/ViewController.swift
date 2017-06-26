//
//  ViewController.swift
//  ImageViewer
//
//  Created by wzxjiang on 2017/6/26.
//  Copyright © 2017年 wzxjiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "ImageCell", bundle: nil), forCellReuseIdentifier: "ImageCell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Actions
    
    func clickImage(sender: UIButton) {
        let imageViewController = ImageViewController()
        
        imageViewController.selectedView = sender.imageView
        
        self.present(imageViewController, animated: true)
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let imageCell = cell as? ImageCell else { return }
        
        imageCell.imageButtons.forEach {
            $0.addTarget(self, action: #selector(ViewController.clickImage(sender:)), for: .touchUpInside)
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "ImageCell")!
    }
}
