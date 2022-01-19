/*
    MS-9A69B1 GPIO Code
    MSI MS-9A69B1 Industrial Data Machine
    GPIO Access

    Yago Rubio (c) 2011
    This code is in the Public Domain
*/
    .data

        SIO_INDEX_Port:     .byte 0x4E
        SIO_DATA_Port:      .byte 0x4F
        SIO_UnLock_Value:   .byte 0x87
        SIO_Lock_Value:     .byte 0xAA
        SIO_LDN_GPIO:       .byte 0x06
        GPI_REG:            .byte 0x82
        GPO_REG:            .byte 0x81
        GPI_ADD:            .byte 0x00
        GPO_ADD:            .byte 0x00
        GPO_0:              .byte 0b00010000 /* SET THE GPIO YOU NEED HERE OR ADD OTHER AND IMPLEMENT THEMº/ DOC DOES NOT STATE THEM */

    .text


    /* exports enable config mode */
    .globl enable_config_mode
    .type enable_config_mode, @function
enable_config_mode:
        .cfi_startproc
        /* Subroutine Prologue */
        push %rbp      /* Save the old base pointer value. */
        mov %esp, %ebp /* Set the new base pointer value. */
        push %rdx      /* save registers */
        /* (no need to save EBX, EBP, or ESP) */

        /* Write the address $0x4E at EDX and the config value 087h at */
        /* EAX and transfer to port/addr $0x4E the value stored at EAX*/
        mov    SIO_INDEX_Port, %dx          /* move to most significative 16bits of EDX the value 04Eh (Index register address) */
        mov    SIO_UnLock_Value, %al        /* move to least significatuve 16bits of EAX the value 087h */
        out    %ax, %dx                     /* transfer on word from, EAX to the port address stored at EDX */
        /*  Noping for delay. JMP 2 bytes from current address ($ is current address, and JMP uses two bytes so, JMP $+2 is a jump to self */
        //jmp    short $ +2 //NOP */
        //jmp    short $ + 2 //NOP */
        /* compiler goes nuts with $ + 2 so just nop instead */
        nop
        nop
        nop
        nop

        out    %al, %dx    /* transfer one byte from, EAX to the port address stored at EDX  */
        /*  writing twice at 0x87 adress port gets into extended mode  */

        /* Subroutine Epilogue  */
        pop %rdx       /* Recover register values.  */
        pop %rbp       /* Restore the caller's base pointer value.  */
        ret
        .cfi_endproc


    /* exports switch_gpio_configuration_SIO_LDN_0x06 */
    .globl switch_gpio_configuration_SIO_LDN_0x06
    .type switch_gpio_configuration_SIO_LDN_0x06, @function
switch_gpio_configuration_SIO_LDN_0x06:
        .cfi_startproc
        /* Subroutine Prologue  */
        push %rbp      /* Save the old base pointer value.  */
        mov %esp, %ebp /* Set the new base pointer value.  */
        push %rdx      /* save registers  */
        /* (no need to save EBX, EBP, or ESP)  */

        mov    SIO_INDEX_Port, %dx       /* move to most significative 16bits of EDX the value 04Eh (Index register address)  */
        mov    $0x07, %al                /* movet to least sig. byte of EAX the value 07h (000000000000111) that's first 3 bits set   */
        out    %al, %dx                 /* transfer one  byte from transfiere un byte (word o long) from to port specified at EDX */

        mov    SIO_DATA_Port, %dx       /* moce data port address 04Fh to EDX */
        mov    SIO_LDN_GPIO, %al        /* moves to EAX 06h that's the addr from logic device that odetifies GPIO ports */
        out    %al, %dx                /* transfer one byte from, EAX to the port address stored at EDX  */

        /* Subroutine Epilogue  */
        pop %rdx       /* Recover register values. */
        pop %rbp       /* Restore the caller's base pointer value.  */
        ret
        .cfi_endproc

    /* exports exit_sio */
    .globl exit_sio
    .type exit_sio, @function
exit_sio:
        .cfi_startproc
        /* Subroutine Prologue  */
        push %rbp      /* Save the old base pointer value.  */
        mov %esp, %ebp /* Set the new base pointer value.  */
        push %rdx      /* save registers  */
        /* (no need to save EBX, EBP, or ESP)  */

        mov SIO_INDEX_Port, %dx   /* move to most significative 16bits of EDX the value 04Eh (Index register address)  */
        mov SIO_Lock_Value, %al   /* move to EAX 0AAh to get out extended mode  */
        out %al, %dx              /* transfer one byte from, EAX to the port address stored at EDX */

        /* Subroutine Epilogue  */
        pop %rdx       /* Recover register values.  */
        pop %rbp       /* Restore the caller's base pointer value.  */
        ret
        .cfi_endproc


    /* exporta set_gpio_0_high  */
    .globl set_gpio_0_high
    .type set_gpio_0_high, @function
set_gpio_0_high:
        .cfi_startproc
        /* Subroutine Prologue  */
        push %rbp      /* Save the old base pointer value.  */
        mov %esp, %ebp /* Set the new base pointer value.  */
        push %rdx      /* save registers  */
        /* (no need to save EBX, EBP, or ESP)  */

        mov    SIO_INDEX_Port, %dx      /* move to most significative 16bits of EDX the value 04Eh (Index register address) */
        mov    GPO_REG, %al             /* move to EAX 081h that's address of GP0 port */
        out    %al, %dx                 /* transfiere un byte (word o long) de EAX (low AX byte AL) al puerto especificado en EDX  */
        mov    SIO_DATA_Port, %dx       /* move to most significative 16bits of EDX the value 04Eh (Index register address) */
        in     %dx, %al                 /* transfer one byte from EDX (DX byte) to port specified at EAX (low AX byte AL) */
        or     GPO_0, %al               /* OR GPO0 - the doc does not state other GPIO addresses - 00010000  with EAX (low AX byte AL) */
        out    %al, %dx                 /* transfer one byte from, EAX to the port address stored at EDX */

        /* Subroutine Epilogue  */
        pop %rdx       /* Recover register values.  */
        pop %rbp       /* Restore the caller's base pointer value.  */
        ret
        .cfi_endproc

    /* exporta set_gpio_0_high  */
    .globl set_gpio_0_low
    .type set_gpio_0_low, @function
set_gpio_0_low:
        .cfi_startproc
        /* Subroutine Prologue 
        push %rbp      /* Save the old base pointer value.  */
        mov %esp, %ebp /* Set the new base pointer value.  */
        push %rdx      /* save registers  */
        /* (no need to save EBX, EBP, or ESP)  */

        mov    SIO_INDEX_Port, %dx      /* move to most significative 16bits of EDX the value 04Eh (Index register address) */
        mov    GPO_REG, %al             /* move to EAX 081h that's address of GP0 port */
        out    %al, %dx                 /* transfiere un byte (word o long) de EAX (low AX byte AL) al puerto especificado en EDX */
        mov    SIO_DATA_Port, %dx       /* mueve a EDX 04Fh (dirección del data port) */
        in     %dx, %al                 /* transfiere un byte (word o long) de EDX (DX byte) al puerto especificado en EAX (low AX byte AL) */
        and    GPO_0, %al               /* AND GPO0 - the doc does not state other GPIO addresses - 00010000  with EAX (low AX byte AL) */
        out    %al, %dx                 /* transfer one byte from, EAX to the port address stored at EDX */

        /* Subroutine Epilogue  */
        pop %rdx       /* Recover register values.  */
        pop %rbp       /* Restore the caller's base pointer value.  */
        ret
        .cfi_endproc










