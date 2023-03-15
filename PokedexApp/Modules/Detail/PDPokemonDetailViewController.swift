//
//  PDPokemonDetailViewController.swift
//  PokedexApp
//
//  Created by Luis Angel Inga Mendoza on 14/03/23.
//

import UIKit
import PDKit

protocol PDPokemonDetailView: AnyObject {
    
    func setValue(pokemon: Pokemon)
    
}

final class PDPokemonDetailViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var containerPokemonImageView: UIView!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var containerBackButtonView: UIView!
    @IBOutlet weak var backButtonImageView: UIImageView!
    @IBOutlet weak var containerPokemonDetails: UIView!
    @IBOutlet weak var containerPrimaryTypeView: UIView!
    @IBOutlet weak var primaryTypeImageView: UIImageView!
    @IBOutlet weak var primaryTypeLabel: UILabel!
    @IBOutlet weak var containerSecondaryTypeView: UIView!
    @IBOutlet weak var secondaryTypeImageView: UIImageView!
    @IBOutlet weak var secondaryTypeLabel: UILabel!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonDescriptionLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesTitleLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    @IBOutlet weak var pokemonStatsTitleLabel: UILabel!
    @IBOutlet weak var pokemonStatsLabel: UILabel!
    @IBOutlet weak var pokemonHabitatTitleLabel: UILabel!
    @IBOutlet weak var pokemonHabitatLabel: UILabel!
    @IBOutlet weak var pokemonEvolutionTitleLabel: UILabel!
    @IBOutlet weak var pokemonEvolutionStackContainer: UIStackView!
    @IBOutlet weak var pokemonEvolutionImageView: UIImageView!
    @IBOutlet weak var pokemonEvolutionLabel: UILabel!
    
    // MARK: - Lazy properties
    
    lazy var configurator: PDPokemonDetailConfigurator = { return PDPokemonDetailConfigurator(from: self) }()
    lazy var presenter: PDPokemonDetailPresenterProtocol = { return self.configurator.configure() }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        presenter.retrievePokemonData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Functions
    
    func initView() {
        // Containers
        containerPrimaryTypeView.addRadius(cornerRadius: containerPrimaryTypeView.frame.height / 2)
        containerSecondaryTypeView.isHidden = true
        containerSecondaryTypeView.addRadius(cornerRadius: containerSecondaryTypeView.frame.height / 2)
        [contentContainerView, containerPokemonDetails, contentView].forEach { view in
            view?.backgroundColor = PDColors.cl_LightGray
        }
        // Labels
        pokemonNameLabel.textAlignment = .left
        pokemonNameLabel.textColor = PDColors.cl_Black
        pokemonNameLabel.numberOfLines = 0
        pokemonNameLabel.font = PDFonts.productSansBold.withSize(18.0)
        pokemonDescriptionLabel.textAlignment = .left
        pokemonDescriptionLabel.textColor = PDColors.cl_Black
        pokemonDescriptionLabel.numberOfLines = 0
        pokemonDescriptionLabel.font = PDFonts.productSansRegular.withSize(16.0)
        primaryTypeLabel.textAlignment = .left
        primaryTypeLabel.textColor = PDColors.cl_White
        primaryTypeLabel.numberOfLines = 0
        primaryTypeLabel.font = PDFonts.productSansBold.withSize(16.0)
        secondaryTypeLabel.textAlignment = .left
        secondaryTypeLabel.textColor = PDColors.cl_White
        secondaryTypeLabel.numberOfLines = 0
        secondaryTypeLabel.font = PDFonts.productSansBold.withSize(16.0)
        pokemonAbilitiesTitleLabel.textAlignment = .left
        pokemonAbilitiesTitleLabel.textColor = PDColors.cl_Black
        pokemonAbilitiesTitleLabel.numberOfLines = 0
        pokemonAbilitiesTitleLabel.font = PDFonts.productSansBold.withSize(18.0)
        pokemonAbilitiesTitleLabel.text = "Abilities"
        pokemonAbilitiesLabel.textAlignment = .left
        pokemonAbilitiesLabel.textColor = PDColors.cl_Black
        pokemonAbilitiesLabel.numberOfLines = 0
        pokemonAbilitiesLabel.font = PDFonts.productSansRegular.withSize(16.0)
        pokemonStatsTitleLabel.textAlignment = .left
        pokemonStatsTitleLabel.textColor = PDColors.cl_Black
        pokemonStatsTitleLabel.numberOfLines = 0
        pokemonStatsTitleLabel.font = PDFonts.productSansBold.withSize(18.0)
        pokemonStatsTitleLabel.text = "Stats"
        pokemonStatsLabel.textAlignment = .center
        pokemonStatsLabel.textColor = PDColors.cl_Black
        pokemonStatsLabel.numberOfLines = 0
        pokemonStatsLabel.font = PDFonts.productSansRegular.withSize(16.0)
        pokemonHabitatTitleLabel.textAlignment = .left
        pokemonHabitatTitleLabel.textColor = PDColors.cl_Black
        pokemonHabitatTitleLabel.numberOfLines = 0
        pokemonHabitatTitleLabel.font = PDFonts.productSansBold.withSize(18.0)
        pokemonHabitatTitleLabel.text = "Habitat"
        pokemonHabitatLabel.textAlignment = .left
        pokemonHabitatLabel.textColor = PDColors.cl_Black
        pokemonHabitatLabel.numberOfLines = 0
        pokemonHabitatLabel.font = PDFonts.productSansRegular.withSize(16.0)
        pokemonEvolutionTitleLabel.textAlignment = .left
        pokemonEvolutionTitleLabel.textColor = PDColors.cl_Black
        pokemonEvolutionTitleLabel.numberOfLines = 0
        pokemonEvolutionTitleLabel.font = PDFonts.productSansBold.withSize(18.0)
        pokemonEvolutionTitleLabel.text = "Evolution from"
        pokemonEvolutionLabel.textAlignment = .left
        pokemonEvolutionLabel.textColor = PDColors.cl_Black
        pokemonEvolutionLabel.numberOfLines = 0
        pokemonEvolutionLabel.font = PDFonts.productSansRegular.withSize(16.0)
        // Images
        pokemonEvolutionImageView.isHidden = true
        // Configures
        configureBackButton()
    }
    
    private func configureBackButton() {
        containerBackButtonView.backgroundColor = PDColors.cl_Black
        containerBackButtonView.addRadius(cornerRadius: containerBackButtonView.frame.height / 2)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapBackButton))
        containerBackButtonView.addGestureRecognizer(gestureRecognizer)
        backButtonImageView.image = PDIcon.icArrowLeft.withTintColor(PDColors.cl_White)
    }
    
    @objc func didTapBackButton() {
        presenter.goToParent()
    }

}

