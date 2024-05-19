package org.example.petstore.repository;

import org.aspectj.apache.bcel.classfile.Module;
import org.example.petstore.enums.Category;
import org.example.petstore.model.Pet;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface PetRepository extends MongoRepository<Pet, String> {
    List<Pet> findAllByCategory(Category category);
    Optional<Pet> findById(String id);
}
