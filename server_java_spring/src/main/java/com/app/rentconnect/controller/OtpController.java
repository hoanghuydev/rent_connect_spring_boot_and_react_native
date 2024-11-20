package com.app.rentconnect.controller;

import com.app.rentconnect.dto.request.EmailRequestDTO;
import com.app.rentconnect.dto.response.ApiResponse;
import com.app.rentconnect.service.command.OtpCommandService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/auth")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE,makeFinal = true)
public class OtpController {
    OtpCommandService otpCommandService;

    @PostMapping("/send-otp")
    public ApiResponse<String> resendOtp(@RequestBody EmailRequestDTO emailRequestDTO) {
        return otpCommandService.sendOtp(emailRequestDTO);
    }

}