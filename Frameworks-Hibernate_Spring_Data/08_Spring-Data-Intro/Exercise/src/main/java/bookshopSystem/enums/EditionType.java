package bookshopSystem.enums;

public enum EditionType {
    NORMAL(1), PROMO(2), GOLD(3);

    private int value;

    EditionType(int value) {
        this.value = value;
    }

    public static EditionType getValue(int index) {
        for (EditionType type : EditionType.values()) {
            if (type.value == index){
                return type;
            }
        }
        throw new IllegalArgumentException("No such value for index");
    }
}
