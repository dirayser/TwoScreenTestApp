//
//  CharacterListViewController.swift
//  TwoScreenTestApp
//
//  Created by Dmitriy Dmitriyev on 27.04.2025.
//

import UIKit

protocol CharacterListDisplayLogic: AnyObject {
  func displayCharacters(viewModel: CharacterList.FetchCharacters.ViewModel)
  func updateInternetStatus(isConnected: Bool)
  func displayError(message: String)
}

class CharacterListViewController: UIViewController {
  
  var interactor: CharacterListBusinessLogic?
  var router: (NSObjectProtocol & CharacterListRoutingLogic)?
  
  private var characters: [CharacterList.FetchCharacters.ViewModel.Character] = []
  
  private let noInternetLabel: UILabel = {
    let label = UILabel()
    label.text = "No internet connection"
    label.backgroundColor = .systemRed
    label.textColor = .white
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    label.isHidden = true
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let tableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    setupUI()
    interactor?.fetchCharacters(request: CharacterList.FetchCharacters.Request(), onScroll: false)
  }
  
  func updateInternetStatus(isConnected: Bool) {
    UIView.animate(withDuration: 0.3) {
      self.noInternetLabel.alpha = isConnected ? 0 : 1
    }
    self.noInternetLabel.isHidden = isConnected
  }
  
  private func setup() {
    let viewController = self
    let interactor = CharacterListInteractor()
    let presenter = CharacterListPresenter()
    let router = CharacterListRouter()
    
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
  }
  
  private func setupUI() {
    view.backgroundColor = .systemBackground
    title = "Characters"
    
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(CharacterListCell.self, forCellReuseIdentifier: CharacterListCell.identifier)
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 200
    tableView.separatorStyle = .none
    
    view.addSubview(tableView)
    view.addSubview(noInternetLabel)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      noInternetLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      noInternetLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      noInternetLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      noInternetLabel.heightAnchor.constraint(equalToConstant: 30),
      
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
      tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
}

extension CharacterListViewController: CharacterListDisplayLogic {
  func displayCharacters(viewModel: CharacterList.FetchCharacters.ViewModel) {
    if viewModel.isNextPage {
      self.characters.append(contentsOf: viewModel.characters)
    } else {
      self.characters = viewModel.characters
    }
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
  
  func displayError(message: String) {
    let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ок", style: .default))
    present(alert, animated: true)
  }
}

extension CharacterListViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    characters.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterListCell.identifier, for: indexPath) as? CharacterListCell else {
      return UITableViewCell()
    }
    
    let character = characters[indexPath.row]
    cell.configure(with: character)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let character = characters[indexPath.row]
    router?.routeToCharacterDetail(character: character)
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let position = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    let scrollViewHeight = scrollView.frame.size.height
    
    if position > contentHeight - scrollViewHeight * 1.5 {
      interactor?.fetchCharacters(request: .init(), onScroll: true)
    }
  }
  
}
