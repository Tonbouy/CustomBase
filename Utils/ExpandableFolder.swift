//
//  ExpandableFolder.swift
//  ExpandableFolder
//
//  Created by Nicolas Ribeiro on 12/04/2019.
//  Copyright © 2019 Tonbouy. All rights reserved.
//

import Foundation

public protocol ExpandableFolder {

    var id: Int { get }

    func getChilds() -> [Any]
}
