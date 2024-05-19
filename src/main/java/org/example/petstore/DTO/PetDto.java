package org.example.petstore.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.example.petstore.enums.Category;


@Data
@AllArgsConstructor
public class PetDto {
    private String name;
    private int age;
    private Category category;
}
