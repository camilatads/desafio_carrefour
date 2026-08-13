package com.example.karate;

import com.intuit.karate.junit5.Karate;
import org.junit.jupiter.api.Test;

class ExampleTest {

    @Test
    void testCreateUser() {
        Karate.run("classpath:com/example/karate/features/create-user.feature").parallel(1);
    }
}
