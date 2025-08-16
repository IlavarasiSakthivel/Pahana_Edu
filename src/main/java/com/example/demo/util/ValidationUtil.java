package com.example.demo.util;

import java.util.regex.Pattern;

public class ValidationUtil {
    public static boolean isValidEmail(String email) {
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        Pattern pattern = Pattern.compile(emailRegex);
        return pattern.matcher(email).matches();
    }

    public static boolean isValidPhone(String phone) {
        String phoneRegex = "^[0-9]{10}$";
        Pattern pattern = Pattern.compile(phoneRegex);
        return pattern.matcher(phone).matches();
    }

    public static boolean isValidAccountNumber(String accountNumber) {
        return accountNumber != null && accountNumber.length() >= 5;
    }
}