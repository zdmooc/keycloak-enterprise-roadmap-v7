package com.example.api;

import java.security.Principal;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @GetMapping("/public")
    public String publicEndpoint() {
        return "public ok";
    }

    @GetMapping("/me")
    public String me(Principal principal) {
        return "hello " + principal.getName();
    }

    @GetMapping("/admin")
    public String admin() {
        return "admin ok";
    }
}
