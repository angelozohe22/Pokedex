//
//  PDHomeViewController.swift
//  PokedexApp
//
//  Created by Luis Angel Inga Mendoza on 13/03/23.
//

import UIKit
import PDKit

protocol PDHomeViewProtocol: AnyObject {
    
    func showLoading()
    func hideLoading()
    func showProgressIndicator()
    func hideProgressIndicator()
    func showEmpty()
    func showError(errorType: PokemonError)
    func reloadCollectionView()
    
}

final class PDHomeViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var pokemonTitleImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var emptyContainerView: UIView!
    @IBOutlet weak var emptyImageView: UIImageView!
    @IBOutlet weak var emptyDescriptionLabel: UILabel!
    @IBOutlet weak var floatingButtonContainer: UIView!
    @IBOutlet weak var floatingButtonImageView: UIImageView!
    
    // MARK: - Lazy properties
    
    lazy var configurator: PDHomeConfigurator = { return PDHomeConfigurator(from: self) }()
    lazy var presenter: PDHomePresenterProtocol = { return self.configurator.configure() }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        presenter.retrievePokemonList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Functions
    
    private func initView() {
        view.backgroundColor = PDColors.cl_LightGray
        pokemonTitleImageView.image = PDImage.imgPokemonTitle
        configureEmpty()
        configureFloating()
        configureCollectionView()
    }
    
    private func configureEmpty() {
        emptyContainerView.isHidden = true
        emptyContainerView.backgroundColor = .clear
        emptyDescriptionLabel.textAlignment = .center
        emptyDescriptionLabel.textColor = PDColors.cl_Black
        emptyDescriptionLabel.numberOfLines = 0
        emptyDescriptionLabel.font = PDFonts.productSansBold.withSize(14.0)
    }
    
    private func configureFloating() {
        floatingButtonContainer.isHidden = false
        floatingButtonContainer.addRadius(cornerRadius: floatingButtonContainer.frame.height / 2)
        floatingButtonContainer.addShadow(radius: 4.0)
        floatingButtonContainer.backgroundColor = PDColors.cl_Red
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapFloatingButton))
        floatingButtonContainer.addGestureRecognizer(gestureRecognizer)
        floatingButtonImageView.image = UIImage(systemName: "magnifyingglass")?.sd_tintedImage(with: PDColors.cl_White)
    }
    
    private func configureCollectionView() {
        collectionView.isHidden = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        collectionView.showsVerticalScrollIndicator = false
        collectionView.collectionViewLayout = flowLayout
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        collectionView.register(PDPokemonCollectionViewCell.getNib(), forCellWithReuseIdentifier: PDPokemonCollectionViewCell.identifier)
    }
    
    @objc func didTapFloatingButton() {
        presenter.goToSearchPokemon()
    }
    
}

// MARK: - UICollectionViewDataSource

extension PDHomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.pokemonListSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PDPokemonCollectionViewCell.identifier, for: indexPath) as? PDPokemonCollectionViewCell else { return UICollectionViewCell(frame: .zero) }
        cell.setupCell(with: presenter.getPokemon(at: indexPath.row))
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate

extension PDHomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didTapPokemon(with: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            return UIMenu(
                title: "",
                image: nil,
                options: .displayInline,
                children: [
                    UIAction(
                        title: "See detail"
                    ) { _ in
                        self.presenter.didTapPokemon(with: indexPath.row)
                    }
                ]
            )
        }
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PDHomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width/2)-8,
                      height: (collectionView.frame.size.width/2)-8)
    }
    
}

// MARK: - PDHomeViewProtocol

extension PDHomeViewController: PDHomeViewProtocol {
    
    func showLoading() {
        loadingIndicatorView.startAnimating()
        loadingIndicatorView.isHidden = false
    }
    
    func hideLoading() {
        loadingIndicatorView.stopAnimating()
        loadingIndicatorView.isHidden = true
    }
    
    func showProgressIndicator() {
        PDProgressView.shared.showProgressView()
    }
    
    func hideProgressIndicator() {
        PDProgressView.shared.hideProgressView()
    }
    
    func showEmpty() {
        collectionView.isHidden = true
        emptyContainerView.isHidden = false
        emptyImageView.image = PDImage.imgPokeballEmpty
        emptyDescriptionLabel.text = NSLocalizedString("EMPTY_NO_POKEMONS_DESCRIPTION", comment: "")
    }
    
    func showError(errorType: PokemonError) {
        collectionView.isHidden = true
        emptyContainerView.isHidden = false
        let errorImage: UIImage
        let errorDescription: String
        switch errorType {
        case .noConection:
            errorImage = PDImage.imgDisconnect
            errorDescription = NSLocalizedString("ERROR_NO_CONNECTION_DESCRIPTION", comment: "")
        case .noData:
            errorImage = PDImage.imgPokeballEmpty
            errorDescription = NSLocalizedString("ERROR_NO_DATA_DESCRIPTION", comment: "")
        case .unexpectedError:
            errorImage = PDImage.imgPokeballEmpty
            errorDescription = NSLocalizedString("ERROR_UNEXPECTED_DESCRIPTION", comment: "")
        case .unauthorized:
            errorImage = PDImage.imgPokeballEmpty
            errorDescription = NSLocalizedString("ERROR_UNAUTHORIZED_DESCRIPTION", comment: "")
        default:
            errorImage = PDImage.imgPokeballEmpty
            errorDescription = NSLocalizedString("ERROR_NO_DATA_DESCRIPTION", comment: "")
        }
        emptyImageView.image = errorImage
        emptyDescriptionLabel.text = errorDescription
    }
    
    func reloadCollectionView() {
        collectionView.isHidden = false
        collectionView.reloadData()
    }
    
}

// MARK: - StoryboardInstantiable

extension PDHomeViewController: StoryboardInstantiable {
    
    static var storyboardName: String { "Home" }
    
}
