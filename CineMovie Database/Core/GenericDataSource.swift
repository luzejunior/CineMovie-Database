//
//  GenericDataSource.swift
//  CineMovie Database
//
//  Created by Luzenildo Junior on 25/10/18.
//  Copyright © 2018 Luzenildo Junior. All rights reserved.
//

import UIKit

final class GenericDataSource: NSObject, UITableViewDataSource {
    
    var items: [UITableViewModels] = []
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = items[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: model.representable.identifier, for: indexPath)
        model.representable.update(view: cell)
        return cell
    }
}

protocol UITableViewModels {
    var representable: UITableViewRepresentable { get }
}

protocol UITableViewRepresentable {
    var identifier: String { get }
    func update(view: UIView)
}

protocol UITableViewContent {
    associatedtype Presenter
    func load(presenter: Presenter)
}

final class UITableViewContentAssembler<T: UITableViewContent>: UITableViewRepresentable where T: UIView {
    let presenter: T.Presenter
    
    init(presenter: T.Presenter) {
        self.presenter = presenter
    }
    
    func update(view: UIView) {
        (view as? T)?.load(presenter: presenter)
    }
    
    var identifier: String {
        return String(describing: T.self)
    }
}

extension UITableView {
    func register(_ cellClass: AnyClass) {
        register(UINib(nibName: String(describing: cellClass.self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: cellClass.self))
    }
}
