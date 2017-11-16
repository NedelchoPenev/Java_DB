package betEntities;

import ids.BetGameIds;

import javax.persistence.*;

@Entity
@Table(name = "bet_games")
public class BetGame {
    private BetGameIds ids;
    private ResultPrediction prediction;

    @EmbeddedId
    public BetGameIds getIds() {
        return ids;
    }

    public void setIds(BetGameIds ids) {
        this.ids = ids;
    }

    @ManyToOne
    @JoinColumn(name = "result_prediction")
    public ResultPrediction getPrediction() {
        return prediction;
    }

    public void setPrediction(ResultPrediction prediction) {
        this.prediction = prediction;
    }
}
