# Programs written in 13 Languages

## Scripting: Lua, Python, JavaScript

### Projects

- **Lowercase First Matching Element:**

  - Implemented functions in Lua, JavaScript, and Python that accept a sequence (Lua table, JavaScript array, or Python list) of strings and a predicate. The function returns the lowercased version of the first element that satisfies the predicate. If no element satisfies the predicate, the function returns `nil` (Lua), `undefined` (JavaScript), or `None` (Python).
  - **JavaScript requirement:** Used the optional chaining operator.
  - **Python requirement:** Required positional arguments only.

- **Powers Generator:**

  - Developed generator functions in JavaScript and Python, and a Lua coroutine, to yield successive powers of a base up to, but not exceeding, a given limit.
  - **Python requirement:** Implemented with positional arguments only.

- **Chainable Say:**

  - Created Lua, JavaScript, and Python chainable functions that accept at most one string per call. When called without arguments, the function returns previously passed words in order, separated by a single space.
  - **Python requirement:** Used a single, default, positional argument.

- **Meaningful Line Count:**

  - Constructed functions in Lua, JavaScript, and Python to accept a filename and return the number of text lines in the file that are neither empty nor made up entirely of whitespace, nor whose first non-whitespace character is `#`.
  - **Lua:** Returns the line count on success and generates (throws) an error if the file does not exist.
  - **Python:** Returns the line count on success and propagates the raised error if the file does not exist.
  - **JavaScript:** Async function that returns a promise resolving to the line count on success, and rejects if the file does not exist.

- **Quaternions:**

  - Developed user-defined datatypes for Quaternions as a class in JavaScript and Python, and as a table in Lua. Supported operations include:
    1. Construction
    2. Addition
    3. Multiplication
    4. Obtaining the list of coefficients
    5. Computing the conjugate
    6. Supporting value-based equality
    7. Producing the string representation

## Enterprise: Java, Kotlin, Swift

### Projects

- **Lowercase First Matching Element:**

  - Implemented functions in Java, Kotlin, and Swift that take a list (Java/Kotlin) or array (Swift) of strings and a predicate, returning the lowercased version of the first element that satisfies the predicate. If no element satisfies the predicate, the function returns an optional string.
  - **Java requirement:** Used streams to process the input.
  - **Kotlin requirement:** Used the `?.` operator for optional chaining.
  - **Swift requirement:** Utilized argument labels `for` (array) and `satisfying` (predicate) and implemented the `?.` operator.

- **Meaningful Line Count:**

  - Wrote functions in Java, Kotlin, and Swift that accept a filename and return the count of non-empty lines that are neither whitespace-only nor start with `#`.
    - For Java and Kotlin, the function propagates any IOExceptions that occur.
    - For Swift, the function returns a `Result` object instead of throwing exceptions.
  - **Java requirement:** Used `BufferedReader` with a try-with-resources block and processed the file using the `lines()` method to produce a stream.
  - **Kotlin requirement:** Used the `use` function on `BufferedReader` for resource management.
  - **Swift requirement:** Used `for try await` to asynchronously read the file.

- **Chainable Say Object:**

  - Implemented variations of the “chainable” function from Homework 1 as objects in Java, Kotlin, and Swift.
    - Objects expose a method `and` for adding a word to the chain.
    - A read-only property `phrase` returns the accumulated string.
  - Followed unit tests to ensure behavior aligns with the specifications.

- **Immutable Quaternions:**

  - Developed immutable Quaternion data structures as:
    - **Java:** A record.
    - **Kotlin:** A data class.
    - **Swift:** A struct.
  - Supported operations include:
    1. Construction
    2. Addition
    3. Multiplication
    4. Obtaining an array of coefficients
    5. Computing the conjugate
    6. Value-based equality
    7. String representation in accordance with language conventions
  - Included static constant members (`ZERO`, `I`, `J`, `K`) with their respective meanings.
  - Used operator overloading for addition and multiplication where supported by the language.

- **Generic Persistent Binary Search Tree:**

  - Implemented a generic, persistent binary search tree of strings in Java, Kotlin, and Swift, supporting:
    1. Element count
    2. Insertion
    3. Lookup
  - All implementations are immutable and persistent.
  - **Java requirement:** Used a sealed interface with two top-level class implementations.
  - **Kotlin requirement:** Used a sealed interface with two implementations nested inside. The empty variant is an `object`, while the node variant is a `data class`.
  - **Swift requirement:** Implemented using an `indirect enum`. Made `size` a computed property.
  - Used language-specific conventions for string formatting to represent trees.

## Functional Programming: TypeScript, OCaml, Haskell

### Projects

