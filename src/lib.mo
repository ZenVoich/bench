module {
	let VERSION = 1;

	public type BenchSchema = {
		name : Text;
		description : Text;
		rows : [Text];
		cols : [Text];
	};

	public type BenchResult = {
		instructions : Int;
		rts_mutator_instructions : Int;
		rts_collector_instructions : Int;
		rts_heap_size : Int;
		rts_memory_size : Int;
		rts_total_allocation : Int;
	};

	class BenchHeap() {
		type List = {
			value : Any;
			var next : ?List;
		};

		let list : List = {
			value = null;
			var next = null;
		};

		var last = list;

		public func add(value : Any) {
			let next : List = {value = value; var next = null};
			last.next := ?next;
			last := next;
		};
	};

	public class Bench() {
		var _name = "";
		var _description = "";
		var _rows : [Text] = [];
		var _cols : [Text] = [];
		var _runner = func(row : Text, col : Text) {};

		// public let heap : BenchHeap = BenchHeap();

		public func name(value : Text) {
			_name := value;
		};

		public func description(value : Text) {
			_description := value;
		};

		public func rows(value : [Text]) {
			_rows := value;
		};

		public func cols(value : [Text]) {
			_cols := value;
		};

		public func runner(fn : (row : Text, col : Text) -> ()) {
			_runner := fn;
		};

		// INTERNAL
		public func getVersion() : Nat {
			VERSION;
		};

		public func getSchema() : BenchSchema {
			{
				name = _name;
				description = _description;
				rows = _rows;
				cols = _cols;
			}
		};

		public func runCell(rowIndex : Nat, colIndex : Nat) {
			let row = _rows.get(rowIndex);
			let col = _cols.get(colIndex);
			_runner(row, col);
		};
	};
};