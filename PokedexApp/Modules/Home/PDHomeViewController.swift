//
//  PDHomeViewController.swift
//  PokedexApp
//
//  Created by Luis Angel Inga Mendoza on 13/03/23.
//

import UIKit
import PDKit
import SkeletonView

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
    @IBOutlet weak var emptyContainerView: UIView!
    @IBOutlet weak var emptyImageView: UIImageView!
    @IBOutlet weak var emptyDescriptionLabel: UILabel!
    @IBOutlet weak var emptyButton: UIButton!
    @IBOutlet weak var floatingButtonContainer: UIView!
    @IBOutlet weak var floatingButtonImageView: UIImageView!
    
    // MARK: - Lazy properties
    
    lazy var configurator: PDHomeConfigurator = { return PDHomeConfigurator(from: self) }()
    lazy var presenter: PDHomePresenterProtocol = { return self.configurator.configure() }()
    
    private lazy var refreshControl: UIRefreshControl = {
        return UIRefreshControl()
    }()
    
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
    
    // MARK: - IBActions
    
    @IBAction func emptyButtonAction(_ sender: Any) {
        presenter.retrievePokemonList()
    }
    
    // MARK: - Functions
    
    private func initView() {
        view.backgroundColor = PDColors.cl_LightGray
        pokemonTitleImageView.image = PDImage.imgPokemonTitle
        configureEmpty()
        configureFloating()
        configureCollectionView()
        configureRefreshControl()
    }
    
    private func configureEmpty() {
        emptyContainerView.isHidden = true
        emptyContainerView.backgroundColor = .clear
        emptyDescriptionLabel.textAlignment = .center
        emptyDescriptionLabel.textColor = PDColors.cl_Black
        emptyDescriptionLabel.numberOfLines = 0
        emptyDescriptionLabel.font = PDFonts.productSansBold.withSize(14.0)
        emptyButton.setTitle("Try again", for: .normal)
        emptyButton.setActiveStyle()
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
    
    private func configureRefreshControl() {
        refreshControl.addTarget(self, action: #selector(reloadPokemons), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    @objc func didTapFloatingButton() {
        presenter.goToSearchPokemon()
    }
    
    @objc func reloadPokemons() {
        presenter.retrievePokemonList()
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
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width/2)-12,
                      height: (collectionView.frame.size.width/2)-12)
    }
    
}

// MARK: - PDHomeViewProtocol

extension PDHomeViewController: PDHomeViewProtocol {
    
    func showLoading() {
        collectionView.isHidden = false
        emptyContainerView.isHidden = true
        floatingButtonContainer.isHidden = true
        self.view.showAnimatedGradientSkeleton()
    }
    
    func hideLoading() {
        collectionView.refreshControl?.endRefreshing()
        floatingButtonContainer.isHidden = false
        view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.3))
    }
    
    func showProgressIndicator() {
        PDProgressView.shared.showProgressView(in: self.view)
    }
    
    func hideProgressIndicator() {
        PDProgressView.shared.hideProgressView()
    }
    
    func showEmpty() {
        floatingButtonContainer.isHidden = true
        collectionView.isHidden = true
        emptyContainerView.isHidden = false
        emptyImageView.image = PDImage.imgPokeballEmpty
        emptyDescriptionLabel.text = NSLocalizedString("EMPTY_NO_POKEMONS_DESCRIPTION", comment: "")
    }
    
    func showError(errorType: PokemonError) {
        floatingButtonContainer.isHidden = true
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

extension PDHomeViewController: SkeletonCollectionViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return PDPokemonCollectionViewCell.identifier
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, skeletonCellForItemAt indexPath: IndexPath) -> UICollectionViewCell? {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PDPokemonCollectionViewCell.identifier, for: indexPath) as? PDPokemonCollectionViewCell else { return UICollectionViewCell(frame: .zero) }
        cell.haveShowViews(show: false)
        return cell
    }
    
}


// MARK: - StoryboardInstantiable

extension PDHomeViewController: StoryboardInstantiable {
    
    static var storyboardName: String { "Home" }
    
}
