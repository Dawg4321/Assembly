// Title: Formal Element.cpp 
// Description: Runs an Insertion Sort Algorithm using x86 ASM Sort Function
// Author: Ryan Wiebe
// Last Updated: 09/04/2021

#include <iostream>
#include <string>

using namespace std;

extern "C" {void sort(char* a, int s); }

int main()
{
	string s; // string to store the characters for sorting

	cout << "-----------------------\n"; // print text 
	cout << "~~~ASM Letter Sorter~~~\n";
	cout << "Written by Ryan Wiebe\n";
	cout << "-----------------------\n";
	cout << "Please enter Alphabetical Letters to be Sorted:\n";
	cin >> s; // string input

	sort(&s[0], strlen(&s[0])); // calling the asm sort function using string s

	cout << "-----------------------\n";
	cout << "Sorted Letters:\n" << s; // printing sorted letters
	cout << "\n-----------------------";
}




