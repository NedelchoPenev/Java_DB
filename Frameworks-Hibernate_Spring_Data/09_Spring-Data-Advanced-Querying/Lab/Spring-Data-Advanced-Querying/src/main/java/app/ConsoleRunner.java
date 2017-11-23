package app;

import app.model.ingredients.BasicIngredient;
import app.model.shampoos.BasicShampoo;
import app.services.api.IngredientService;
import app.services.api.ShampooService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.util.Scanner;

@Component
public class ConsoleRunner implements CommandLineRunner {

    private ShampooService shampooService;
    private IngredientService ingredientService;

    @Autowired
    public ConsoleRunner(ShampooService shampooService, IngredientService ingredientService) {
        this.shampooService = shampooService;
        this.ingredientService = ingredientService;
    }

    @Override
    public void run(String... strings) throws Exception {
//        selectShampoosBySize();
//        selectShampoosBySizeOrLabel();
//        selectShampoosByPrice();
//        selectIngredientsByName();
//        selectIngredientsByNames();
//        countShampoosByPrice();

//        -----JPQL Querying----
//        selectShampoosByIngredients();
//        selectShampoosByIngredientsCount();
//        selectIngredientNameAndShampooBrandByName();
//        deleteIngredientsByName();
//        updateIngredientsByPrice();
//        updateIngredientsByNames();
    }

    private void updateIngredientsByNames() {
        this.ingredientService.updateAllIngredientsPriceByListOfNames();
    }

    private void updateIngredientsByPrice() {
        this.ingredientService.updateAllIngredientsPrice();
    }

    private void deleteIngredientsByName() {
        Scanner console = new Scanner(System.in);
        System.out.print("Enter Ingredient name to be deleted: ");
        String input = console.nextLine();
        this.ingredientService.deleteByName(input);
    }

    private void selectIngredientNameAndShampooBrandByName() {
        Scanner console = new Scanner(System.in);
        System.out.print("Enter Brand: ");
        String input = console.nextLine();
        System.out.printf("Price of Ingredients: %s%n", this.shampooService.priceOfIngredients(input));
    }

    private void selectShampoosByIngredientsCount() {
        Iterable<BasicShampoo> shampoos = this.shampooService.byIngredientsCount();
        for (BasicShampoo shampoo : shampoos) {
            System.out.println(shampoo.getBrand());
        }
    }

    private void selectShampoosByIngredients() {
        Iterable<BasicShampoo> shampoos = this.shampooService.withIngredients();
        for (BasicShampoo shampoo : shampoos) {
            System.out.println(shampoo.getBrand());
        }
    }

    private void selectIngredientsByNames() {
        Iterable<BasicIngredient> ingredients = this.ingredientService.byCollection();
        for (BasicIngredient ingredient : ingredients) {
            System.out.println(ingredient.getName());
        }
    }

    private void countShampoosByPrice() {
        Scanner console = new Scanner(System.in);
        System.out.print("Enter Price:");
        String input = console.nextLine();
        System.out.println(this.shampooService.countByPrice(new BigDecimal(input)));
    }

    private void selectIngredientsByName() {
        Iterable<BasicIngredient> ingredients = this.ingredientService.startsWith();
        for (BasicIngredient ingredient : ingredients) {
            System.out.println(ingredient.getName());
        }
    }

    private void selectShampoosByPrice() {
        Iterable<BasicShampoo> shampoos =
                this.shampooService.byPriceGreaterBy();
        for (BasicShampoo shampoo : shampoos) {
            System.out.println(shampoo.getBrand() + " " +
                    shampoo.getSize() + " " +
                    shampoo.getPrice() + "lv.");
        }
    }

    private void selectShampoosBySizeOrLabel() {
        Iterable<BasicShampoo> shampoosBySizeOrLabel =
                this.shampooService.bySizeOrLabel();
        for (BasicShampoo shampoo : shampoosBySizeOrLabel) {
            System.out.println(shampoo.getBrand() + " " +
                    shampoo.getSize() + " " +
                    shampoo.getPrice() + "lv.");
        }
    }

    private void selectShampoosBySize() {
        Iterable<BasicShampoo> basicShampoosBySize = this.shampooService.bySize();
        for (BasicShampoo shampoo : basicShampoosBySize) {
            System.out.println(shampoo.getBrand() + " " +
                    shampoo.getSize() + " " +
                    shampoo.getPrice() + "lv.");
        }
    }
}
