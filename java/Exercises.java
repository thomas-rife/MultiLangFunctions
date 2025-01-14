import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Optional;
import java.util.function.Predicate;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class Exercises {
    static Map<Integer, Long> change(long amount) {
        if (amount < 0) {
            throw new IllegalArgumentException("Amount cannot be negative");
        }
        var counts = new HashMap<Integer, Long>();
        for (var denomination : List.of(25, 10, 5, 1)) {
            counts.put(denomination, amount / denomination);
            amount %= denomination;
        }
        return counts;
    }

	public static Optional<String> firstThenLowerCase(List<String> array, Predicate<String> predicate) {
		return array.stream()
			   .filter(predicate)
			   .findFirst()
			   .map(String::toLowerCase);
	}

	public static class Say {
		private String phrase;

		public Say(String phrase) {
			this.phrase = phrase;
		}

		public String phrase() {
			System.out.println(phrase);
			return this.phrase;
		}

		public Say and(String string) {
			return new Say(this.phrase + " " + string);
		}
	}

	public static Say say() {
		return new Say("");
	}

	public static Say say(String phrase) {
		return new Say(phrase);
	}
	
	public static int meaningfulLineCount(String filename) throws IOException {
		try(var reader = new BufferedReader(new FileReader(filename))) {
			long validLineCount = reader.lines()
	 		.filter(line -> !line.trim().isEmpty())
	 		.filter(line -> !line.trim().startsWith("#"))
	 		.count(); 
	 		return (int) validLineCount;
		}
	}
}

 final record Quaternion(double a, double b, double c, double d) {
	public final static Quaternion ZERO = new Quaternion(0, 0, 0, 0);
	public final static Quaternion I = new Quaternion(0,1,0,0);
	public final static Quaternion J = new Quaternion(0,0,1,0);
	public final static Quaternion K = new Quaternion(0,0,0,1);

	public Quaternion {
		if (Double.isNaN(a) || Double.isNaN(b) || Double.isNaN(c) || Double.isNaN(d)) {
			throw new IllegalArgumentException("Coefficients cannot be NaN");
		}
	}

	public Quaternion plus(Quaternion other) {
		return new Quaternion(a + other.a, b + other.b, c + other.c, d + other.d);
	}

	public List<Double> coefficients() {
		return List.of(a,b,c,d);
	}

	public Quaternion times(Quaternion other) {
		double newA = a * other.a - b * other.b - c * other.c - d * other.d;
		double newB = a * other.b + b * other.a + c * other.d - d * other.c;
		double newC = a * other.c - b * other.d + c * other.a + d * other.b;
		double newD = a * other.d + b * other.c - c * other.b + d * other.a;
		return new Quaternion(newA, newB, newC, newD);
	}

	public Quaternion conjugate() {
		return new Quaternion(this.a, -this.b, -this.c, -this.d);
	}

	@Override
	public String toString() {
		List<String> components = new ArrayList<>();

			if (a != 0.0) {
				components.add(String.valueOf(a));
			}

			if (b != 0.0) {
				if (b == 1.0 && components.isEmpty()) {
					components.add("i");
				} else if (b == 1.0 && !components.isEmpty()) {
					components.add("+i");
				} else if (b == -1.0) {
					components.add("-i");
				} else if (b < 0.0 || components.isEmpty()) {
					components.add(b + "i");
				} else {
					components.add("+" + b + "i");
				}
			}

			if (c != 0.0) {
				if (c == 1.0 && components.isEmpty()) {
					components.add("j");
				} else if (c == 1.0 && !components.isEmpty()) {
					components.add("+j");
				} else if (c == -1.0) {
					components.add("-j");
				} else if (c < 0.0 || components.isEmpty()) {
					components.add(c + "j");
				} else {
					components.add("+" + c + "j");
				}
			}

			if (d != 0.0) {
				if (d == 1.0 && components.isEmpty()) {
					components.add("k");
				} else if (d == 1.0 && !components.isEmpty()) {
					components.add("+k");
				} else if (d == -1.0) {
					components.add("-k");
				} else if (d < 0.0 || components.isEmpty()) {
					components.add(d + "k");
				} else {
					components.add("+" + d + "k");
				}
			}

			if (components.isEmpty()) {
				return "0";
			}

			return String.join("", components);
		}

}

sealed interface BinarySearchTree permits Empty, Node {
	int size();
	BinarySearchTree insert(String item);
	boolean contains(String item);
}

final class Empty implements BinarySearchTree {
	public static final Empty INSTANCE = new Empty();

	public int size() {
		return 0;
	}
	
	public BinarySearchTree insert(String item) {
		return new Node(item, Empty.INSTANCE, Empty.INSTANCE);
	}
	
	public boolean contains(String item) {
		return false;
	}

	public String toString() {
		return "()";
	}
}

final class Node implements BinarySearchTree {
	final String data;
	final BinarySearchTree left;
    	final BinarySearchTree right;
	
	Node(String data, BinarySearchTree left, BinarySearchTree right) {
		this.data = data;
		this.left = left;
		this.right = right;
	}
	
	public int size() {
        	return 1 + left.size() + right.size(); 
	}
	
	public BinarySearchTree insert(String data) {
		if (data.compareTo(this.data) < 0) {
		    var newLeft = left.insert(data);
		    return new Node(this.data, newLeft, right); 
		} else if (data.compareTo(this.data) > 0) {
		    var newRight = right.insert(data);
		    return new Node(this.data, left, newRight);
		} else {
		    return this;
		}
	 }
	 
	public boolean contains(String data) {
		if (data.equals(this.data)) {
			return true;
		} else if (data.compareTo(this.data) < 0) {
			return left.contains(data);
		} else if (data.compareTo(this.data) > 0) {
			return right.contains(data);
		}
		return false;
	}

	@Override
	public String toString() {
		String leftString = left.toString();
		String rightString = right.toString();
		return "(" + (left instanceof Empty ? "" : leftString) + 
				data + (right instanceof Empty ? "" : rightString) + ")";
	 }
}
