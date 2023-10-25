# Motoko Benchmarking

Easy way to benchmark the Motoko code with `mops bench`.

The output format is a markdown table, so you can copy-paste it into your README.

If other packages are only used in benchmarks, make sure you add them to the `[dev-dependencies]` section in the `mops.toml` file.

## Install
```
mops add bench --dev
```

## Usage

Put your benchmark code in `bench/*.bench.mo` files.

Run `mops bench` to run the benchmarks.

## Benchmark template

Each `*.bench.mo` file should conform to the following template:

```motoko
import Bench "mo:bench";

module {
  public func init() : Bench.Bench {
    let bench = Bench.Bench();

    // benchmark code...

    bench;
  };
};
```

## Example

`bench/simple.bench.mo`
```motoko
import Bench "mo:bench";
import Nat "mo:base/Nat";
import Iter "mo:base/Iter";
import Buffer "mo:base/Buffer";
import Vector "mo:vector/Class";

module {
  public func init() : Bench.Bench {
    let bench = Bench.Bench();

    bench.name("Vector vs Buffer");
    bench.description("Add items one-by-one");

    bench.rows(["Vector", "Buffer"]);
    bench.cols(["10", "10000", "1000000"]);

    bench.runner(func(row, col) {
      let ?n = Nat.fromText(col);

      // Vector
      if (row == "Vector") {
        let vec = Vector.Vector<Nat>();
        for (i in Iter.range(1, n)) {
          vec.add(i);
        };
      }

      // Buffer
      if (row == "Buffer") {
        let buf = Buffer.Buffer<Nat>(0);
        for (i in Iter.range(1, n)) {
          buf.add(i);
        };
      };
    });

    bench;
  };
};
```

`mops bench` output
```
Benchmark files:
• bench/simple.bench.mo

==================================================

Starting dfx replica...
Deploying canisters...

——————————————————————————————————————————————————

Running bench/simple.bench.mo...



Vector vs Buffer

Add items one-by-one


Instructions

|        |     10 |     10000 |     1000000 |
| :----- | -----: | --------: | ----------: |
| Vector | 20_142 | 5_674_933 | 541_408_065 |
| Buffer | 14_730 | 7_515_219 | 696_375_723 |


Heap

|        |    10 |   10000 |    1000000 |
| :----- | ----: | ------: | ---------: |
| Vector | 9_844 |  56_356 |  4_064_460 |
| Buffer | 9_828 | 155_500 | 12_608_388 |

Stopping dfx replica...
```

`README.md`

### Vector vs Buffer

Add items one-by-one

**Instructions**

|        |     10 |     10000 |     1000000 |
| :----- | -----: | --------: | ----------: |
| Vector | 20_142 | 5_674_933 | 541_408_065 |
| Buffer | 14_730 | 7_515_219 | 696_375_723 |


**Heap**

|        |    10 |   10000 |    1000000 |
| :----- | ----: | ------: | ---------: |
| Vector | 9_844 |  56_356 |  4_064_460 |
| Buffer | 9_828 | 155_500 | 12_608_388 |