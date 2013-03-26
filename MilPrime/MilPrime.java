import java.lang.Math;

public class MilPrime {

    public static void main(String[] args) {
        System.out.println(primeAt(1000000));
		System.out.println("\nDone");

    }

    public static Boolean isPrime (int n) {
        if (n == 1) { return false; }
        else if (n < 4) { return true; }
        else if (n % 2 == 0) { return false; }
        else if (n < 9) { return true; }
        else if (n % 3 == 0) { return false; }
        else {
            double root = Math.sqrt((double) n);
            int r = (int) root;
            int f = 5;
            while (f <= r) {
                if (n % f == 0) {
                    return false;
                }
                if (n % (f + 2) == 0) {
                    return false;
                }
                f += 6;
            }
        }
        return true;
    }

    public static int primeAt(int limit) {
		if (limit == 1) { return 2; }
        int count = 1;
        int candidate = 1;
        while (count < limit) {
            candidate += 2;
            if (isPrime(candidate)) {
                count++;
            }
        }
        return candidate;
    }
}
