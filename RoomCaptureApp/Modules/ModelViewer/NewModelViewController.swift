//
//  NewModelViewController.swift
//  RoomCaptureApp
//
//  Created by Maharjan on 20/04/2024.
//

import UIKit
import SceneKit
import Foundation

class NewModelViewController: UIViewController {
    var model: SCNScene!
    var optionsSegmentControl: UISegmentedControl!
    var type: SCNLight.LightType!
    var modelViewer: SCNView!
    var modelFilePath: String = ""
    var panGesture: UIPanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(modelFilePath)
        self.type = .ambient
        configureUI()
        optionsSegmentControl.selectedSegmentIndex = 1
        
        // Add a new 3D object (box) to the scene
        addNew3DObject()
        
        addPanGesture()
    }
    
    func configureUI(){
        // Create modelViewer
        modelViewer = SCNView()
        modelViewer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(modelViewer)
        modelViewer.fillSuperview();
        
        NSLayoutConstraint.activate([
            modelViewer.topAnchor.constraint(equalTo: view.topAnchor),
            modelViewer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            modelViewer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            modelViewer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            modelViewer.heightAnchor.constraint(equalToConstant: 300),
            modelViewer.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        modelViewer.showsStatistics = true
        modelViewer.allowsCameraControl = true
        
        // Create optionsSegmentControl
        optionsSegmentControl = UISegmentedControl(items: ["Wireframe", "Normal", "Directional"])
        optionsSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        optionsSegmentControl.addTarget(self, action: #selector(didSegmentValueChange(_:)), for: .valueChanged)
        view.addSubview(optionsSegmentControl)
        
        NSLayoutConstraint.activate([
            optionsSegmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            optionsSegmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
        
        // Load 3D model scene
        model = try! SCNScene(url: URL(string: "\(modelFilePath)")!)
        
        // Create and add light node
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.position = SCNVector3(x: 150, y: 10, z: 100)
        lightNode.light?.type = self.type
        model.rootNode.addChildNode(lightNode)
        
        // Set model to modelViewer
        modelViewer.scene = model
    }
    
    @objc func didSegmentValueChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                modelViewer.debugOptions.insert(SCNDebugOptions.renderAsWireframe)
            case 1:
                modelViewer.debugOptions.remove(SCNDebugOptions.renderAsWireframe)
            case 2:
                self.type = .directional
            default:
                break
        }
    }
    
    func addNew3DObject() {
        // Create a new SCNNode representing a box
        let boxGeometry = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
        let boxNode = SCNNode(geometry: boxGeometry)

        // Position the box node within the scene
        boxNode.position = SCNVector3(x: 0, y: 0.5, z: 0) // Adjust the position as needed

        // Add the box node as a child of the root node of the existing scene
        model.rootNode.addChildNode(boxNode)
    }
    
    func addPanGesture() {
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        modelViewer.addGestureRecognizer(panGesture)
    }
    
    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        // Retrieve the location of the gesture in the scene view
        let location = gestureRecognizer.location(in: modelViewer)
        
        // Perform hit testing to determine which node was touched
        let hitTestResults = modelViewer.hitTest(location, options: nil)
        
        // If a node was touched, update its position based on the gesture
        if let hitNode = hitTestResults.first?.node {
            // Translate the 2D touch location to a 3D point in the scene
            let hitNodePosition = SCNVector3(hitNode.position.x, hitNode.position.y, hitNode.position.z)
            let translation = gestureRecognizer.translation(in: modelViewer)
            let newPosition = SCNVector3(hitNodePosition.x + Float(translation.x / 100), hitNodePosition.y, hitNodePosition.z - Float(translation.y / 100))
            
            // Update the position of the hit node
            hitNode.position = newPosition
            
            // Reset the translation to prevent cumulative translations
            gestureRecognizer.setTranslation(.zero, in: modelViewer)
        }
    }
}
