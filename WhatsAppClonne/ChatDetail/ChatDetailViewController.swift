//
//  ChatDetailViewController.swift
//  WhatsAppClonne
//
//  Created by Jhansi Ch on 01/06/24.
//

import UIKit
import CoreData

class ChatDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , UIImagePickerControllerDelegate, UINavigationControllerDelegate, ImageViewerDelegate {
    
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    let context = (UIApplication.shared.delegate as!AppDelegate).persistentContainer.viewContext
    private var models = [Chats]()

    var chatItems: [ChatItem] = []
    
    var slectedChatName: String = ""
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getAllItems()
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
        tableView.register(UINib(nibName: "ImageCell", bundle: nil), forCellReuseIdentifier: "ImageCell")
        detailLabel.text = slectedChatName
        tableView.estimatedRowHeight = 44.0 // Estimated height for automatic dimension
        tableView.rowHeight = UITableView.automaticDimension
        hideKeyboardWhenTappedAround()
    }
    
    func getAllItems() {
        let fetchRequest: NSFetchRequest<Chats> = Chats.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "chatName == %@", slectedChatName)
        do{
            models = try  context.fetch(fetchRequest)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch{
             print("It Can't get items")
        }
    }
    
    func createChat(name : String, text: String, image: UIImage?) {
        let newItem = Chats(context: context)
        newItem.chatName = name
        newItem.image = image?.pngData()
        newItem.text = text
        do{
            try context.save()
            getAllItems()
        }
        catch{
            print("It can't create items")
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        if let message = messageTextField.text, !message.isEmpty {
            createChat(name: slectedChatName, text: message, image: nil)
            tableView.reloadData()
            messageTextField.text = ""
            scrollToBottom()
        }
    }
    
    func didSelectImage(_ image: UIImage) {
        selectedImage = image
        createChat(name: slectedChatName, text: "", image: image)
        tableView.reloadData()
        scrollToBottom()
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            selectedImage = pickedImage
        }
        
        
        dismiss(animated: true, completion: nil)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let secondViewController = storyboard.instantiateViewController(withIdentifier: "ImageViewer") as? ImageViewer {
            secondViewController.delegate = self // Set the delegate
            navigationController?.setNavigationBarHidden(true, animated: true)
            secondViewController.selectedImage = selectedImage// Pass data if needed
            present(secondViewController, animated: true)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func scrollToBottom() {
        if models.count > 0 {
            let indexPath = IndexPath(row: models.count - 1, section: 0)
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        let imageCell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.messageText.text = models[indexPath.row].text
        let chatItem = models[indexPath.row]
            cell.messageText.text = chatItem.text
            
            if let imageData = chatItem.image {
                if let image = UIImage(data: imageData) {
                    imageCell.imagee.image = image
                    return imageCell
                }
            }
       return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
