package org.example.petstore.controller;

import jakarta.mail.MessagingException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.petstore.DTO.Mail;
import org.example.petstore.DTO.PetDto;
import org.example.petstore.DTO.PetRequest;
import org.example.petstore.model.Pet;
import org.example.petstore.repository.PetRepository;
import org.example.petstore.service.EmailService;
import org.example.petstore.service.PetService;
import org.example.petstore.service.RequestService;
import org.example.petstore.service.UserService;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@RestController
@RequestMapping("/api")
@CrossOrigin("*")
@RequiredArgsConstructor
@Slf4j
public class RestControllers {

    private final PetService petService;
    private final EmailService emailService;
    private final RequestService requestService;

    @GetMapping("/find-pet")
    public Pet findPetById(@RequestBody String id) {
        return petService.findPetById(id);
    }

    @PostMapping(value="/addpet", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public void addPet(@RequestPart("data") PetDto dto, @RequestPart("image") MultipartFile file) throws IOException {
        petService.createPet(dto, file);
    }

    @PostMapping("/request-pet")
    public void createRequest(@RequestBody PetRequest petRequest) {
        requestService.createRequest(petRequest.getPetId(), petRequest.getUserEmail());
    }

    @DeleteMapping("/delete-pet/{id}")
    public void deletePet(@PathVariable("id") String id) {
        log.info(id);
        petService.deletePet(id);
    }

    @DeleteMapping("/delete-request/{id}")
    public void deleteRequest(@PathVariable("id") String id ) {
        requestService.deleteRequest(id);
    }

    @PutMapping(value = "/edit-pet/{id}",  consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public void modifyPet(@PathVariable("id") String id, @RequestPart("data") PetDto petRequest, @RequestPart("image") MultipartFile file) throws IOException {
        petService.editPet(id, petRequest, file);
    }

    @PostMapping("/send-mail")
    public void sendMail(@RequestPart("mail") Mail mail) throws MessagingException {
        emailService.sendSimpleMessage(mail.getTo(), mail.getSubject(), mail.getBody());
    }



}
