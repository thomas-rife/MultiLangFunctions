from dataclasses import dataclass
from collections.abc import Callable


def change(amount: int) -> dict[int, int]:
    if not isinstance(amount, int):
        raise TypeError('Amount must be an integer')
    if amount < 0:
        raise ValueError('Amount cannot be negative')
    counts, remaining = {}, amount
    for denomination in (25, 10, 5, 1):
        counts[denomination], remaining = divmod(remaining, denomination)
    return counts


# Write your first then lower case function here
def first_then_lower_case(a, p, /):
    for string in a:
        if p(string):
            return string.lower()
    return None


# Write your powers generator here
def powers_generator(*, base, limit):
    power = 0
    while True:
        result = base ** power
        if result > limit:
            break
        yield result
        power += 1


# Write your say function here
def say(word=None, /):
    words = []

    def extra(word=None):
        if word is None:
            return ' '.join(words)
        words.append(word)
        return extra

    return extra(word)

# Write your line count function here
def meaningful_line_count(filename, /):
    try:
        with open(filename, 'r') as file:
            return sum(1 for line in file 
                       if line.strip() and not line.strip().startswith('#'))
    except FileNotFoundError:
        raise

# Write your Quaternion class here
@dataclass(frozen = True)
class Quaternion:
    a: float
    b: float
    c: float
    d: float

    def __add__(self, other, /):
        return Quaternion(self.a + other.a, self.b + other.b, self.c + other.c, self.d + other.d)
    
    def __mul__(self, other, /):
        w = self.a * other.a - self.b * other.b - self.c * other.c - self.d * other.d
        x = self.a * other.b + self.b * other.a + self.c * other.d - self.d * other.c
        y = self.a * other.c - self.b * other.d + self.c * other.a + self.d * other.b
        z = self.a * other.d + self.b * other.c - self.c * other.b + self.d * other.a
        return Quaternion(w, x, y, z)
    
    @property
    def coefficients(self, /):
        return (self.a, self.b, self.c, self.d)
    
    @property
    def conjugate(self, /):
        return Quaternion(self.a, -self.b, -self.c, -self.d)   
    
    def __eq__(self, other, /):
        return self.a == other.a and self.b == other.b and self.c == other.c and self.d == other.d

    def __str__(self, /):
        components = []

        if self.a != 0.0:
            components.append(f"{self.a}")

        if self.b != 0.0:
            if self.b == 1.0 and not components:
                components.append(f"i")
            elif self.b == 1.0 and components:
                components.append(f"+i")
            elif self.b == -1.0:
                components.append(f"-i")
            elif self.b < 0.0 or not components:
                components.append(f"{self.b}i")
            else:
                components.append(f"+{self.b}i")

        if self.c != 0.0:
            if self.c == 1.0 and not components:
                components.append(f"j")
            elif self.c == 1.0 and components:
                components.append(f"+j")
            elif self.c == -1.0:
                components.append(f"-j")
            elif self.c < 0.0 or not components:
                components.append(f"{self.c}j")
            else:
                components.append(f"+{self.c}j")

        if self.d != 0.0:
            if self.d == 1.0 and not components:
                components.append(f"k")
            elif self.d == 1.0 and components:
                components.append(f"+k")
            elif self.d == -1.0:
                components.append(f"-k")
            elif self.d < 0.0 or not components:
                components.append(f"{self.d}k")
            else:
                components.append(f"+{self.d}k")

        if not components:
            return "0"

        return "".join(components)

        