package userSystem.models;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "towns")
public class Town {

    private Long id;
    private String name;
    private String country;

    private Set<User> userBornIn;
    private Set<User> userLeavingIn;

    public Town() {
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Column(length = 40, nullable = false)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    @OneToMany(mappedBy = "bornTown")
    public Set<User> getUserBornIn() {
        return userBornIn;
    }

    public void setUserBornIn(Set<User> userBornIn) {
        this.userBornIn = userBornIn;
    }

    @OneToMany(mappedBy = "currentlyLeaving")
    public Set<User> getUserLeavingIn() {
        return userLeavingIn;
    }

    public void setUserLeavingIn(Set<User> userLeavingIn) {
        this.userLeavingIn = userLeavingIn;
    }
}
