package teamsEntities.players;

import ids.PlayerStatisticsIds;

import javax.persistence.*;

@Entity
@Table(name = "player_statistics")
public class PlayerStatistics {
    private PlayerStatisticsIds playerStatisticsIds;
    private int scoredGoals;
    private int assists;
    private int playedMinutes;

    @EmbeddedId
    public PlayerStatisticsIds getPlayerStatisticsIds() {
        return playerStatisticsIds;
    }

    public void setPlayerStatisticsIds(PlayerStatisticsIds playerStatisticsIds) {
        this.playerStatisticsIds = playerStatisticsIds;
    }

    @Column(name = "scored_goals")
    public int getScoredGoals() {
        return scoredGoals;
    }

    public void setScoredGoals(int scoredGoals) {
        this.scoredGoals = scoredGoals;
    }

    @Basic
    public int getAssists() {
        return assists;
    }

    public void setAssists(int assists) {
        this.assists = assists;
    }

    @Column(name = "played_minutes")
    public int getPlayedMinutes() {
        return playedMinutes;
    }

    public void setPlayedMinutes(int playedMinutes) {
        this.playedMinutes = playedMinutes;
    }
}
