package teamsEntities;

import competitionsEntities.Competition;
import competitionsEntities.Round;
import teamsEntities.players.Player;

import javax.persistence.*;
import java.util.Date;
import java.util.Set;

@Entity
@Table(name = "games")
public class Game {
    private Long id;
    private Team homeTeam;
    private Team awayTeam;
    private int homeGoals;
    private int awayGoals;
    private Date dateOfGame;
    private double homeTeamWinRate;
    private double awayTeamWinRate;
    private double drawRate;
    private Round round;
    private Competition competition;
    private Set<Player> players;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @ManyToOne(optional = false)
    @JoinColumn(name = "home_team")
    public Team getHomeTeam() {
        return homeTeam;
    }

    public void setHomeTeam(Team homeTeam) {
        this.homeTeam = homeTeam;
    }

    @ManyToOne(optional = false)
    @JoinColumn(name = "away_team")
    public Team getAwayTeam() {
        return awayTeam;
    }

    public void setAwayTeam(Team awayTeam) {
        this.awayTeam = awayTeam;
    }

    @Column(name = "home_goals", nullable = false)
    public int getHomeGoals() {
        return homeGoals;
    }

    public void setHomeGoals(int homeGoals) {
        this.homeGoals = homeGoals;
    }

    @Column(name = "away_goals", nullable = false)
    public int getAwayGoals() {
        return awayGoals;
    }

    public void setAwayGoals(int awayGoals) {
        this.awayGoals = awayGoals;
    }

    @Column(name = "date_time", columnDefinition = "DATETIME")
    public Date getDateOfGame() {
        return dateOfGame;
    }

    public void setDateOfGame(Date dateOfGame) {
        this.dateOfGame = dateOfGame;
    }

    @Column(name = "home_team_win_bet_rate", nullable = false)
    public double getHomeTeamWinRate() {
        return homeTeamWinRate;
    }

    public void setHomeTeamWinRate(double homeTeamWinRate) {
        this.homeTeamWinRate = homeTeamWinRate;
    }

    @Column(name = "away_team_win_bet_rate", nullable = false)
    public double getAwayTeamWinRate() {
        return awayTeamWinRate;
    }

    public void setAwayTeamWinRate(double awayTeamWinRate) {
        this.awayTeamWinRate = awayTeamWinRate;
    }

    @Column(name = "draw_bet_rate", nullable = false)
    public double getDrawRate() {
        return drawRate;
    }

    public void setDrawRate(double drawRate) {
        this.drawRate = drawRate;
    }

    @ManyToOne(optional = false)
    @JoinColumn(name = "round")
    public Round getRound() {
        return round;
    }

    public void setRound(Round round) {
        this.round = round;
    }

    @ManyToOne(optional = false)
    @JoinColumn(name = "competition")
    public Competition getCompetition() {
        return competition;
    }

    public void setCompetition(Competition competition) {
        this.competition = competition;
    }

    @ManyToMany(mappedBy = "games", targetEntity = Player.class)
    public Set<Player> getPlayers() {
        return players;
    }

    public void setPlayers(Set<Player> players) {
        this.players = players;
    }
}
