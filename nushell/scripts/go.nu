export def "from go test log" [--json] {
	if $json {
		$in
		| lines
		| each { from json }
		| rename -b { str downcase }
		| reduce --fold {} {|it, acc|
			match $it.action {
				"run" => {
					let cell_path = ([$it.package, $it.test] | into cell-path)
					if $acc == null {
						{ $"($it.package).($it.test)": { package: $it.package, testcase: $it.test, log: [] } }
					} else {
						$acc
						| insert $cell_path { package: $it.package, testcase: $it.test, log: [] }
					}
				}
				"output" => {
					if $it.test? != null {
						let cell_path = ([$it.package, $it.test, "log"] | into cell-path)
						$acc
						| update $cell_path (($in | get $cell_path) ++ $it.output)
					} else {
						$acc
					}
				}
				"pass" | "fail" | "skip" => {
					if $it.test? != null {
						let result_cell_path = ([$it.package, $it.test, "result"] | into cell-path)
						let elapsed_cell_path = ([$it.package, $it.test, "elapsed"] | into cell-path)
						$acc
						| insert $result_cell_path $it.action
						| insert $elapsed_cell_path $"($it.elapsed)s"
					} else {
						$acc
					}
				}
				_ => $acc
			}
		}
		| transpose key value
		| each { ($in.value | transpose key value | get value) }
		| flatten
		| move result --before log
	} else {
		let lines = $in | lines
		let test_cases = $lines
		| where $it =~ '--- (?:PASS|FAIL):'
		| parse -r '--- (?<result>PASS|FAIL): (?<testcase>[^ ]+)'

		$lines
		| reduce --fold {current_test_case: "", test_cases: ($test_cases | reduce --fold {} {|it, acc| $acc | insert $it.testcase []})} {|line, acc| 
			if ($line =~ "--- (?:PASS|FAIL):") {
				$acc
				| update current_test_case ""
			} else if ($line =~ "=== RUN ") {
				let test_case = $line | parse "=== RUN   {test_case}" | get test_case | first
				$acc
				| update current_test_case $test_case
			} else if ($line =~ "=== NAME") {
				let test_case = $line | parse "=== NAME  {test_case}" | get test_case | first
				let cell_path = ["test_cases", $test_case] | into cell-path
				$acc
				| update current_test_case $test_case
				| update $cell_path (($in | get $cell_path) ++ "--- POST TEST")
			} else if ($acc.current_test_case != "") {
				let cell_path = ["test_cases", $acc.current_test_case] | into cell-path
				$acc
				| update $cell_path (($in | get $cell_path) ++ $line)
			} else {
				$acc
			}
		}
		| get test_cases
		| transpose testcase log
		| merge $test_cases
		| move log --after result
	}
}

export def --wrapped "go run tests" [...rest] {
	^go test -count=1 -v -json ...$rest | from go test log --json
}

export def --wrapped "go run integration tests" [...rest] {
	^go test -count=1 -v -json --tags=integration ...$rest | from go test log --json
}


