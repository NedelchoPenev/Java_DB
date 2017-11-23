package app.repositories;

import app.model.ingredients.BasicIngredient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Set;

@Repository
public interface IngredientRepository extends JpaRepository<BasicIngredient, Long>{

    Iterable<BasicIngredient> findByNameStartingWith(String letter);

    Iterable<BasicIngredient> findByNameIn(Set<String> ingredient);

    BasicIngredient findByName(String name);

    @Modifying
    @Query("DELETE FROM BasicIngredient AS i WHERE i.name = :name")
    void deleteByName(@Param("name") String name);

    @Modifying
    @Query(value = "UPDATE ingredients AS i\n" +
            "SET i.price = i.price + (i.price * :percent)", nativeQuery = true)
    void updateAllIngredientsPrice(@Param("percent") double percent);

    @Modifying
    @Query(value = "UPDATE ingredients AS i\n" +
            "SET i.price = i.price + (i.price * :percent)" +
            "WHERE i.name IN :names", nativeQuery = true)
    void updateAllIngredientsPriceByListOfNames(@Param("percent") double percent,
                                                @Param("names") Set<String> names);
}
