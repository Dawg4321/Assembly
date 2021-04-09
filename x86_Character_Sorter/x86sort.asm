.386
.model flat
.code
public _sort
_sort proc

		push ebp				; push ebp to stack

		mov ebp, esp				; move the address on the esp (stack pointer) to the base pointer (ebp)

		mov esi, [ebp+8]			; moving the starting address of the string s to esi
		
		mov bl, 0				; setting capital flag 1 to '0'
		mov bh, 0				; setting capital flag 2 to '0'

		mov ecx, 1				; i = 1
Loop1:  
		cmp ecx, [ebp + 12]
		jae FIN					; while i is less than length

		mov edx, ecx				; j = i
Loop2:	
		cmp edx, 0				; comparing j to zero
		jbe NOSWAP				; if j =< 0, no swap needed as the current selected value is already at the start of array

		mov al, [esi+edx]			; Moving the characters to compare into al and ah to be tested
		mov	ah, [esi+edx-1]

CAP1:	
		bt eax, 5				; testing if there is a capital in al. If there is a cap, the 6th bit will be clear
		jc	CAP2				; carry bit will be set if lower case so no need to remove cap thus jump to CAP2 as to check the other letter for capitals
		add al, 32				; adding 32 to ah as to make the capital letter lowercase
		mov bl, 1				; setting capital flag 1 to '1' for later use when reverting back to a capital letter

CAP2:	
		bt eax, 13				; testing if there is a capital in ah. If there is a cap, the 6th bit will be clear
		jc	CMP1				; carry bit will be set if lower case so no need to remove cap thus jump to the comparison (CMP1)
		add ah, 32				; adding 32 to ah as to make the capital letter lowercase
		mov bh, 1				; setting capital flag 2 to '1' for later use when reverting back to a capital letter

CMP1:	
		cmp ah, al				; as both letters are now lowercase, the two letters can be compared
		jb NCAP					; if al < ah, no swap needed therefore jump to NCAP to reset the caps without swapping
		ja SCAP1				; if ah < al, different letters meaning a swap is needed thus jump to SCAP1 to reset caps and swap the al and ah

		cmp bh, bl				; capital flags 1 & 2 are compared as ah == al
		jae NCAP				;  bl >= bh no swap is needed thus jump to NCAP to reset the caps without swapping

SCAP1:	
		cmp bl, 1				; check if bl to see if al needs to reset to a cap
		jne SCAP2				; jump to second cap (SCAP2) if bl != 1 meaning al was lowercase
		sub al, 32				; subtract 32 to make the letter capital again
		mov bl, 0				; reset capital flag 1 to '0' for next iteration of Loop2

SCAP2:	
		cmp bh, 1				; check if bh to see if ah needs to reset to a cap
		jne SWAP				; jump to SWAP if bh != 1 meaning ah was lowercase
		sub ah, 32				; subtract 32 to make the letter capital again
		mov bh, 0				; reset capital flag 2 to '0' for next iteration of Loop2

SWAP:	
		mov [esi+edx], ah			; Swapping s[j] and s[j-1] 
		mov [esi+edx-1], al

		sub edx, 1				; j = j - 1

		jmp Loop2				; continue back to top of Loop2

NCAP:	
		mov bl, 0				; reset capital flag 1 to '0'
		mov bh, 0				; reset capital flag 2 to '0'

								; Break from Loop 2 as no more swaps needed for this iteration of the outerloop (s[j]<s[j-1])

NOSWAP:	
		add ecx, 1				; i = i + 1	
		jmp Loop1				; continue back to top of Loop1

FIN:	
		mov esp, ebp				; deallocating ebp
		pop ebp					; restoring original ebp value
		ret					; return from function

_sort endp
end
