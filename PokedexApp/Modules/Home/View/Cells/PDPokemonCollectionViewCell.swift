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
        // Shadow container
        itemShadowContainerView.backgroundColor = .clear
        itemShadowContainerView.addRadius(cornerRadius: 12.0)
        itemShadowContainerView.addShadow(radius: 4.0)
        // Container
        itemContainerView.backgroundColor = PDColors.cl_CadetGray
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
        //Images
        pokeballTransparentImageView.image = PDImage.imgPokeballClear.withTintColor(PDColors.cl_White_SemiTransparent)
    }

    func setupCell(with pokemon: Pokemon) {
        loadImage(using: pokemon.imageUrl)
        numberLabel.text = "#\(String(format: "%03d", pokemon.id ?? 0))"
        pokemonNameLabel.text = pokemon.name.capitalized
        itemContainerView.backgroundColor = pokemon.detail?.types?.first?.typeBackgroundColor
    }
    
    private func loadImage(using pokemonImageUrl: String?) {
        guard let imageURL = pokemonImageUrl,
              let url = URL(string: imageURL) else {
            pokemonImageView.backgroundColor = .clear
            pokemonImageView.image = PDImage.imgPokeball
            return
        }
        pokemonImageView.sd_setImage(with: url) { [weak self] (image, error, cacheType, url) in
            guard let self = self else { return }
            if let image = image {
                self.pokemonImageView.image = image
            } else {
                self.pokemonImageView.image = PDImage.imgPokeball
            }
        }
    }
    
    static func getNib() -> UINib {
        return UINib(nibName: PDPokemonCollectionViewCell.identifier, bundle: Bundle(for: PDPokemonCollectionViewCell.self))
    }
    
}
