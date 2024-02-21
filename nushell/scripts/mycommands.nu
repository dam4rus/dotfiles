def "from go test log" [] {
	let lines = $in | lines
	let test_cases = $lines | where $it =~ '--- (?:PASS|FAIL):' | parse -r '--- (?<result>PASS|FAIL): (?<test_case>[^ ]+)'
	mut current_test_case = null
	mut current_result = ""
	mut current_test_case_logs = []
	mut output = []
	for line in $lines {
		if $line =~ "--- (?:PASS|FAIL):" {
			if $current_test_case != null {
				$output = $output ++ [[test_case, result, logs]; [$current_test_case, $current_result, $current_test_case_logs]]
			}
			$current_test_case = null
			$current_result = ""
			$current_test_case_logs = []
			continue
		} else if $line =~ "=== RUN " {
			if $current_test_case != null {
				$output = $output ++ [[test_case, result, logs]; [$current_test_case, $current_result, $current_test_case_logs]]
			}

			let test_case = $line | parse "=== RUN   {test_case}" | get test_case | get 0
			$current_test_case = $test_case
			$current_result = ($test_cases | where test_case == $test_case | get result | first)
			$current_test_case_logs = []
			continue
		}
		if $current_test_case != null {
			$current_test_case_logs = ($current_test_case_logs ++ $line)
		}
	}
	if $current_test_case != null {
		$output = $output ++ [[test_case, result, logs]; [$current_test_case, $current_result, $current_test_case_logs]]
	}
	$output
}

