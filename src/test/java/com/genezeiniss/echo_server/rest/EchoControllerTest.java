package com.genezeiniss.echo_server.rest;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultActions;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(EchoController.class)
public class EchoControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    @DisplayName("echo simple json")
    public void echoSimpleJson() throws Exception {
        var request = """
                {
                    "game":"Mobile Legends",
                    "gamerID":"GYUTDTE",
                    "points":20
                }
                """;
        echo(request)
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.game").value("Mobile Legends"))
                .andExpect(jsonPath("$.gamerID").value("GYUTDTE"))
                .andExpect(jsonPath("$.points").value(20));
    }

    @Test
    @DisplayName("echo nested json")
    public void echoNestedJson() throws Exception {
        var request = """
                {
                    "request": {
                        "game":"Mobile Legends",
                        "gamerID":"GYUTDTE",
                        "points":20
                    }
                }
                """;
        echo(request)
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.request.game").value("Mobile Legends"))
                .andExpect(jsonPath("$.request.gamerID").value("GYUTDTE"))
                .andExpect(jsonPath("$.request.points").value(20));
    }

    private ResultActions echo(String request) throws Exception {
        return mockMvc.perform(post("/api/echo")
                .contentType(MediaType.APPLICATION_JSON)
                .content(request));
    }
}