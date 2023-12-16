.text
.globl GetOptionData
GetOptionData:
	
loop_option_1:       
	lb $t0, 0($a0)              
        beqz $t0, end_get_option_data  # Fim da string
        beq $t0, '-', loop_option_3

        sb $t0, 0($s1)
        addi $s1, $s1, 1
        sb $zero, 0($s1)

        addi $a0, $a0, 1    
j loop_option_1

la $a0, data_buffer


loop_option_3:


end_get_option_data:
    jr $ra

