package org.example.petstore.model;

import jakarta.persistence.Column;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import org.example.petstore.enums.Category;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.UUID;

@Document("pet")
@Getter
@Setter
@AllArgsConstructor
public class Pet {
    @Id
    private String id;
    private String name;
    private int age;
    private Category category;
    @Column(name = "image", length = 1000)
    private byte[] image;

    public Pet() {
        id = UUID.randomUUID().toString();
    }
}
