package app.services.impl;

import app.model.ingredients.BasicIngredient;
import app.repositories.IngredientRepository;
import app.services.api.IngredientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.Set;

@Service
@Transactional
public class IngredientServiceImpl implements IngredientService {

    private IngredientRepository ingredientRepository;

    @Autowired
    public IngredientServiceImpl(IngredientRepository ingredientRepository) {
        this.ingredientRepository = ingredientRepository;
    }

    @Override
    public Iterable<BasicIngredient> startsWith() {
        return this.ingredientRepository.findByNameStartingWith("M");
    }

    @Override
    public Iterable<BasicIngredient> byCollection() {
        Set<String> names = new HashSet<>();
        names.add("Lavender");
        names.add("Herbs");
        names.add("Apple");
        return this.ingredientRepository.findByNameIn(names);
    }

    @Override
    public void deleteByName(String name) {
        this.ingredientRepository.deleteByName(name);
    }

    @Override
    public void updateAllIngredientsPrice() {
        this.ingredientRepository.updateAllIngredientsPrice(0.1);
    }

    @Override
    public void updateAllIngredientsPriceByListOfNames() {
        Set<String> names = new HashSet<>();
        names.add("Nettle");
        names.add("Macadamia Oil");
        names.add("Aloe Vera");
        this.ingredientRepository.updateAllIngredientsPriceByListOfNames(0.1, names);
    }
}
