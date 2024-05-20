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
            return "redirect:/";
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
        Request request1 = null;
        try {
            request1 = requestService.findUserRequest(userId.getValue());
        } catch (RuntimeException e) {
            return "redirect:/empty-request";
        }
        model.addAttribute("request", request1);
        return "user-request";
    }

    @GetMapping("/empty-request")
    public String emptyRequest() {
        return "no-requests";
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

    @RequestMapping("/add-pet")
    public String addPet(HttpServletRequest request) {
        Cookie userId = getCurrentUserCookie(request);
        return "add-pet-forum";
    }

    @GetMapping("/edit-pet/{id}")
    public String editPet(@PathVariable("id") String id, Model model, HttpServletRequest request) {
        model.addAttribute("pet", id);
        return "edit-page";
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
