//
//  NLAccountView.swift
//  NLWeibo
//
//  Created by Rake Yang on 2019/12/4.
//

import UIKit

class NLAccountView: UIView {
    var tableView : UITableView?
    var presenter : NLWeiboPresenter?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    func setupSubviews() {
        tableView = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
        tableView?.backgroundColor = backgroundColor
        tableView?.delegate = self
        tableView?.dataSource = self
        addSubview(tableView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension NLAccountView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell.init(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: nil)
    }
    
    
}

extension NLAccountView: UITableViewDelegate {
    
}
