package app.services.impl;

import app.model.enums.Size;
import app.model.ingredients.BasicIngredient;
import app.model.labels.BasicLabel;
import app.model.shampoos.BasicShampoo;
import app.repositories.IngredientRepository;
import app.repositories.LabelRepository;
import app.repositories.ShampooRepository;
import app.services.api.ShampooService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

@Service
@Transactional
public class ShampooServiceImpl implements ShampooService {

    private ShampooRepository shampooRepository;
    private LabelRepository labelRepository;
    private IngredientRepository ingredientRepository;

    @Autowired
    public ShampooServiceImpl(ShampooRepository shampooRepository, LabelRepository labelRepository,
                              IngredientRepository ingredientRepository) {
        this.shampooRepository = shampooRepository;
        this.labelRepository = labelRepository;
        this.ingredientRepository = ingredientRepository;
    }

    @Override
    public Iterable<BasicShampoo> bySize() {
        return this.shampooRepository.findBySize(Size.MEDIUM);
    }

    @Override
    public Iterable<BasicShampoo> bySizeOrLabel() {
        BasicLabel label = this.labelRepository.findOne(10L);
        return this.shampooRepository.findBySizeOrLabelOrderByPriceAsc(Size.MEDIUM, label);
    }

    @Override
    public Iterable<BasicShampoo> byPriceGreaterBy() {
        return this.shampooRepository.findByPriceGreaterThanOrderByPriceDesc(new BigDecimal(5));
    }

    @Override
    public Long countByPrice(BigDecimal price) {
        return this.shampooRepository.countByPriceLessThan(price);
    }

    @Override
    public Iterable<BasicShampoo> withIngredients() {
        Set<BasicIngredient> ingredients = new HashSet<>();
        ingredients.add(this.ingredientRepository.findByName("Berry"));
        ingredients.add(this.ingredientRepository.findByName("Mineral-Colagen"));
        return this.shampooRepository.withIngredients(ingredients);
    }

    @Override
    public Iterable<BasicShampoo> byIngredientsCount() {
        return this.shampooRepository.byIngredientsCount(2);
    }

    @Override
    public BigDecimal priceOfIngredients(String brand) {
        return this.shampooRepository.priceOfIngredients(brand);
    }
}
