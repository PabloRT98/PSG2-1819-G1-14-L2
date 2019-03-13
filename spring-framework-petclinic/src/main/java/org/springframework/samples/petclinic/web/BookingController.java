/*
 * Copyright 2002-2013 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.springframework.samples.petclinic.web;

import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.samples.petclinic.model.Booking;
import org.springframework.samples.petclinic.model.Pet;
import org.springframework.samples.petclinic.service.ClinicService;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * @author Juergen Hoeller
 * @author Ken Krebs
 * @author Arjen Poutsma
 */
@Controller
public class BookingController {

    private final ClinicService clinicService;

    @Autowired
    public BookingController(ClinicService clinicService) {
        this.clinicService = clinicService;
    }

    @InitBinder
    public void setAllowedFields(WebDataBinder dataBinder) {
        dataBinder.setDisallowedFields("id");
    }

    /**
     * Called before each and every @RequestMapping annotated method.
     * 2 goals:
     * - Make sure we always have fresh data
     * - Since we do not use the session scope, make sure that Pet object always has an id
     * (Even though id is not part of the form fields)
     *
     * @param petId
     * @return Pet
     */
    @ModelAttribute("booking")
    public Booking loadPetWithBooking(@PathVariable("petId") int petId) {
        Pet pet = this.clinicService.findPetById(petId);
        Booking booking = new Booking();
        pet.addBooking(booking);
        return booking;
    }

    @RequestMapping(value = "/owners/*/pets/{petId}/bookings/new", method = RequestMethod.GET)
    public String initNewBookingForm(@PathVariable("petId") int petId, Map<String, Object> model) {
        return "pets/createOrUpdateBookingForm";
    }

    @RequestMapping(value = "/owners/{ownerId}/pets/{petId}/bookings/new", method = RequestMethod.POST)
    public String processNewHotelForm(@Valid Booking booking, BindingResult result) {
        if (result.hasErrors()) {
            return "pets/createOrUpdateBookingForm";
        } else {
            this.clinicService.saveBooking(booking);
            return "redirect:/owners/{ownerId}";
        }
    }

    @RequestMapping(value = "/owners/*/pets/{petId}/bookings", method = RequestMethod.GET)
    public String showbookings(@PathVariable int petId, Map<String, Object> model) {
        model.put("bookings", this.clinicService.findPetById(petId).getBookings());
        return "bookingList";
    }
    
    @RequestMapping(value = "/owners/{ownerId}/pets/{petId}/bookings/{bookingId}/delete", method = RequestMethod.GET)
    public String delete(@PathVariable("bookingId") int bookingId, @PathVariable("petId") int petId) {
       
        Pet pet=this.clinicService.findPetById(petId);
        Booking booking=this.clinicService.findBookingById(bookingId);
        pet.deleteBooking(booking);
        this.clinicService.savePet(pet);

        this.clinicService.deleteBooking(bookingId);
        return "redirect:/owners/{ownerId}";
     
    }

    }


