package com.stream.Person;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class Persons {
    public static void main(String[] args) {
        List<Person> listPersons = new ArrayList<>();
        listPersons.add(new Person(1, "Михаил", 35));
        listPersons.add(new Person(2, "Константин", 16));
        listPersons.add(new Person(3, "Ирина", 47));
        listPersons.add(new Person(4, "Анастасия", 23));
        listPersons.add(new Person(5, "Мария", 25));
        listPersons.add(new Person(6, "Инна", 48));

        // 1.Найти все имена людей (Лист стрингов), имена которых длиннее 5 букв
        System.out.print("Names > 5:");
        List<String> listNames = listPersons.stream()
                .map(n -> n.getName()).filter(x -> x.length() > 5)
                .collect(Collectors.toCollection(ArrayList::new));
        listNames.stream().forEach(x -> System.out.print(" " + x));
        System.out.println();

	    // 2.Посчитать всех совершеннолетних людей
        System.out.print("Age > 18: ");
        long countAge = listPersons.stream().filter(n -> n.getAge() > 18).count();
        System.out.println(countAge);

        // 3.Отсортировать людей по возрасту, вернуть массив уникальных чисел.
        System.out.print("Age: ");
            Stream<Integer> listAge =  listPersons.stream().map(x -> x.getAge()).sorted();
            Integer[] mass = listAge.toArray(Integer[]::new);
        Arrays.stream(mass).forEach(x -> System.out.print(x + " "));

        // 4.Отсортировать имена людей по алфавиту в обратном порядке
        System.out.println();
        System.out.print("Reverse order: ");
        listPersons.stream()
                .map(x -> x.getName())
                .sorted(Comparator.reverseOrder())
                .forEach(x -> System.out.print(x + " "));

        // 5.Вернуть true, если в списке людей есть хотя бы один человек, чье имя начинается на «А».
        System.out.println();
        System.out.print("A: ");
        System.out.println(listPersons.stream().anyMatch(x -> x.getName().charAt(0) == 'А'));

        // 6.Найти средний возраст людей
        System.out.println("Average age: " +  listPersons.stream().map(x -> x.getAge()).mapToInt(Integer::intValue).average().getAsDouble());

        // 7.Вернуть true, если все имена содержать букву «И»
        System.out.println(listPersons.stream().allMatch(x -> x.getName().toLowerCase().contains("И")));

        // 8.Добавить к id каждого человека + 1, вернуть список людей
        System.out.println(listPersons.stream().collect(Collectors.toMap(a -> a.getId() + 1, l -> l.getName())));

        // 9.Вернуть все числа возраста людей (например, есть люди с возрастом 18,40,50, вернуть массив [1,8,4,0,5,0]
        String[] str = listPersons.stream().map(x -> x.getAge()).map(String::valueOf).flatMap((p) -> Arrays.asList(p.split("")).stream()).toArray(String[]::new);
        System.out.println(Arrays.stream(str).collect(Collectors.joining(",", "[","]")));

        // 10.Вывести в консоль id всех людей
        System.out.print("ID`s: ");
        listPersons.stream().forEach(x -> System.out.print(x.getId() + " "));

        // 11.Вернуть сумму всех возрастов людей
        System.out.println();
        System.out.print("Sum ages: ");
        System.out.println(listPersons.stream().collect(Collectors.summingInt(x -> x.getAge())));

        // 12.Вернуть Map, ключ - id, значение - объект человек
        Map<Integer, List<Person>> mapka = listPersons.stream().collect(Collectors.groupingBy(Person::getId));
    }
}
