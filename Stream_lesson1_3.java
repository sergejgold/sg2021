package com.stream.Person;
import java.util.*;
import java.util.stream.Collectors;

public class Persons {
    public static List<String> sequence(String str) {
        List<String> str1 = Arrays.stream(str.split("-"))
                .filter(x -> x.length() > 5)
                .filter(x -> x.startsWith("a"))
                .collect(Collectors.toList());
        str1.forEach(System.out::println);
        return str1;
    }
    public static void main(String[] args) {
        sequence("Akjshdv-sdvbsd-sbdvsd-ascfsdvs-kufhbvd-Akjbvfdv-anj-advavdv");
    }
}
