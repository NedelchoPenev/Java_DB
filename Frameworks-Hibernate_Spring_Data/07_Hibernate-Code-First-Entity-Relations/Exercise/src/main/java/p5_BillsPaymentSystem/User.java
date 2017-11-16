package p5_BillsPaymentSystem;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "users")
public class User {

    private long id;
    private String firstName;
    private String lastName;
    private String email;
    private String password;
    private Set<BasicBillingDetail> basicBillingDetail;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Column(name = "first_name", length = 30, nullable = false)
    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    @Column(name = "last_name", length = 30, nullable = false)
    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    @Basic
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Column(nullable = false)
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @OneToMany(mappedBy = "user", targetEntity = BasicBillingDetail.class)
    public Set<BasicBillingDetail> getBasicBillingDetail() {
        return basicBillingDetail;
    }

    public void setBasicBillingDetail(Set<BasicBillingDetail> basicBillingDetail) {
        this.basicBillingDetail = basicBillingDetail;
    }
}
