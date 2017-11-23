package app.services.api;

import app.model.shampoos.BasicShampoo;

import java.math.BigDecimal;

public interface ShampooService {

    Iterable<BasicShampoo> bySize();

    Iterable<BasicShampoo> bySizeOrLabel();

    Iterable<BasicShampoo> byPriceGreaterBy();

    Long countByPrice(BigDecimal price);

    Iterable<BasicShampoo> withIngredients();

    Iterable<BasicShampoo> byIngredientsCount();

    BigDecimal priceOfIngredients(String brand);
}
