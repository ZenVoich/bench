import Nat "mo:base/Nat";
import Iter "mo:base/Iter";
import Buffer "mo:base/Buffer";
import Vector "mo:vector/Class";
import Bench "../src";

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
	else if (row == "Buffer") {
		let buf = Buffer.Buffer<Nat>(0);
		for (i in Iter.range(1, n)) {
			buf.add(i);
		};
	};
});

bench.runCell(0, 0);