package org.example.petstore.repository;

import org.example.petstore.model.Pet;
import org.example.petstore.model.Request;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface RequestRepository extends MongoRepository<Request, String> {
    
    List<Request> findAllByPet(Pet pet);
    Optional<Request> findByClientEmail(String email);

}
