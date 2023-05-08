//
//  ViewController.swift
//  crypto_UI
//
//  Created by Фараби Иса on 08.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let header: UILabel = {
        let label = UILabel()
        label.text = "Портфолио"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let settingButton: UIButton = {
        let image = UIButton()
        image.setImage(UIImage(systemName: "gearshape"), for: .normal)
        image.tintColor = .gray
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Посмотреть все"
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        tableView.isUserInteractionEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let cellReuseIdentifier = "cell"
    let images = ["bitcoinsign", "triangle.fill", "l.circle.fill", "line.3.crossed.swirl.circle", "line.3.crossed.swirl.circle", "line.3.crossed.swirl.circle"]
    let names = ["Bitcoin", "Ethereum", "Litecoin", "Ripple", "Ripple", "Ripple"]
    let percentageLabel2 = ["+1.6%", "-0,82%"]
    let priceLabel2 = ["$29,850.15", "$10,561.24"]
    let price2Label2 = ["2.73 BTC", "47.61 ETH"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        setupViews()
        setupConstraints()
    }

    func setupViews() {
        view.backgroundColor = .white
        
        setupTabBarController()
        view.addSubview(header)
        view.addSubview(settingButton)
        view.addSubview(label)
        view.addSubview(tableView)
    }
    
    func setupTabBarController() {
        let tabBarController = UITabBarController()
        
        let firstViewController = UIViewController()
        firstViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "rectangle.3.group"), tag: 0)
        
        let secondViewController = UIViewController()
        secondViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "arrow.triangle.2.circlepath"), tag: 1)
        
        let thirdViewController = UIViewController()
        thirdViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "person"), tag: 2)
        
        tabBarController.viewControllers = [firstViewController, secondViewController, thirdViewController]
        
        let tabBar = tabBarController.tabBar
        tabBar.tintColor = .red
        
        let topDividerView = UIView(frame: CGRect(x: 0, y: 0, width: tabBar.frame.width, height: 1))
        topDividerView.backgroundColor = .lightGray
        tabBar.addSubview(topDividerView)
        
        addChild(tabBarController)
        view.addSubview(tabBarController.view)
        tabBarController.didMove(toParent: self)
        
        tabBarController.delegate = self
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            header.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            settingButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            settingButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            label.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 40),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        let stackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.alignment = .top
            stackView.spacing = 10
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        
        let leftStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.alignment = .top
            return stackView
        }()
        
        let imageCrypto: UIButton = {
            let button = UIButton()
            if indexPath.row % 2 == 0 {
                button.backgroundColor = .systemYellow
            } else {
                button.backgroundColor = .lightGray
            }
            button.layer.cornerRadius = 21
            button.setImage(UIImage(systemName: images[indexPath.row]), for: .normal)
            button.tintColor = .red
            button.widthAnchor.constraint(equalToConstant: 60).isActive = true
            button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
            return button
        }()
        
        let nameLabel: UILabel = {
            let label = UILabel()
            label.text = names[indexPath.row]
            label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            return label
        }()
        leftStackView.addArrangedSubview(nameLabel)
        
        let percentageLabel: UILabel = {
            let label = UILabel()
            label.text = percentageLabel2[indexPath.row % percentageLabel2.count]
            label.textColor = .lightGray
            label.font = UIFont.systemFont(ofSize: 11)
            return label
        }()
        leftStackView.addArrangedSubview(percentageLabel)
        
        let rightStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.alignment = .trailing
            return stackView
        }()
        
        let priceLabel: UILabel = {
            let label = UILabel()
            label.text = priceLabel2[indexPath.row % priceLabel2.count]
            label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            return label
        }()
        rightStackView.addArrangedSubview(priceLabel)
        
        let price2Label: UILabel = {
            let label = UILabel()
            label.text = price2Label2[indexPath.row % price2Label2.count]
            label.textColor = .lightGray
            label.font = UIFont.systemFont(ofSize: 11)
            return label
        }()
        rightStackView.addArrangedSubview(price2Label)
        
        stackView.addArrangedSubview(imageCrypto)
        stackView.addArrangedSubview(leftStackView)
        stackView.addArrangedSubview(rightStackView)
        
        cell.contentView.addSubview(stackView)
        
        // Set up constraints for the stack view
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 13),
            stackView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 25),
            stackView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -25),
            stackView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -13)
        ])
        
        return cell
    }
}

extension ViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        tabBarController.tabBar.tintColor = .red
    }
}
