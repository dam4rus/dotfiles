export def "from go test log" [] {
	let lines = $in | lines
	let test_cases = $lines | where $it =~ '--- (?:PASS|FAIL):' | parse -r '--- (?<result>PASS|FAIL): (?<test_case>[^ ]+)'
	$lines
	| reduce --fold {current: {testcase: "", result: "", log: []}, result: []} {|line, acc|
		let add_current_test_case = {||
		  if ($in.current.testcase != "")	{
			  $in | update result ($in.result ++ $in.current)
			} else {
			  $in
			}
		}

		if ($line =~ "--- (?:PASS|FAIL):") {
			$acc
			| do $add_current_test_case
			| update current {testcase: "", result: "", log: []}
		} else if ($line =~ "=== RUN ") {
			let test_case = $line | parse "=== RUN   {test_case}" | get test_case | first
			let current_test_case = {
				testcase: $test_case,
				result: ($test_cases | where test_case == $test_case | get result | first),
				log: [],
			}
		
			$acc
			| do $add_current_test_case
			| update current $current_test_case
		} else if ($acc.current.testcase != "") {
			$acc | update current.log ($in.current.log ++ $line)
		} else {
			$acc
		}
	}
	| if $in.current.testcase != "" { $in.result ++ $in.current } else { $in.result }
}

export def --wrapped "go run integration tests" [...rest] {
	^go test -count=1 ./integration_test/ -v --tags=integration ...$rest | from go test log
}

export def --wrapped "go run tests" [...rest] {
	^go test -count=1 -v ...$rest | from go test log
}
