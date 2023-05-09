//
//  Extensions.swift
//  Cyber Movie
//
//  Created by Дмитро Павлов on 09.05.2023.
//

import UIKit

extension UITableView {
    func dequeue<T: UITableViewCell>(cellForRowAt indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: "\(T.self)", for: indexPath) as! T
    }
}
