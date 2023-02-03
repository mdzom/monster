//
//  MonsterCaptureViewController.swift
//  Monsters
//
//  Created by Gennadij Pleshanov on 15.01.2023.
//

import UIKit
//import SceneKit
import ARKit
import RealmSwift

class MonsterCaptureViewController: UIViewController {
    
    var name: String?
    
    private lazy var level: String = {
        let number = Int.random(in: 5...20)
        return "Уровень \(number)"
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.tintColor = UIColor(red: 0.31,
                                   green: 0.545,
                                   blue: 0.867,
                                   alpha: 1)
        button.addTarget(self,
                         action: #selector(pushButton),
                         for: .touchUpInside)
        button.setTitle("Попобовать поймать",
                        for: .normal)
        button.titleLabel?.font = UIFont(name: "SFUIDisplay-Semibold",
                                         size: 19)
        button.layer.backgroundColor = UIColor(red: 0.044,
                                               green: 0.044,
                                               blue: 0.044,
                                               alpha: 0.9).cgColor
        button.layer.cornerRadius = 15
        return button
    }()
    
    private lazy var sceneView = {
        let view = ARSCNView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addToView()
        addConstraint()
        createScene()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    private func addToView() {
        view.addSubview(sceneView)
        view.addSubview(actionButton)
    }
    
    private func addConstraint() {
        addConstraintToFullScreen(sceneView)
        
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        actionButton.widthAnchor.constraint(equalToConstant: 270).isActive = true
        actionButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
    }
    
    private func createScene() {
        let scene = SCNScene()
        
        let plane = SCNPlane(width: 0.5, height: 0.5)
        let planeNode = SCNNode(geometry: plane)
        
        let material = SCNMaterial()
        
        material.diffuse.contents = UIImage(named: name ?? "")
        plane.materials = [material]
        planeNode.position = SCNVector3(0, 0, -1)
        let sphereMaterial = SCNMaterial()
        sphereMaterial.diffuse.contents = UIColor.black
        scene.rootNode.addChildNode(planeNode)
        
        let textPlane = SCNPlane(width: 0.2, height: 0.1)
        let textNode = SCNNode(geometry: textPlane)
        
        let textMaterial = SCNMaterial()
        textMaterial.diffuse.contents = createTextImage(name: name ?? "",
                                                        level: level)
        textPlane.materials = [textMaterial]
        
        textNode.position = SCNVector3(0, 0.3, -1)
        
        scene.rootNode.addChildNode(textNode)
        
        sceneView.scene = scene
    }
    
    private func createTextImage(name: String, level: String) -> UIImage {
        
        let nameLabel = UILabel()
        nameLabel.text = name
        nameLabel.textColor = .white
        nameLabel.font = UIFont(name: "SFUIDisplay-Semibold",
                                size: 17)
        
        let levelLabel = UILabel()
        levelLabel.text = level
        levelLabel.textColor = .white
        levelLabel.font = UIFont(name: "SFUIDisplay-Light",
                                 size: 13)
        
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0,
                                                  width: 100,
                                                  height: 30))
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.backgroundColor = UIColor(red: 0.044,
                                            green: 0.044,
                                            blue: 0.044,
                                            alpha: 0.7)
        stackView.layer.cornerRadius = 12
        stackView.spacing = 0
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(levelLabel)
        
        UIGraphicsBeginImageContextWithOptions(stackView.bounds.size, false, 0)
        
        stackView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    private func systemAlert(title: String, messege: String, noRepeat: Bool) {
        let alert = UIAlertController(title: title,
                                      message: messege,
                                      preferredStyle: .actionSheet)
        if noRepeat {
            let action = UIAlertAction(title: "Перейти к карте",
                                       style: .default) { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }
            alert.addAction(action)
        } else {
            let action = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action)
        }
        present(alert, animated: true)
    }
    
    @IBAction func pushButton(_ sender: UIButton) {
        let number = Int.random(in: 0...100)
        print("tap!")
        switch number {
        case 0...20:
            let monster = Monster(name: name ?? "", level: level)
            try! realm.write({
                realm.add(monster)
            })
            systemAlert(title: "Ура!",
                        messege: "Вы поймали монстра \(name ?? "") в свою команду!",
                        noRepeat: true)
        case 21...50:
            systemAlert(title: "Не вышло:(",
                        messege: "Монстр убежал!",
                        noRepeat: true)
        default:
            systemAlert(title: "Не вышло:(",
                        messege: "Попробуйте поймать еще раз!",
                        noRepeat: false)
        }
    }
}