// MARK: - PDPokemonDetailView

extension PDPokemonDetailViewController: PDPokemonDetailView {
    
    func setValue(pokemon: Pokemon) {
        // Container background
        [scrollView,
         containerPokemonImageView].forEach { view in
            view?.backgroundColor = pokemon.detail?.types?.first?.typeBackgroundColor
        }
        containerPokemonImageView.addBottomCorner(cornerRadius: 24.0)
        // Pokemon image
        if let imageURL = pokemon.imageUrl,
           let url = URL(string: imageURL) {
            pokemonImageView.sd_setImage(with: url) { [weak self] (image, error, cacheType, url) in
                guard let self = self else { return }
                self.pokemonImageView.backgroundColor = .clear
                if let image = image {
                    self.pokemonImageView.image = image
                } else {
                    self.pokemonImageView.image = PDImage.imgPokeball
                }
            }
        } else {
            self.pokemonImageView.backgroundColor = .clear
            self.pokemonImageView.image = PDImage.imgPokeball
        }
        // Pokemon description
        pokemonNameLabel.text = pokemon.name.capitalized
        pokemonDescriptionLabel.text = pokemon.description ?? ""
        // Types
        containerPrimaryTypeView.backgroundColor = pokemon.detail?.types?.first?.typeColor
        primaryTypeImageView.image = pokemon.detail?.types?.first?.typeIcon
        primaryTypeLabel.text = pokemon.detail?.types?.first?.name.capitalized
        if let types = pokemon.detail?.types, types.count > 1 {
            containerSecondaryTypeView.isHidden = false
            containerSecondaryTypeView.backgroundColor = types.last?.typeColor
            secondaryTypeImageView.image = types.last?.typeIcon
            secondaryTypeLabel.text = types.last?.name.capitalized
        }
        // Abilities
        var abilities: String = ""
        pokemon.detail?.abilities?.enumerated().forEach({ (index, ability) in
            abilities += ability.name.replacingOccurrences(of: "-", with: " ").firstCapitalize()
            if (index+1) < pokemon.detail?.abilities?.count ?? 0 {
                abilities += ", "
            }
        })
        pokemonAbilitiesLabel.text = abilities
        // Stats
        let statDescription: NSMutableAttributedString = NSMutableAttributedString()
        let statDescriptionParagraphStyle = NSMutableParagraphStyle()
        statDescriptionParagraphStyle.alignment = .left
        pokemon.detail?.stats?.enumerated().forEach { (index, stat) in
            let nameStat = NSAttributedString(
                string: "\(stat.statNameFormatted):  ", attributes: [
                    NSAttributedString.Key.font: PDFonts.productSansBold.withSize(12),
                    NSAttributedString.Key.foregroundColor: PDColors.cl_Black
                ])
            statDescription.append(nameStat)
            let statValue = NSAttributedString(
                string: "\(stat.baseStat) /", attributes: [
                    NSAttributedString.Key.font: PDFonts.productSansRegular.withSize(12),
                    NSAttributedString.Key.foregroundColor: PDColors.cl_Black
                ])
            statDescription.append(statValue)
            let statEffort = NSAttributedString(
                string: " \(stat.effort)", attributes: [
                    NSAttributedString.Key.font: PDFonts.productSansRegular.withSize(14),
                    NSAttributedString.Key.foregroundColor: PDColors.cl_Black
                ])
            statDescription.append(statEffort)
            if (index+1) < pokemon.detail?.stats?.count ?? 0 {
                let statSpace = NSAttributedString(
                    string: "    ", attributes: [:])
                statDescription.append(statSpace)
            }
            if index == 2 {
                let statLineBreak = NSAttributedString(
                    string: "\n\n", attributes: [:])
                statDescription.append(statLineBreak)
            }
        }
        pokemonStatsLabel.attributedText = statDescription
        // Habitat
        pokemonHabitatLabel.text = pokemon.habitatName?.firstCapitalize()
        // Evolutions
        if let pokemonEvolves = pokemon.evolvesFrom {
            pokemonEvolutionImageView.isHidden = false
            if let url = URL(string: pokemonEvolves.imageUrl) {
                pokemonEvolutionImageView.sd_setImage(with: url) { [weak self] (image, error, cacheType, url) in
                    guard let self = self else { return }
                    self.pokemonEvolutionImageView.backgroundColor = .clear
                    if let image = image {
                        self.pokemonEvolutionImageView.image = image
                    } else {
                        self.pokemonEvolutionImageView.image = PDImage.imgPokeball
                    }
                }
            } else {
                self.pokemonEvolutionImageView.backgroundColor = .clear
                self.pokemonEvolutionImageView.image = PDImage.imgPokeball
            }
            pokemonEvolutionLabel.text = pokemonEvolves.name.firstCapitalize()
        } else {
            pokemonEvolutionImageView.isHidden = true
            pokemonEvolutionLabel.text = "-"
        }
    }
    
}

// MARK: - StoryboardInstantiable

extension PDPokemonDetailViewController: StoryboardInstantiable {
    
    static var storyboardName: String { "PokemonDetail" }
    
}
