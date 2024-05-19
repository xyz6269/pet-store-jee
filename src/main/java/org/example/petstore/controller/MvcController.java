package org.example.petstore.controller;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.petstore.DTO.AuthenticationResponse;
import org.example.petstore.DTO.LoginRequest;
import org.example.petstore.DTO.RegisterRequest;
import org.example.petstore.model.Pet;
import org.example.petstore.model.Request;
import org.example.petstore.service.PetService;
import org.example.petstore.service.RequestService;
import org.example.petstore.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Objects;

@Controller
@CrossOrigin("*")
@RequiredArgsConstructor
@Slf4j
public class MvcController {

    private final PetService petService;
    private final UserService userService;
    private final RequestService requestService;


    @GetMapping({"/"})
    public String welcome() {
        return "login";
    }

    @GetMapping({"/create-acc"})
    public String craeteAccount() {
        return "signup";
    }

    @PostMapping("/login")
    public String logIn(HttpServletResponse response, LoginRequest request) {
        AuthenticationResponse authResponse = userService.logIn(request);
        if (authResponse != null) {
            Cookie userIdCookie = new Cookie("user-cookie", authResponse.getUserEmail());
            userIdCookie.setMaxAge(60 * 60 * 24); // 1 day
            userIdCookie.setPath("/");
            response.addCookie(userIdCookie);
            if (Objects.equals(authResponse.getAuthorisations(), "ADMIN")) {
                return "redirect:/admin-home";

            }else {
                return "redirect:/home";
            }
        }else {
            return "/";
        }
    }

    @GetMapping("/home")
    public String home(Model model, HttpServletRequest request) {
        Cookie cookie = getCurrentUserCookie(request);
        List<Pet> pets = petService.getAllPets();
        log.info(cookie.getValue());
        model.addAttribute("pets", pets);
        model.addAttribute("userEmail", cookie.getValue());
        return "home";
    }

    @GetMapping("/admin-home")
    public String adminHome(Model model) {
        List<Pet> pets = petService.getAllPets();
        model.addAttribute("pets", pets);
        return "admin-home";
    }

    @GetMapping("/user-request")
    public String getRequest(HttpServletRequest request, Model model) {
        Cookie userId = getCurrentUserCookie(request);
        Request request1 = requestService.findUserRequest(userId.getValue()).orElseThrow(
                        () -> new RuntimeException("User Not Found"));
        model.addAttribute("request", request1);

        return "user-request";
    }

    @GetMapping("/all-request")
//    @PreAuthorize("hasAuthority('ADMIN')")
    public String allRequests(Model model) {
        List<Request> requests = requestService.getAllRequests();
        log.info(requests.toString());
        model.addAttribute("requests", requests);
        return "requests";
    }

    @PostMapping("/submit-request")
    public String submitRequest(HttpServletRequest request ,Model model) {
        Cookie userCookie = getCurrentUserCookie(request);
        model.addAttribute("request", Long.parseLong(userCookie.getValue()));
        return "user-request";
    }

    @GetMapping("/my-requests")
    public Request getMyRequests() {
        return requestService.findCurrentUserRequest().orElseThrow(
                () -> new RuntimeException("you have no request submitted")
        );
    }

    @DeleteMapping("/discard")
    public String discard(HttpServletRequest request, Model model) {
        Cookie userCookie = getCurrentUserCookie(request);
        requestService.deleteRequest(userCookie.getValue());
        return "Request Discarded";
    }

    @DeleteMapping("/delete")
    public String deleteRequest(@PathVariable("email") String email) {
        requestService.deleteRequest(email);
        return "Request Discarded";
    }


    @PostMapping("/signup")
    public String register(Model model, RegisterRequest request){
        AuthenticationResponse response = userService.register(request);
        if(response != null){
            model.addAttribute("respose",response);
            return "redirect:/";
        }else{
            return "/create-acc";
        }
    }





    private Cookie getCurrentUserCookie (HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        Cookie userId = null;
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("user-cookie".equals(cookie.getName())) {
                    userId = cookie;
                }
            }
        }else {
            throw new RuntimeException("No cookie found");
        }
        return userId;
    }
}
