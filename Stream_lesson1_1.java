package Streams;
import java.util.Arrays;
import java.util.List;
class Main {
    public static void main(String[] args) {
        List<Integer> list = Arrays.asList(5,46,3,0,1,56,123,7,-3,12,14,0);
        // 1. Найти среднее значение элементов массива
        System.out.println("Average: " + list.stream().mapToInt(Integer::intValue).average().getAsDouble());
        // 2. Найти минимальный элемент, значение и индекс
        System.out.println("Min: " + list.stream().mapToInt(Integer::intValue).min().getAsInt()
                + ", with index: " + list.indexOf(list.stream().mapToInt(Integer::intValue).min().getAsInt()));
        // 3. Посчитать количество элементов равных нулю
        System.out.println("Number of zeros: " + list.stream()
                .filter(x -> x == 0)
                .count());
        // 4. Посчитать количество элементов больше нуля
        System.out.println("Elements greater than zero: " + list.stream()
                .filter(x -> x > 0)
                .count());
        // 5. Помножить элементы массива на число, к примеру 11
        System.out.print("x11: ");
        list.stream()
                .map(x -> x * 11)
                .forEach(number -> System.out.print(number + " "));
    }
}