- **First Matching Element with Transformation:**

  - Implemented functions in TypeScript, OCaml, and Haskell to process an array (TypeScript) or list (OCaml/Haskell).
    - Each function takes:
      1. A collection.
      2. A predicate.
      3. A transformation function.
    - Returns the transformation of the first element satisfying the predicate, or `None`/`undefined` if no match is found.
  - All implementations demonstrate parametric polymorphism.
  - **Requirement:** Explicit type annotations provided in all languages.

- **Infinite Sequence of Powers:**

  - Generated an infinite sequence of powers of a given base:
    - **TypeScript requirement:** Base is a `BigInt`, not a number.
    - **Haskell requirement:** Base is restricted to any `Integral` type. Used a section in the solution.

- **Meaningful Line Count:**

  - Functions in TypeScript, OCaml, and Haskell to count non-empty lines in a text file, excluding lines made up entirely of whitespace or those starting with `#`.
    - Proper file closure ensured through language-specific mechanisms:
      - **TypeScript:** Used an asynchronous line-reading idiom that auto-closes the file.
      - **OCaml:** Wrapped line counting in `Fun.protect` to ensure proper resource management.
      - **Haskell:** Used `readFile` (auto-closes the file) and the `<$>` (`fmap`) operator.

- **3D Shapes:**

  - Defined immutable 3D shapes (rectangular boxes and spheres) in TypeScript, OCaml, and Haskell. Supported operations:
    1. Compute surface area.
    2. Compute volume.
    3. Convert to string.
    4. Value-based equality.
  - **TypeScript requirement:** Used a union type for shapes (`Box` and `Sphere`) instead of inheritance.
  - **OCaml and Haskell requirement:** Used algebraic data types for shape definitions. `deriving Show` used in Haskell for string conversion.

- **Generic Persistent Binary Search Tree:**

  - Implemented a generic, persistent binary search tree in TypeScript, OCaml, and Haskell with the following capabilities:
    1. Insertion.
    2. Lookup.
    3. Count of elements.
    4. Inorder traversal.
    5. String description (TypeScript/Haskell only).
  - **Inorder Traversal:**
    - **TypeScript:** Used a generator with `yield*`.
    - **OCaml and Haskell:** Produced a list of elements in order.
  - Ensured the immutability and persistence of the tree using algebraic data types.
  - Implementations prevent construction of invalid binary search trees:
    - **TypeScript:** Used language-specific information-hiding techniques.
    - **OCaml and Haskell:** Exported `Empty` constructor but not `Node` constructor to enforce constraints.

## Systems Programming: C, C++, and Rust

### Projects

- **C: String Stack**

  - Implemented the `string_stack.c` file to complete the `string_stack` specification defined in `string_stack.h`.
  - Key points:
    - Used "response objects" for operations as per the specification comments.
    - Leveraged opaque types for information hiding.
    - Passed all unit tests in `string_stack_test.c`.
    - Ensured memory management with no leaks. Verified with `valgrind`.

- **C++: Template Stack**

  - Completed the `stack.h` file to implement a generic stack as a template class.
  - Key points:
    - Followed the specification provided in the header file.
    - Implemented private data members for information hiding.
    - Error handling via exceptions.
    - Passed all unit tests in `stack_test.cpp`.
    - No separate compilation step due to template implementation.

- **Rust: Generic Stack**

  - Developed a simple wrapper around the `Vec` type in `stack/src/lib.rs`.
  - Key points:
    - Included a `peek` method to view the top element without popping it.
    - Used optionals for operations that could fail.
    - Combined `struct`, `impl`, and tests into one file for simplicity.
    - Passed all unit tests.

## Concurrency: Go

### Simulation Overview

**Scenario**: A restaurant simulation involving 10 customers, 3 cooks, and 1 waiter.

- **Customers**: Ani, Bai, Cat, Dao, Eve, Fay, Gus, Hua, Iza, Jai.
- **Cooks**: Remy, Colette, Linguini.

**Requirements**:

- **Waiter Behavior**:

  - The waiter can only manage up to 3 outstanding orders at any time.
  - If a customer cannot place an order within 7000 ms, they leave and return after 2500–5000 ms.

- **Cook Behavior**:

  - Cooks prepare meals in a random time between 5000–10000 ms.
  - Once done, they deliver the meal to the customer personally.

- **Customer Behavior**:

  - After receiving a meal, customers eat it (1000–2000 ms).
  - A customer goes home after eating 5 meals.

- **Restaurant Behavior**:
  - The restaurant shuts down only after all 10 customers have gone home.

**Key Implementation Details**:

- Concurrency: Handled using Go routines and channels.
- Randomness: Simulated meal preparation, eating times, and return delays with Go's random utilities.
- Synchronization: Used appropriate synchronization primitives (e.g., channels, mutexes) to handle waiter capacity and cook availability.
- Exit Condition: Ensured the simulation terminates only when all customers have gone home.
