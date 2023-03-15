//
//  PDSearchPokemonViewController.swift
//  PokedexApp
//
//  Created by Luis Angel Inga Mendoza on 15/03/23.
//

import UIKit
import PDKit

protocol PDSearchPokemonView: AnyObject {
    
    func showDefaultInformation()
    func showLoading()
    func hideLoading()
    func showProgressIndicator()
    func hideProgressIndicator()
    func setPokemonInformation(pokemon: Pokemon)
    func showError(error: PokemonError)
    
}

final class PDSearchPokemonViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var containerBackButtonView: UIView!
    @IBOutlet weak var backButtonImageView: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var containerInformationView: UIView!
    @IBOutlet weak var containerEmptyStackView: UIStackView!
    @IBOutlet weak var emptyImageView: UIImageView!
    @IBOutlet weak var emptyDescriptionLabel: UILabel!
    @IBOutlet weak var containerPokemonView: UIView!
    @IBOutlet weak var pokemonInfoImageView: UIImageView!
    @IBOutlet weak var pokemonNumberLabel: UILabel!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    // MARK: - Lazy properties
    
    lazy var configurator: PDSearchPokemonConfigurator = { return PDSearchPokemonConfigurator(from: self) }()
    lazy var presenter: PDSearchPokemonPresenterProtocol = { return self.configurator.configure() }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Functions
    
    private func initView() {
        self.view.backgroundColor = PDColors.cl_LightGray
        //Configures
        configureBackButton()
        configureSearchBar()
        configureEmpty()
        configureInformation()
        defaultInformation()
    }
    
    private func configureBackButton() {
        containerBackButtonView.backgroundColor = PDColors.cl_Black
        containerBackButtonView.addRadius(cornerRadius: containerBackButtonView.frame.height / 2)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapBackButton))
        containerBackButtonView.addGestureRecognizer(gestureRecognizer)
        backButtonImageView.image = PDIcon.icArrowLeft.withTintColor(PDColors.cl_White)
    }
    
    private func configureSearchBar() {
        searchBar.placeholder = "Search pokémon"
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        searchBar.backgroundColor = PDColors.cl_LightGray
    }
    
    private func configureEmpty() {
        containerEmptyStackView.isHidden = true
        emptyDescriptionLabel.textAlignment = .center
        emptyDescriptionLabel.textColor = PDColors.cl_Black
        emptyDescriptionLabel.numberOfLines = 0
        emptyDescriptionLabel.font = PDFonts.productSansBold.withSize(14.0)
    }
    
    private func configureInformation() {
        containerInformationView.isHidden = true
        containerInformationView.backgroundColor = .clear
        // Pokemon Info
        containerPokemonView.isHidden = true
        containerPokemonView.backgroundColor = PDColors.cl_White
        containerPokemonView.addRadius(cornerRadius: 16.0)
        containerPokemonView.addShadow(radius: 8.0)
        pokemonNumberLabel.textAlignment = .center
        pokemonNumberLabel.textColor = PDColors.cl_Black_SemiTransparent
        pokemonNumberLabel.numberOfLines = 0
        pokemonNumberLabel.font = PDFonts.productSansBold.withSize(20.0)
        pokemonNameLabel.textAlignment = .center
        pokemonNameLabel.textColor = PDColors.cl_White
        pokemonNameLabel.numberOfLines = 0
        pokemonNameLabel.font = PDFonts.productSansBold.withSize(20.0)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapPokemonInfo))
        containerPokemonView.addGestureRecognizer(gestureRecognizer)
        
    }
    
    private func defaultInformation() {
        containerInformationView.isHidden = false
        containerPokemonView.isHidden = false
        containerEmptyStackView.isHidden = true
        containerPokemonView.backgroundColor = PDColors.cl_Red
        pokemonInfoImageView.image = PDImage.imgPokemonNoVisible
        pokemonNumberLabel.text = "?"
        pokemonNameLabel.text = "Who is that Pokemon?"
    }
    
    @objc func didTapBackButton() {
        presenter.goToParent()
    }
    
    @objc func didTapPokemonInfo() {
        presenter.goToPokemonDetail()
    }
    
}

// MARK: - UISearchBarDelegate

extension PDSearchPokemonViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        presenter.searchPokemon(by: text.lowercased())
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            presenter.searchPokemon(by: searchText)
        }
    }
    
}

// MARK: - PDSearchPokemonView

extension PDSearchPokemonViewController: PDSearchPokemonView {
    
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
    
    func showDefaultInformation() {
        defaultInformation()
    }
    
    func setPokemonInformation(pokemon: Pokemon) {
        containerInformationView.isHidden = false
        containerPokemonView.isHidden = false
        containerEmptyStackView.isHidden = true
        containerPokemonView.backgroundColor = pokemon.detail?.types?.first?.typeBackgroundColor ?? PDColors.cl_CadetGray
        if let imageURL = pokemon.imageUrl,
           let url = URL(string: imageURL) {
            pokemonInfoImageView.sd_setImage(with: url) { [weak self] (image, error, cacheType, url) in
                guard let self = self else { return }
                self.pokemonInfoImageView.backgroundColor = .clear
                if let image = image {
                    self.pokemonInfoImageView.image = image
                } else {
                    self.pokemonInfoImageView.image = PDImage.imgPokeball
                }
            }
        } else {
            self.pokemonInfoImageView.backgroundColor = .clear
            self.pokemonInfoImageView.image = PDImage.imgPokeball
        }
        pokemonNumberLabel.text = "#\(String(format: "%03d", pokemon.id ?? 0))"
        pokemonNameLabel.text = pokemon.name.firstCapitalize()
    }
    
    func showError(error: PokemonError) {
        containerInformationView.isHidden = false
        containerPokemonView.isHidden = true
        containerEmptyStackView.isHidden = false
        let errorImage: UIImage
        let errorDescription: String
        switch error {
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
    
}

// MARK: - StoryboardInstantiable

extension PDSearchPokemonViewController: StoryboardInstantiable {
    
    static var storyboardName: String { "SearchPokemon" }
    
}
