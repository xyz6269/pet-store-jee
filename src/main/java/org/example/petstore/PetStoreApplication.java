package org.example.petstore;

import lombok.RequiredArgsConstructor;
import org.example.petstore.service.UserService;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@RequiredArgsConstructor
public class PetStoreApplication {
    public static void main(String[] args) {
        SpringApplication.run(PetStoreApplication.class, args);
    }
}
