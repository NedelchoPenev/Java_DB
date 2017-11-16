package enums;

public enum CompetitionType {
    LOCAL("Local"),
    NATIONAL("National"),
    INTERNATIONAL("International");

    private String type;

    CompetitionType(String type) {
        this.type = type;
    }

    String getType() {
        return type;
    }
}
