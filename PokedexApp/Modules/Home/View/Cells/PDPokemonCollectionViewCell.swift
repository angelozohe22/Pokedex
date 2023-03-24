//
//  PDPokemonCollectionViewCell.swift
//  PokedexApp
//
//  Created by Luis Angel Inga Mendoza on 13/03/23.
//

import UIKit
import PDKit
import SDWebImage

class PDPokemonCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var itemShadowContainerView: UIView!
    @IBOutlet weak var itemContainerView: UIView!
    @IBOutlet weak var pokeballTransparentImageView: UIImageView!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    // MARK: - Properties
    
    static let identifier = "PDPokemonCollectionViewCell"
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }
    
    // MARK: - Functions
    
    private func initView() {
        haveShowViews(show: false)
        // Shadow container
        itemShadowContainerView.backgroundColor = .clear
        itemShadowContainerView.addRadius(cornerRadius: 12.0)
        itemShadowContainerView.addShadow(radius: 4.0)
        // Container
        itemContainerView.addRadius(cornerRadius: 12.0)
        itemContainerView.clipsToBounds = true
        // Labels
        numberLabel.textAlignment = .left
        numberLabel.textColor = PDColors.cl_Black_SemiTransparent
        numberLabel.numberOfLines = 0
        numberLabel.font = PDFonts.productSansBold.withSize(16.0)
        pokemonNameLabel.textAlignment = .left
        pokemonNameLabel.textColor = PDColors.cl_White
        pokemonNameLabel.numberOfLines = 0
        pokemonNameLabel.font = PDFonts.productSansBold.withSize(18.0)
    }

    func setupCell(with pokemon: Pokemon) {
        haveShowViews()
        loadImage(using: pokemon.imageUrl)
        numberLabel.text = "#\(String(format: "%03d", pokemon.id ?? 0))"
        pokemonNameLabel.text = pokemon.name.capitalized
        itemContainerView.backgroundColor = pokemon.detail?.types?.first?.typeBackgroundColor ?? PDColors.cl_CadetGray
        pokeballTransparentImageView.image = PDImage.imgPokeballClear.withTintColor(PDColors.cl_White_SemiTransparent)
    }
    
    private func loadImage(using pokemonImageUrl: String?) {
        pokemonImageView.loadImage(withURL: pokemonImageUrl,
                                   defaultImage: PDImage.imgPokeball)
    }
    
    func haveShowViews(show: Bool = true) {
        numberLabel.isHidden = !show
        pokemonNameLabel.isHidden = !show
        pokemonImageView.isHidden = !show
        pokeballTransparentImageView.isHidden = !show
    }
    
    static func getNib() -> UINib {
        return UINib(nibName: PDPokemonCollectionViewCell.identifier, bundle: Bundle(for: PDPokemonCollectionViewCell.self))
    }
    
}
