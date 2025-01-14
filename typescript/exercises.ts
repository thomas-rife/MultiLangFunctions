import { createReadStream } from 'fs';
import * as readline from 'readline';
import { ReadStream } from "node:fs";

export function change(amount: bigint): Map<bigint, bigint> {
  if (amount < 0) {
    throw new RangeError("Amount cannot be negative")
  }
  let counts: Map<bigint, bigint> = new Map()
  let remaining = amount
  for (const denomination of [25n, 10n, 5n, 1n]) {
    counts.set(denomination, remaining / denomination)
    remaining %= denomination
  }
  return counts
}

export function firstThenApply<inputType, outputType>(
  items: inputType[],
  predicate: (item: inputType) => boolean,
  apply: (item: inputType) => outputType
): outputType | undefined {
  const result: inputType | undefined = items.find((predicate))
  return result !== undefined ? apply(result) : undefined;
}

export function* powersGenerator(base: bigint): Generator<bigint> {
  for (let power = 1n; ; power *= base) {
    yield power
  }
}

export async function meaningfulLineCount(filename: string): Promise<number> {
  const fileStream: ReadStream = createReadStream(filename);
  const rl: readline.Interface = readline.createInterface({
    input: fileStream,
    crlfDelay: Infinity,
  });

  let validLineCount: number = 0;
  for await (const line of rl) { 
    const trimmedLine: string = line.trim();
    if (trimmedLine && !trimmedLine.startsWith('#')) {
      validLineCount++;
    }
  }

  return validLineCount;
}

type Box = {
  readonly kind: "Box";
  readonly width: number;
  readonly length: number;
  readonly depth: number;
};

type Sphere = {
  readonly kind: "Sphere";
  readonly radius: number;
}

export type Shape = Box | Sphere

export function volume(shape: Shape): number {
  switch (shape.kind) {
    case "Box":
      return shape.length * shape.depth * shape.width
    case "Sphere":
      return (4/3) * Math.PI * Math.pow(shape.radius, 3);
  }
}

export function surfaceArea(shape: Shape): number {
  switch (shape.kind) {
    case "Box":
      return (shape.length * shape.width + shape.length * shape.width) + 
                 (shape.depth * shape.width + shape.depth * shape.width) +
                 (shape.length * shape.depth + shape.length * shape.depth);
    case "Sphere":
      return (4 * Math.PI * Math.pow(shape.radius, 2));
  }
}

abstract class BinarySearchTree<T> {
	abstract insert(value: T): BinarySearchTree<T>;
	abstract contains(value: T): boolean;
	abstract size(): number;
	abstract inorder(): Generator<T>; 
	abstract toString(): string;
   }
   
   class Empty<T> extends BinarySearchTree<T> {
	insert(value: T): BinarySearchTree<T> {
	  return new Node(value, new Empty(), new Empty());
	}
   
	contains(value: T): boolean {
	  return false;
	}
   
	size(): number {
	  return 0;
	}
   
	inorder(): Generator<T> {
	  return (function* () {})();
	}
   
	toString(): string {
	  return "()";
	}
   }
   
   class Node<T> extends BinarySearchTree<T> {
	constructor(
	  private readonly value: T,
	  private readonly left: BinarySearchTree<T>,
	  private readonly right: BinarySearchTree<T>
	) {
	  super();
	}
   
	insert(value: T): BinarySearchTree<T> {
	  if (value < this.value) {
	    return new Node(this.value, this.left.insert(value), this.right);
	  } else if (value > this.value) {
	    return new Node(this.value, this.left, this.right.insert(value));
	  } else {
	    return this;
	  }
	}
   
	contains(value: T): boolean {
	  if (value === this.value) 
		return true;
	  if (value < this.value) 
		return this.left.contains(value);
	  return this.right.contains(value);
	}
   
	size(): number {
	  return 1 + this.left.size() + this.right.size();
	}
   
	inorder(): Generator<T> {
	  function* inorderTraversal(node: BinarySearchTree<T>): Generator<T> {
	    if (node instanceof Node) {
		 yield* inorderTraversal(node.left);
		 yield node.value;
		 yield* inorderTraversal(node.right);
	    }
	  }
	  return inorderTraversal(this);
	}
   
	toString(): string {
		const leftString = this.left.toString();
		const rightString = this.right.toString();
		return `(${this.left instanceof Empty ? '' : leftString}${this.value}${this.right instanceof Empty ? '' : rightString})`;
	   }	   
   }
   
export { BinarySearchTree, Empty };