package com.smhrd.terms;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TermsController {

    @RequestMapping("/terms/tou")
    public String termsOfUse() {
        return "includes/terms_of_use"; // 실제 JSP 경로: /WEB-INF/views/includes/terms_of_use.jsp
    }

    @RequestMapping("/terms/privacy")
    public String privacyPolicy() {
        return "includes/privacy_policy";
    }

    @RequestMapping("/terms/email")
    public String emailPolicy() {
        return "includes/email_policy";
    }
}
