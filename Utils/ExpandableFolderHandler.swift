//
//  ExpandableFolderHandler.swift
//  ExpandableFolderHandler
//
//  Created by Nicolas Ribeiro on 12/04/2019.
//  Copyright © 2019 Tonbouy. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import CleanUtils

public class ExpandableFolderHandler<T> where T: ExpandableFolder {

    private let associatedState: BehaviorRelay<CollectionState<T>>
    public let reloadData = PublishSubject<Bool>()
    public let expandChange = PublishSubject<(Int, Bool)>()

    public var displayList = [Any]()
    public lazy var displayUpdate = Observable.combineLatest(reloadData, associatedState.distinctUntilChanged { $0.data?.count == $1.data?.count }) { $1 }

    var expandedFolders = Set<Int>()

    let disposeBag = DisposeBag()

    public init(withState state: BehaviorRelay<CollectionState<T>>) {
        self.associatedState = state
        state.map { state -> [Any] in
                let folders = state.data
                var list = [Any]()
                folders?.forEach { folder in
                    list.append(folder)
                    if self.expandedFolders.contains(folder.id) {
                        list.append(contentsOf: folder.getChilds())
                    }
                }
                return list
            }
            .subscribe(onNext: { list in
                self.displayList = list
                self.reloadData.onNext(true)
            })
            .disposed(by: self.disposeBag)
    }

    public func onFolderTapped(inTableView tableView: UITableView, atIndexPath indexPath: IndexPath) -> Bool {
        let index = indexPath.row

        guard let folder = displayList[index] as? T else { return false }

        let childs = folder.getChilds()
        let childCount = childs.count
        if childCount == 0 { return true }
        var updatedList = displayList
        let updateCount: Int

        if expandedFolders.remove(folder.id) != nil {
            for _ in 1...childCount { updatedList.remove(at: index + 1)  }
            updateCount = -childCount
            expandChange.onNext((folder.id, false))
        } else {
            expandedFolders.insert(folder.id)
            updatedList.insert(contentsOf: childs, at: index + 1)
            updateCount = childCount
            expandChange.onNext((folder.id, true))
        }
        displayList = updatedList

        if updateCount == 0 { return true }

        tableView.beginUpdates()
        var indexes = [IndexPath]()
        for i in index + 1 ... index + abs(updateCount) {
            indexes.append(IndexPath(row: i, section: indexPath.section))
        }
        if updateCount > 0 {
            tableView.insertRows(at: indexes, with: .bottom)
        } else {
            tableView.deleteRows(at: indexes, with: .bottom)
        }
        tableView.endUpdates()
        return true
    }

    public func isExpanded(_ item: Int) -> Bool {
        return expandedFolders.contains(item)
    }

}
