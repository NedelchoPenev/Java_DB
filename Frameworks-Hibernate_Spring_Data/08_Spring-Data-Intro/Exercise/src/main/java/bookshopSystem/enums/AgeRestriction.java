package bookshopSystem.enums;

public enum AgeRestriction {
    MINOR(0), TEEN(1), ADULT(2);

    private int value;

    AgeRestriction(int val) {
        this.value = val;
    }

    public static AgeRestriction getValue(int index) {
        for (AgeRestriction AgeRestriction : AgeRestriction.values()) {
            if (AgeRestriction.value == index) {
                return AgeRestriction;
            }
        }
        throw new IllegalArgumentException("No such value for index");
    }
}
