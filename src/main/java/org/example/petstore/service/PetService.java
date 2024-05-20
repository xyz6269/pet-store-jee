package org.example.petstore.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.petstore.DTO.PetDto;
import org.example.petstore.model.Pet;
import org.example.petstore.model.Request;
import org.example.petstore.repository.PetRepository;
import org.example.petstore.repository.RequestRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class PetService {
    private final PetRepository petRepository;
    private final RequestRepository requestRepository;

    public void createPet(PetDto dto, MultipartFile file) throws IOException {
        log.info(dto.toString());
        if (file == null) {
            throw new RuntimeException("Image is empty");
        }else {
            Pet pet = new Pet();
            pet.setName(dto.getName());
            pet.setAge(dto.getAge());
            pet.setCategory(dto.getCategory());
            pet.setImage(file.getBytes());
            petRepository.save(pet);
        }

    }

    public List<Pet> getAllPets() {
        return petRepository.findAll();
    }

    public void deletePet(String id) {
        Pet pet = findPetById(id);
        log.info(pet.getName());
        requestRepository.deleteAll(requestRepository.findAllByPet(pet));
        petRepository.deleteById(id);
    }

    public Pet findPetById(String id) {
        return petRepository.findById(id).orElseThrow(() -> new RuntimeException("Pet not found"));
    }

    public void editPet(String id, PetDto dto, MultipartFile file) throws IOException {
        Pet pet = findPetById(id);
        pet.setName(dto.getName());
        pet.setAge(dto.getAge());
        pet.setCategory(dto.getCategory());
        pet.setImage(file.getBytes());
        petRepository.save(pet);
    }





}
