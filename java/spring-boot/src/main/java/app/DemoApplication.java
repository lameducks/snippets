package app;

import org.slf4j.LoggerFactory;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.Banner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.WebApplicationType;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;

@SpringBootApplication
public class DemoApplication implements ApplicationRunner {

    public static void main(String[] args) {
        final SpringApplication application = new SpringApplicationBuilder(DemoApplication.class)
                .bannerMode(Banner.Mode.OFF).web(WebApplicationType.NONE).build();
        application.run(args);
    }

    @Override
    public void run(ApplicationArguments args) throws Exception {
        LoggerFactory.getLogger(DemoApplication.class).debug("Hello Spring Boot!");
    }

}
