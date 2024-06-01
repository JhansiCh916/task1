//
//  ChatsViewModel.swift
//  WhatsAppClonne
//
//  Created by Jhansi Ch on 01/06/24.
//

import Foundation

class ChatsViewModel {
    lazy var dataSourceArr = ChatsApi()
    var filteredArr = [Chat]()
    var searching = false
    
    func numberOfRows() -> Int {
        return searching ? filteredArr.count : dataSourceArr.data.count
    }
    
    func textForCell(at indexPath: IndexPath) -> Chat {
        return searching ? filteredArr[indexPath.row] : dataSourceArr.data[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) -> Chat {
        return dataSourceArr.data[indexPath.row]
    }
    
    func filterContentForSearchText(_ searchText: String) {
        if searchText.isEmpty {
            filteredArr = dataSourceArr.data
        } else {
            filteredArr = dataSourceArr.data.filter { $0.name.contains(searchText) }
        }
        searching = true
    }
    
    func resetSearch() {
        searching = false
        filteredArr.removeAll()
    }
}
