//
//  ViewController.swift
//  RoomCaptureApp
//
//  Created by Maharjan on 14/04/23.
//

import UIKit
import RoomPlan

class ViewController: UIViewController {

    
    @IBOutlet weak var scannedResultTV: UITableView!
    
    @IBOutlet weak var generate: UIButton!
    
    var scannedModels = [ScannedModel]()
    var dates = [String]()
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.scannedModels.removeAll()
        self.scannedResultTV.reloadData()
        getFilePaths()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, image: UIImage(systemName: "camera.aperture"), target: self, action: #selector(scanBtnPressed))
        
        generate.addTarget(self, action: #selector(generateButtonPressed), for: .touchUpInside)
        generate.backgroundColor = UIColor.gray
        navigationController?.navigationBar.prefersLargeTitles = true
//        view.addSubview(promptTextField)
//        promptTextField.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        scannedResultTV.delegate = self
        scannedResultTV.dataSource = self
        scannedResultTV.register(UINib(nibName: "ModelCell", bundle: nil), forCellReuseIdentifier: "CELL")
   
        
    }
    
    @objc func scanBtnPressed(){
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "roomScannerVC") as? RoomScannerVC{
            navigationController?.pushViewController(vc, animated: true)
        }

    }
    
    @objc func generateButtonPressed(){
        print("PRESSED Generate")
        let vc = GenerateViewController()
        vc.viewModel = GenerateViewModel()
        vc.completeGeneration = { [weak self] in
            guard let self = self else { return }
            
        }
        self.present(vc, animated: true)
    }
    
    
    func getFilePaths(){
        let fm = FileManager.default
        let path = fm.urls(for: .documentDirectory, in: .userDomainMask).first!
        do{
            let content = try fm.contentsOfDirectory(atPath: path.path)
            print(path)
            print(path.absoluteString)
            print(path.absoluteURL)
            print(path.path(percentEncoded: false))
            print(content)
            for c in content{
                self.scannedModels.append(ScannedModel(filePath: path.appendingPathComponent(c).absoluteString, creationDate: "\(try! fm.attributesOfItem(atPath: path.appendingPathComponent(c).path)[.creationDate] as? NSDate)"))
            }
            self.scannedResultTV.reloadData()
        }
        catch{
            print(error)
        }
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scannedModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CELL") as? ModelCell{
            cell.updateCell(path: scannedModels[indexPath.row].filePath, modelName: (scannedModels[indexPath.row].filePath as! NSString).lastPathComponent,creationDate: self.getFileCreationDate(path: URL(string:  scannedModels[indexPath.row].filePath)!)!)
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ModelViewerVC") as? ModelViewerVC{
            vc.modelFilePath = scannedModels[indexPath.row].filePath
            navigationController?.pushViewController(vc, animated: true)
        }
//        let vc = NewModelViewController()
//        let navVC = UINavigationController(rootViewController: vc)
        //            vc.modelFilePath = scannedModels[indexPath.row].filePath
        //            navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
    


extension ViewController{
    func getFileCreationDate(path: URL) -> String?{
        do{
            if let date = try FileManager.default.attributesOfItem(atPath: path.path(percentEncoded: false))[.creationDate] as? Date{
                let formatter = DateFormatter()
                formatter.dateFormat = "MM/dd/yyyy"
                return formatter.string(from: date)
            }
           
        }
        catch{
            print(error)
        }
        return nil
    }
}
