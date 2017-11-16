package betEntities;

import enums.Prediction;

import javax.persistence.*;

@Entity
@Table(name = "result_prediction")
public class ResultPrediction {
    private Long id;
    private Prediction prediction;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Enumerated
    public Prediction getPrediction() {
        return prediction;
    }

    public void setPrediction(Prediction prediction) {
        this.prediction = prediction;
    }
}
