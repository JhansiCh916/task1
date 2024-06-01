//
//  ViewController.swift
//  WhatsAppClonne
//
//  Created by Jhansi Ch on 29/05/24.
//

import UIKit

class ChatsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    lazy var viewModel = ChatsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        tableView.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatTableViewCell")
        hideKeyboardWhenTappedAround()
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissTheKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissTheKeyboard() {
        view.endEditing(true)
    }
}


extension ChatsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 71
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedChatName = viewModel.didSelectRow(at: indexPath)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let secondViewController = storyboard.instantiateViewController(withIdentifier: "ChatDetailViewController") as? ChatDetailViewController {
            navigationController?.setNavigationBarHidden(true, animated: true)
            secondViewController.slectedChatName = selectedChatName.name
            navigationController?.pushViewController(secondViewController, animated: true)
        }
    }
}


extension ChatsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as? ChatTableViewCell else {
            fatalError("The dequeued cell is not an instance of CustomTableViewCell.")
        }
        cell.contactName?.text = viewModel.textForCell(at: indexPath).name
        cell.contactImg.image = viewModel.textForCell(at: indexPath).image
        return cell
    }
}


extension ChatsViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterContentForSearchText(searchText)
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        viewModel.resetSearch()
        tableView.reloadData()
    }
}
