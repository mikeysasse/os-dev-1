cmp ax, 4
je ax_is_four
jmp else
jmp endif

ax_is_four:
    jmp endif

else:
    jmp endif

endif:
