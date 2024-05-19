package org.example.petstore.model;

import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.UUID;

@Document("request")
@Getter
@Setter
@AllArgsConstructor
public class Request {

    @Id
    private String id;
    private String clientEmail;
    private Pet pet;

    public Request() {
        id = UUID.randomUUID().toString();
    }
}
