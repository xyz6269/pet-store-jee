package org.example.petstore.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class PetRequest {
    private String petId;
    private String userEmail;
}
