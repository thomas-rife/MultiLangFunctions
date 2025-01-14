import { equal } from "node:assert"
import { open } from "node:fs/promises"

export function change(amount) {
  if (!Number.isInteger(amount)) {
    throw new TypeError("Amount must be an integer")
  }
  if (amount < 0) {
    throw new RangeError("Amount cannot be negative")
  }
  let [counts, remaining] = [{}, amount]
  for (const denomination of [25, 10, 5, 1]) {
    counts[denomination] = Math.floor(remaining / denomination)
    remaining %= denomination
  }
  return counts
}

// Write your first then lower case function here
export function firstThenLowerCase(a, p) {
  return a.find(p)?.toLowerCase()
}

// Write your powers generator here
export function* powersGenerator({ ofBase, upTo }) {
  let power = 0
  while (true) {
    const result = ofBase ** power
    if (result > upTo) {
      return
    }
    yield result
    power += 1
  }
}

// Write your say function here
export function say(word = undefined) {
  const words = []

  function nextWord(word = undefined) {
    if (word == undefined) {
      return words.join(" ")
    }
    words.push(word)
    return nextWord
  }
  return nextWord(word)
}

// Write your line count function here
export async function meaningfulLineCount(filename) {
  return new Promise(async (resolve, reject) => {
    let file
    try {
      file = await open(filename, "r")
      let count = 0

      for await (const line of file.readLines()) {
        const cutLine = line.trim()
        if (cutLine && !cutLine.startsWith("#")) {
          count++
        }
      }
      resolve(count)
    } catch (error) {
      reject(error)
    } finally {
      if (file) await file.close()
    }
  })
}

// Write your Quaternion class here
export class Quaternion {
  constructor(a,b,c,d) {
    Object.assign(this, {a,b,c,d})
    Object.freeze(this);
  }

  plus(v) {
    return new Quaternion(this.a + v.a, this.b + v.b, this.c + v.c, this.d + v.d)
  }

  times(w) {
    const a = this.a * w.a - this.b * w.b - this.c * w.c - this.d * w.d;
    const b = this.a * w.b + this.b * w.a + this.c * w.d - this.d * w.c;
    const c = this.a * w.c - this.b * w.d + this.c * w.a + this.d * w.b;
    const d = this.a * w.d + this.b * w.c - this.c * w.b + this.d * w.a;

    return new Quaternion(a, b, c, d); 
  }

  get coefficients() {
    return [this.a, this.b, this.c, this.d]
  }

  get conjugate() {
    return new Quaternion(this.a, -this.b, -this.c, -this.d)
  }

  eq(x) {
    return this.a == x.a & this.b == x.b & this.c == x.c * this.d == x.d
  }

  toString() {
    var result = "";

    if (this.a != 0.0) {
        result += this.a;
    }

    if (this.b != 0.0) {
        if (this.b == 1.0 & result == '') {
          result += "i"
        } else if (this.b == 1.0 & result !== '') {
          result += "+i"
        } else if (this.b == -1.0) {
          result += '-i'
        } else if (this.b < 0.0 || result == '') {
          result += this.b + "i"
        } else {
          result += '+' + this.b + 'i'
        }
    }

    if (this.c != 0.0) {
        if (this.c == 1.0 & result == '') {
          result += "j"
        } else if (this.c == 1.0 & result !== '') {
          result += "+j"
        } else if (this.c == -1.0) {
          result += '-j'
        } else if (this.c < 0.0 || result == '') {
          result += this.c + "j"
        } else {
          result += '+' + this.c + 'j'
        }
    }

    if (this.d != 0.0) {
        if (this.d == 1.0 & result == '') {
          result += "k"
        } else if (this.d == 1.0 & result !== '') {
          result += "+k"
        } else if (this.d == -1.0) {
          result += '-k'
        } else if (this.d < 0.0 || result == '') {
          result += this.d + "k"
        } else {
          result += '+' + this.d + 'k'
        }
    }

    if (result == '') {
        return "0";
    }

    return result;

  }
}