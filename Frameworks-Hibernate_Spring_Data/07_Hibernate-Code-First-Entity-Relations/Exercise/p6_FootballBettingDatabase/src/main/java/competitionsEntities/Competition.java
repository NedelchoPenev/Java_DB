package competitionsEntities;

import javax.persistence.*;

@Entity
@Table(name = "competitions")
public class Competition {
    private Long id;
    private String name;
    private Type type;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Basic
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @ManyToOne
    @JoinColumn(name = "competition_type")
    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }
}
