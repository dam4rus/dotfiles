export def "from go test log" [] {
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

export def --wrapped "go run integration tests" [...rest] {
	^go test -count=1 ./integration_test/ -v --tags=integration ...$rest | from go test log
}

export def --wrapped "go run tests" [...rest] {
	^go test -count=1 -v ...$rest | from go test log
}
