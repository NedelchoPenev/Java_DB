package app.services.api;

import app.model.ingredients.BasicIngredient;

public interface IngredientService {

    Iterable<BasicIngredient> startsWith();

    Iterable<BasicIngredient> byCollection();

    void deleteByName(String name);

    void updateAllIngredientsPrice();

    void updateAllIngredientsPriceByListOfNames();
}
