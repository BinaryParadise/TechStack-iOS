//
//  WBAccountView.swift
//  NLWeibo
//
//  Created by Rake Yang on 2019/12/4.
//

import UIKit
import SnapKit

@objc public protocol WBAccountViewDelegate : NSObjectProtocol {
    func willClearAuthData()
}

public class WBAccountView : UIView {
    var authTableView: UITableView?
    @objc public var delegate: WBAccountViewDelegate?
    var viewModel: WBAccountViewModel?
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    @objc func setupSubviews() {
        authTableView = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
        authTableView?.backgroundColor = backgroundColor
        authTableView?.delegate = self
        authTableView?.dataSource = self
        addSubview(authTableView!)
        authTableView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self)
        })
    }
    
    @objc public func fillWith(viewModel: WBAccountViewModel) {
        self.viewModel = viewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        authTableView?.reloadData()
    }
}

extension WBAccountView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.items.count ?? 0) + 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: nil)
        if (indexPath.row == viewModel!.items.count) {
            cell.textLabel?.text = "退出";
        } else {
            let kv = viewModel!.items[indexPath.row]
            cell.textLabel?.text = kv.key
            cell.detailTextLabel?.text = kv.value as? String
        }
        return cell;
    }
}

extension WBAccountView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel?.items.count {
            delegate?.willClearAuthData()
        }
    }
}
