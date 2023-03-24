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
        containerPokemonImageView.addBottomCorner(cornerRadius: 24.0)
        // Labels
        pokemonNameLabel.textAlignment = .left
        pokemonNameLabel.textColor = PDColors.cl_Black
        pokemonNameLabel.numberOfLines = 0
        pokemonNameLabel.font = PDFonts.productSansBold.withSize(18.0)
        pokemonDescriptionLabel.textAlignment = .left
        pokemonDescriptionLabel.textColor = PDColors.cl_Black
        pokemonDescriptionLabel.numberOfLines = 0
        pokemonDescriptionLabel.font = PDFonts.productSansRegular.withSize(16.0)
        primaryTypeLabel.textAlignment = .center
        primaryTypeLabel.textColor = PDColors.cl_White
        primaryTypeLabel.numberOfLines = 0
        primaryTypeLabel.font = PDFonts.productSansBold.withSize(16.0)
        secondaryTypeLabel.textAlignment = .center
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
        setImage(imageUrl: pokemon.imageUrl)
        setDescription(name: pokemon.name, description: pokemon.description)
        setTypes(types: pokemon.detail?.types)
        setAbilities(abilities: pokemon.detail?.abilities)
        setStats(stats: pokemon.detail?.stats)
        setHabitat(habitat: pokemon.habitatName)
        setEvolution(evolvesFrom: pokemon.evolvesFrom)
    }
    
    private func setImage(imageUrl: String?) {
        pokemonImageView.loadImage(withURL: imageUrl,
                                   defaultImage: PDImage.imgPokeball)
    }
    
    private func setDescription(name: String, description: String?) {
        pokemonNameLabel.text = name.capitalized
        guard let description = description else {
            pokemonDescriptionLabel.text = ""
            return
        }
        let deecriptionFormatted = description.removeAllNewLines().capitalizeAfterDot()
        pokemonDescriptionLabel.text = deecriptionFormatted
    }
    
    private func setTypes(types: [PokemonDetailType]?) {
        guard let types = types else {
            containerPrimaryTypeView.isHidden = true
            containerSecondaryTypeView.isHidden = true
            return
        }
        containerPrimaryTypeView.backgroundColor = types.first?.typeColor
        primaryTypeImageView.image = types.first?.typeIcon
        primaryTypeLabel.text = types.first?.name.capitalized
        if types.count > 1 {
            containerSecondaryTypeView.isHidden = false
            containerSecondaryTypeView.backgroundColor = types.last?.typeColor
            secondaryTypeImageView.image = types.last?.typeIcon
            secondaryTypeLabel.text = types.last?.name.capitalized
        }
    }
    
    private func setAbilities(abilities: [PokemonDetailAbility]?) {
        guard let abilities = abilities else {
            pokemonAbilitiesLabel.text = ""
            return
        }
        let pokemonAbilities = abilities.enumerated().map { (index, ability) -> String in
            let name = ability.name.replacingOccurrences(of: "-", with: " ").firstCapitalize()
            return "\(name)\(index < abilities.count - 1 ? ", " : "")"
        }.joined()
        pokemonAbilitiesLabel.text = pokemonAbilities
    }
    
    private func setStats(stats: [PokemonDetailStat]?) {
        guard let stats = stats else {
            pokemonStatsLabel.text = ""
            return
        }
        let statDescription: NSMutableAttributedString = NSMutableAttributedString()
        let statDescriptionParagraphStyle = NSMutableParagraphStyle()
        statDescriptionParagraphStyle.alignment = .left
        stats.enumerated().forEach { (index, stat) in
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
                    NSAttributedString.Key.font: PDFonts.productSansRegular.withSize(12),
                    NSAttributedString.Key.foregroundColor: PDColors.cl_Black
                ])
            statDescription.append(statEffort)
            if index < stats.count - 1 {
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
    }
    
    private func setHabitat(habitat: String?) {
        pokemonHabitatLabel.text = (habitat ?? "").firstCapitalize()
    }
    
    private func setEvolution(evolvesFrom: PokemonEvolvesFrom?) {
        if let pokemonEvolves = evolvesFrom {
            pokemonEvolutionImageView.isHidden = false
            pokemonEvolutionImageView.loadImage(withURL: pokemonEvolves.imageUrl,
                                                defaultImage: PDImage.imgPokeball)
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
