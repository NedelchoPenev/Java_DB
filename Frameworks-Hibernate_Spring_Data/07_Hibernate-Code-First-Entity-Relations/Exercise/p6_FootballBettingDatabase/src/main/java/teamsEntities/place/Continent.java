package teamsEntities.place;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "continents")
public class Continent {
    private Long id;
    private String name;
    private Set<Country> countries;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Column(length = 30, nullable = false)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @ManyToMany(mappedBy = "continent", targetEntity = Country.class)
    public Set<Country> getCountries() {
        return countries;
    }

    public void setCountries(Set<Country> countries) {
        this.countries = countries;
    }
}
