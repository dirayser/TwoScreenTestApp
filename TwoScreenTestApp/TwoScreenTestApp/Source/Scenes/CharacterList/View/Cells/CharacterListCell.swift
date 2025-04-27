//
//  CharacterListCell.swift
//  TwoScreenTestApp
//
//  Created by Dmitriy Dmitriyev on 27.04.2025.
//

import UIKit
import SDWebImage

final class CharacterListCell: UITableViewCell {
  
  static var identifier: String {
    return String(describing: self)
  }
  
  private let characterImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 8
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 18)
    label.numberOfLines = 1
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 14)
    label.numberOfLines = 2
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let moreButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("More", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
    button.translatesAutoresizingMaskIntoConstraints = false
    
    return button
  }()
  
  private var isExpanded: Bool = false
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
    setupConstraints()
    moreButton.addTarget(self, action: #selector(didTapMore), for: .touchUpInside)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    descriptionLabel.preferredMaxLayoutWidth = descriptionLabel.frame.width
  }
  
  private func setupViews() {
    contentView.addSubview(characterImageView)
    contentView.addSubview(nameLabel)
    contentView.addSubview(descriptionLabel)
    contentView.addSubview(moreButton)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      characterImageView.widthAnchor.constraint(equalToConstant: 100),
      characterImageView.heightAnchor.constraint(equalToConstant: 100),
      
      nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      nameLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 12),
      nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      
      descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
      descriptionLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 12),
      descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      
      moreButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4),
      moreButton.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 12),
      moreButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
    ])
  }
  
  func configure(with viewModel: CharacterList.FetchCharacters.ViewModel.Character) {
    nameLabel.text = viewModel.name
    descriptionLabel.text = viewModel.description
    characterImageView.sd_setImage(with: URL(string: viewModel.imageURL), placeholderImage: UIImage(systemName: "photo"))
    descriptionLabel.numberOfLines = isExpanded ? 0 : 2
    moreButton.setTitle(isExpanded ? "Less" : "More", for: .normal)
  }
  
  @objc private func didTapMore() {
    isExpanded.toggle()
    descriptionLabel.numberOfLines = isExpanded ? 0 : 2
    moreButton.setTitle(isExpanded ? "Less" : "More", for: .normal)
    
    UIView.animate(withDuration: 0.3) {
      self.superview?.layoutIfNeeded()
    }
    
    if let tableView = self.superview as? UITableView {
      tableView.beginUpdates()
      tableView.endUpdates()
    }
  }
}
