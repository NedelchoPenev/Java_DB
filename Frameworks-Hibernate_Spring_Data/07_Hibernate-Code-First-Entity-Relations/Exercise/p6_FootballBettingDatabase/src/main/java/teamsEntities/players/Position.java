package teamsEntities.players;

import enums.PositionDesc;
import enums.PositionId;

import javax.persistence.*;

@Entity
@Table(name = "positions")
public class Position {
    private PositionId id;
    private PositionDesc description;

    @Id
    @Enumerated(EnumType.STRING)
    public PositionId getId() {
        return id;
    }

    public void setId(PositionId id) {
        this.id = id;
    }

    @Enumerated(EnumType.STRING)
    public PositionDesc getDescription() {
        return description;
    }

    public void setDescription(PositionDesc description) {
        this.description = description;
    }
}
