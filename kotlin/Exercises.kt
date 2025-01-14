import java.io.BufferedReader
import java.io.FileReader
import java.io.IOException

fun change(amount: Long): Map<Int, Long> {
    require(amount >= 0) { "Amount cannot be negative" }
    
    val counts = mutableMapOf<Int, Long>()
    var remaining = amount
    for (denomination in listOf(25, 10, 5, 1)) {
        counts[denomination] = remaining / denomination
        remaining %= denomination
    }
    return counts
}

public fun firstThenLowerCase(array: List<String>, predicate: (String) -> Boolean): String? {
    return array.firstOrNull(predicate)?.lowercase()
}

class Say(public val phrase: String) {
    fun phrase(): String {
        println(phrase)
        return phrase
    }

    fun and(string: String): Say {
        return Say("$phrase $string")
    }
}

fun say(): Say {
    return Say("")
}

fun say(phrase: String): Say {
    return Say(phrase)
}

@Throws(IOException::class)
fun meaningfulLineCount(filename: String): Long {
    BufferedReader(FileReader(filename)).use { reader ->
        val validLineCount = reader.lines()
            .filter { it.trim().isNotEmpty() }
            .filter { !it.trim().startsWith("#") }
            .count()
        return validLineCount.toLong()
    }
}

data class Quaternion(val a: Double, val b: Double, val c: Double, val d: Double) {
    companion object {
        val ZERO = Quaternion(0.0, 0.0, 0.0, 0.0)
        val I = Quaternion(0.0, 1.0, 0.0, 0.0)
        val J = Quaternion(0.0, 0.0, 1.0, 0.0)
        val K = Quaternion(0.0, 0.0, 0.0, 1.0)
    }

    operator fun plus(other: Quaternion): Quaternion {
        return Quaternion(a + other.a, b + other.b, c+ other.c, d + other.d)
    }

    operator fun times(other: Quaternion): Quaternion {
        val newA = a * other.a - b * other.b - c * other.c - d * other.d
        val newB = a * other.b + b * other.a + c * other.d - d * other.c
        val newC = a * other.c - b * other.d + c * other.a + d * other.b
        val newD = a * other.d + b * other.c - c * other.b + d * other.a
        return Quaternion(newA, newB, newC, newD)
    }

    fun coefficients(): List<Double> {
        return listOf(a,b,c,d)
    }

    fun conjugate(): Quaternion {
        return Quaternion(a, -b, -c, -d)
    }

    override fun toString(): String {
        val components = mutableListOf<String>()

        if (a != 0.0) {
            components.add(a.toString())
        }

        if (b != 0.0) {
            when {
                b == 1.0 && components.isEmpty() -> components.add("i")
                b == 1.0 && components.isNotEmpty() -> components.add("+i")
                b == -1.0 -> components.add("-i")
                b < 0.0 || components.isEmpty() -> components.add("${b}i")
                else -> components.add("+${b}i")
            }
        }

        if (c != 0.0) {
            when {
                c == 1.0 && components.isEmpty() -> components.add("j")
                c == 1.0 && components.isNotEmpty() -> components.add("+j")
                c == -1.0 -> components.add("-j")
                c < 0.0 || components.isEmpty() -> components.add("${c}j")
                else -> components.add("+${c}j")
            }
        }

        if (d != 0.0) {
            when {
                d == 1.0 && components.isEmpty() -> components.add("k")
                d == 1.0 && components.isNotEmpty() -> components.add("+k")
                d == -1.0 -> components.add("-k")
                d < 0.0 || components.isEmpty() -> components.add("${d}k")
                else -> components.add("+${d}k")
            }
        }

        if (components.isEmpty()) {
            return "0"
        }

        return components.joinToString("")
    }
}

sealed interface BinarySearchTree {
    fun size(): Int
    fun insert(item: String): BinarySearchTree
    fun contains(item: String): Boolean

    object Empty : BinarySearchTree {
        override fun size(): Int = 0
        override fun insert(item: String): BinarySearchTree = Node(item, Empty, Empty)
        override fun contains(item: String): Boolean = false
        override fun toString(): String = "()"
    }

    data class Node(
        val data: String,
        val left: BinarySearchTree,
        val right: BinarySearchTree
    ) : BinarySearchTree {
        override fun size(): Int = 1 + left.size() + right.size()

        override fun insert(item: String): BinarySearchTree =
            when {
                item < data -> copy(left = left.insert(item))
                item > data -> copy(right = right.insert(item))
                else -> this
            }

        override fun contains(item: String): Boolean =
            when {
                item == data -> true
                item < data -> left.contains(item)
                else -> right.contains(item)
            }

        override fun toString(): String {
            val leftString = if (left is Empty) "" else left.toString()
            val rightString = if (right is Empty) "" else right.toString()
            return "($leftString$data$rightString)"
        }
    }
}
