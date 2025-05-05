package com.genezeiniss.echo_server.rest;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("api")
public class EchoController {

    @PostMapping("/echo")
    @ResponseStatus(HttpStatus.CREATED)
    public Map<String, Object> echo(@RequestBody Map<String, Object> request) {
        return request;
    }
}