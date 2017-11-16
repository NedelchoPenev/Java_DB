package p5_BillsPaymentSystem;

import javax.persistence.*;

@Entity
@Table(name = "billing_details")
@Inheritance(strategy = InheritanceType.JOINED)
public abstract class BasicBillingDetail {

    private long id;
    private String number;
    private User user;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    protected long getId() {
        return id;
    }

    protected void setId(long id) {
        this.id = id;
    }

    @Column(length = 30, nullable = false)
    protected String getNumber() {
        return number;
    }

    protected void setNumber(String number) {
        this.number = number;
    }

    @ManyToOne
    @JoinColumn(name = "user_id", referencedColumnName = "id")
    protected User getUser() {
        return user;
    }

    protected void setUser(User user) {
        this.user = user;
    }
}
