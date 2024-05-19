package org.example.petstore.service;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.petstore.DTO.AuthenticationResponse;
import org.example.petstore.DTO.LoginRequest;
import org.example.petstore.DTO.RegisterRequest;
import org.example.petstore.model.Role;
import org.example.petstore.model.User;
import org.example.petstore.repository.RoleRepository;
import org.example.petstore.repository.UserRepository;
import org.example.petstore.security.JwtGenerator;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserService {
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtGenerator jwtGenerator;
    private final AuthenticationProvider provider;

    public AuthenticationResponse logIn(LoginRequest request) {
        provider.authenticate(new UsernamePasswordAuthenticationToken(request.getEmail(),request.getPassword()));
        var user = userRepository.findByEmail(request.getEmail()).orElseThrow(()-> new IllegalArgumentException("not found"));
        var jwtToken = jwtGenerator.generateToken((UserDetails) user);
        AuthenticationResponse response = new AuthenticationResponse(jwtToken, user.getRole().getRoleName(),user.getEmail());
        return response;
    }

    public AuthenticationResponse register(RegisterRequest request) {
        Role role = roleRepository.findById(2L).orElseThrow(() -> new RuntimeException("Role not found"));
        if (userRepository.findByEmail(request.getEmail()).isPresent()){
            throw new RuntimeException("user already exists");
        }
        log.info(request.getFirstName());
        User newUser = User.builder()
                .firstName(request.getFirstName())
                .lastName(request.getLastName())
                .email(request.getEmail())
                .password(passwordEncoder.encode(request.getPassword()))
                .role(role)
                .build();
        userRepository.save(newUser);
        String jwtToken = jwtGenerator.generateToken((UserDetails) newUser);
        AuthenticationResponse response = new AuthenticationResponse(jwtToken, newUser.getRole().getRoleName(), newUser.getEmail());
        return response;
    }


    public String getCurrentUserEmail() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if ((authentication instanceof AnonymousAuthenticationToken)) {
            throw new RuntimeException("the jwt is dead or some shit lol");
        }
        return authentication.getName();
    }

    public User getUserByid(Long id) {
        return userRepository.findById(id).orElseThrow(() -> new RuntimeException("not found"));
    }



}
