package enums;

public enum Rounds {
    GROUPS("Groups"),
    LEAGUE("League"),
    LAST16("1/8 Final"),
    LAST8("1/4 Final"),
    SEMIFINAL("Semi-Final"),
    FINAL("Final");

    private String round;

    Rounds(String round) {
        this.round = round;
    }

    String getRound() {
        return round;
    }
}
