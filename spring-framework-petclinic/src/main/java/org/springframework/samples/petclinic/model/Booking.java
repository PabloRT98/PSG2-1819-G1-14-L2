package org.springframework.samples.petclinic.model;

import java.time.LocalDate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;


@Entity
@Table(name = "bookings")
public class Booking extends NamedEntity {
    @NotNull
    @Column(name = "checkin")
    @DateTimeFormat(pattern = "yyyy/MM/dd")
    private LocalDate checkin;
    @NotNull
    @Column(name = "checkout")
    @DateTimeFormat(pattern = "yyyy/MM/dd")
    private LocalDate checkout;

    @ManyToOne
    @JoinColumn(name = "pet_id")
    private Pet pet;

    @Column(name="description")
    private String description;



    public void setCheckin(LocalDate checkin) {
        this.checkin = checkin;
    }

    public LocalDate getCheckin() {
        return this.checkin;
    }
    public void setCheckout(LocalDate checkout) {
        this.checkout = checkout;
    }

    public LocalDate getCheckout() {
        return this.checkout;
    }
    public void setPet(Pet pet){
        this.pet=pet;
    }
    public Pet getPet(){
        return this.pet;
    }
    public void setDescription(String description){
        this.description=description;
}
    public String getDescription(){
        return this.description;
    }


}