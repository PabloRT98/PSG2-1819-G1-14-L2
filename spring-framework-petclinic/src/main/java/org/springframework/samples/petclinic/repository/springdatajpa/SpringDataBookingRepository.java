package org.springframework.samples.petclinic.repository.springdatajpa;

import javax.transaction.Transactional;

import org.springframework.dao.DataAccessException;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.Repository;
import org.springframework.data.repository.query.Param;
import org.springframework.samples.petclinic.model.Booking;
import org.springframework.samples.petclinic.repository.BookingRepository;
import org.springframework.samples.petclinic.repository.OwnerRepository;

/**
 * Spring Data JPA specialization of the {@link OwnerRepository} interface
 *
 * @author Michael Isvy
 * @since 15.1.2013
 */
public interface SpringDataBookingRepository extends BookingRepository, Repository<Booking, Integer> {
	
	@Transactional
    @Modifying
    @Query("DELETE FROM Booking b where b.id=:bookingId")
    void delete(@Param(value = "bookingId") int bookingId) throws DataAccessException;
    
    @Query("SELECT x FROM Booking x where x.id=:bookingId")
	Booking findByBookingId(@Param(value = "bookingId") int bookingId) throws DataAccessException;

	@Transactional
	@Modifying
	@Query("DELETE FROM Booking x where x.pet.id=:petId")
	void deleteAllBookingsByPetId(@Param(value = "petId") int petId) throws DataAccessException;

}