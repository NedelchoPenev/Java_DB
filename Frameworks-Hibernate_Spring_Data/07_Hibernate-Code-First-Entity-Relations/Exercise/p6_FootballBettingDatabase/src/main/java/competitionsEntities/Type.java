package competitionsEntities;

import enums.CompetitionType;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "competition_type")
public class Type {
    private Long id;
    private CompetitionType name;
    private Set<Competition> competitions;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Enumerated(EnumType.STRING)
    public CompetitionType getName() {
        return name;
    }

    public void setName(CompetitionType name) {
        this.name = name;
    }

    @OneToMany(mappedBy = "type")
    public Set<Competition> getCompetitions() {
        return competitions;
    }

    public void setCompetitions(Set<Competition> competitions) {
        this.competitions = competitions;
    }
}
