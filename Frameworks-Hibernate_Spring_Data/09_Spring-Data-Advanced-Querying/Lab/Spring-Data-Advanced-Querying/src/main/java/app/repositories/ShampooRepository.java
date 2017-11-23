package app.repositories;

import app.model.enums.Size;
import app.model.ingredients.BasicIngredient;
import app.model.labels.BasicLabel;
import app.model.shampoos.BasicShampoo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.Set;

@Repository
public interface ShampooRepository extends JpaRepository<BasicShampoo, Long>{

    Iterable<BasicShampoo> findBySize(Size size);

    Iterable<BasicShampoo> findBySizeOrLabelOrderByPriceAsc(Size size, BasicLabel label);

    Iterable<BasicShampoo> findByPriceGreaterThanOrderByPriceDesc(BigDecimal price);

    Long countByPriceLessThan(BigDecimal price);

    @Query("SELECT i.shampoos FROM BasicIngredient AS i WHERE i IN :collection")
    Iterable<BasicShampoo> withIngredients(@Param("collection") Set<BasicIngredient> ingredients);

    @Query("SELECT s FROM BasicShampoo AS s WHERE s.ingredients.size < :count")
    Iterable<BasicShampoo> byIngredientsCount(@Param("count") int number);

    @Query(value = "SELECT Sum(i.price) FROM shampoos AS s\n" +
            "INNER JOIN shampoos_ingredients AS si ON s.id = si.shampoo_id\n" +
            "INNER JOIN ingredients AS i ON si.ingredient_id = i.id\n" +
            "WHERE s.brand = :brand GROUP BY s.brand", nativeQuery = true)
    BigDecimal priceOfIngredients(@Param("brand") String brand);
}
