package competitionsEntities;

import enums.Rounds;

import javax.persistence.*;

@Entity
@Table(name = "rounds")
public class Round {
    private Long id;
    private Rounds name;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Enumerated(EnumType.STRING)
    public Rounds getName() {
        return name;
    }

    public void setName(Rounds name) {
        this.name = name;
    }
}
