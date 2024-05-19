package org.example.petstore.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.petstore.model.Pet;
import org.example.petstore.model.Request;
import org.example.petstore.repository.RequestRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Slf4j
public class RequestService {
    private final RequestRepository requestRepository;
    private final UserService userService;
    private final PetService petService;

    public void createRequest(String petId, String userEmail)  {
        if(requestRepository.findByClientEmail(userEmail).isPresent()) {
            throw new RuntimeException("you already submit a request");
        }else {
            Request request = new Request();
            request.setPet(petService.findPetById(petId));
            request.setClientEmail(userEmail);
            requestRepository.save(request);
        }
    }

    public List<Request> getAllRequests() {
        return requestRepository.findAll();
    }

    public Optional<Request> findUserRequest(String email) {
        return requestRepository.findByClientEmail(email);
    }

    public Optional<Request> findCurrentUserRequest() {
        return findUserRequest(userService.getCurrentUserEmail());
    }

    public void deleteRequest(String email) {
        Request request =requestRepository.findByClientEmail(email).orElseThrow(() -> new RuntimeException("Client request not found"));
        requestRepository.delete(request);
    }

    public List<Request> findByPet(Pet pet) {
        return requestRepository.findAllByPet(pet);
    }


    public void deleteAllRequests(List<Request> requests) {
        requestRepository.deleteAll(requests);
    }


}
