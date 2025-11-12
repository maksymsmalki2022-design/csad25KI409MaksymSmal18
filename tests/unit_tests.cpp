// Minimal unit tests for math_operations::add
#include <iostream>
#include "math_operations.h"

static int g_failures = 0;

void expect_eq(int expected, int actual, const char* case_name) {
	if (expected != actual) {
		std::cerr << "FAIL: " << case_name << " - expected=" << expected << " actual=" << actual << '\n';
		++g_failures;
	} else {
		std::cout << "PASS: " << case_name << '\n';
	}
}

int main() {
	expect_eq(3, add(1, 2), "1 + 2");
	expect_eq(0, add(0, 0), "0 + 0");
	expect_eq(-1, add(-3, 2), "-3 + 2");
	expect_eq(5, add(2, 3), "2 + 3");
	// large values
	expect_eq(2000000000, add(1000000000, 1000000000), "large positive");

	if (g_failures == 0) {
		std::cout << "All tests passed\n";
		return 0;
	} else {
		std::cerr << g_failures << " test(s) failed\n";
		return 1;
	}
}


