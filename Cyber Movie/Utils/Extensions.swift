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

extension UIScrollView {
    func performActionWhenScrollAtBottom(action: () -> ()) {
        let offset = self.contentOffset.y
        let height = self.frame.size.height
        let contentHeight = self.contentSize.height
        let distanceToBottom = contentHeight - offset - height
        let distanceForLoadingNewPage: CGFloat = 50
        
        var isLoadNeeded = true
        
        if distanceToBottom < distanceForLoadingNewPage && isLoadNeeded {
            isLoadNeeded = false
            action()
            isLoadNeeded = true
        }
    }
}
