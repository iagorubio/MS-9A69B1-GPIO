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
        GPO_0:              .byte 0b00010000 //SET THE GPIO YOU NEED HERE OR ADD OTHER AND IMPLEMENT THEMº

    .text


    /* exporta enable config mode */
    .globl enable_config_mode
    .type enable_config_mode, @function
enable_config_mode:
        .cfi_startproc
        /* Subroutine Prologue */
        push %rbp      /* Save the old base pointer value. */
        mov %esp, %ebp /* Set the new base pointer value. */
        push %rdx      /* save registers */
        /* (no need to save EBX, EBP, or ESP) */

        /* Escribe la dirección de $0x4E en EDX el valor de configuración 087h en
         EAX y transfiere al puerto/dirección $0x4E el valor de configuración $0x87 */
        mov    SIO_INDEX_Port, %dx          /* mueve a los primeros 16bits de EDX el valor  04Eh, dirección del Index register */
        mov    SIO_UnLock_Value, %al       /* mueve al los segundos 8 bits de EAX eo valor 087h */
        out    %ax, %dx                      /* transfiere un byte (word o long) de EAX (low AX byte AL) al puerto especificado en EDX */
        /* Aquí está NOPeando ... es decir haciendo nada, da un salto a si mismo ($ dirección actual, JMP usa dos bytes, JMP $+2 salta a la misma linea
        //"jmp    short $ +2 //NOP - imaginate que es un delay()
        //"jmp    short $ + 2 //NOP - imaginate que es un delay()
        // lo cambio por nops porque no lo entiende el compilador */
        nop
        nop
        nop
        nop

        out    %al, %dx    /* transfiere un byte (word o long) de EAX (low AX byte AL) al puerto especificado en EDX */
        /*  por lo visto escribiendo dos veces 0x87 en el puerto de direcciones entra en modo extendido */

        /* Subroutine Epilogue */
        pop %rdx       /* Recover register values. */
        pop %rbp       /* Restore the caller's base pointer value. */
        ret
        .cfi_endproc


    /* exporta switch_gpio_configuration_SIO_LDN_0x06 */
    .globl switch_gpio_configuration_SIO_LDN_0x06
    .type switch_gpio_configuration_SIO_LDN_0x06, @function
switch_gpio_configuration_SIO_LDN_0x06:
        .cfi_startproc
        /* Subroutine Prologue */
        push %rbp      /* Save the old base pointer value. */
        mov %esp, %ebp /* Set the new base pointer value. */
        push %rdx      /* save registers */
        /* (no need to save EBX, EBP, or ESP) */

        mov    SIO_INDEX_Port, %dx      /* mueve a los primeros 16bits de EDX el valor  04Eh, dirección del Index register  */
        mov    $0x07, %al                /* mueve al los segundos 8 bits de EAX eo valor 07h (000000000000111) tres primeros bits set  */
        out    %al, %dx                 /* transfiere un byte (word o long) de EAX (low AX byte AL) al puerto especificado en EDX  */

       /* Esto es una acción, guarda un valor en EDX , otro valor en EAX y transfiere los butes de EAX al puerto guardado en EDX  */
        mov    SIO_DATA_Port, %dx       /* mueve a EDX 04Fh (dirección del data port)  */
        mov    SIO_LDN_GPIO, %al        /* mueve a EAX 06h que es la dirección del dispositivo lógico que identifica los GPIO  */
        out    %al, %dx                 /* transfiere un byte (word o long) de EAX (low AX byte AL) al puerto especificado en EDX  */

        /* Subroutine Epilogue */
        pop %rdx       /* Recover register values. */
        pop %rbp       /* Restore the caller's base pointer value. */
        ret
        .cfi_endproc

    /* exporta exit_sio */
    .globl exit_sio
    .type exit_sio, @function
exit_sio:
        .cfi_startproc
        /* Subroutine Prologue */
        push %rbp      /* Save the old base pointer value. */
        mov %esp, %ebp /* Set the new base pointer value. */
        push %rdx      /* save registers */
        /* (no need to save EBX, EBP, or ESP) */

        mov SIO_INDEX_Port, %dx   /* mueve a los primeros 16bits de EDX el valor  04Eh, dirección del Index register */
        mov SIO_Lock_Value, %al   /* mueve a EAX 0AAh para salir del modo extendido */
        out %al, %dx     /* transfiere un byte (word o long) de EAX (low AX byte AL) al puerto especificado en EDX */

        /* Subroutine Epilogue */
        pop %rdx       /* Recover register values. */
        pop %rbp       /* Restore the caller's base pointer value. */
        ret
        .cfi_endproc


    /* exporta set_gpio_0_high */
    .globl set_gpio_0_high
    .type set_gpio_0_high, @function
set_gpio_0_high:
        .cfi_startproc
        /* Subroutine Prologue */
        push %rbp      /* Save the old base pointer value. */
        mov %esp, %ebp /* Set the new base pointer value. */
        push %rdx      /* save registers */
        /* (no need to save EBX, EBP, or ESP) */

        mov    SIO_INDEX_Port, %dx      /* mueve a los primeros 16bits de EDX el valor  04Eh, dirección del Index register */
        mov    GPO_REG, %al             /* mueve a EAX 081h que es la dirección del banco GP0 */
        out    %al, %dx                 /* transfiere un byte (word o long) de EAX (low AX byte AL) al puerto especificado en EDX */
        mov    SIO_DATA_Port, %dx       /* mueve a EDX 04Fh (dirección del data port) */
        in     %dx, %al                 /* transfiere un byte (word o long) de EDX (DX byte) al puerto especificado en EAX (low AX byte AL) */
        or     GPO_0, %al               /*hace un or lógico del bit que indentifica GPO0 - no pone direcciónes de otros GPIOS - 00010000  con EAX (low AX byte AL) */
        out    %al, %dx                 /* transfiere un byte (word o long) de EAX (low AX byte AL) al puerto especificado en EDX */

        /* Subroutine Epilogue */
        pop %rdx       /* Recover register values. */
        pop %rbp       /* Restore the caller's base pointer value. */
        ret
        .cfi_endproc

    /* exporta set_gpio_0_high */
    .globl set_gpio_0_low
    .type set_gpio_0_low, @function
set_gpio_0_low:
        .cfi_startproc
        /* Subroutine Prologue */
        push %rbp      /* Save the old base pointer value. */
        mov %esp, %ebp /* Set the new base pointer value. */
        push %rdx      /* save registers */
        /* (no need to save EBX, EBP, or ESP) */

        mov    SIO_INDEX_Port, %dx       /* mueve a los primeros 16bits de EDX el valor  04Eh, dirección del Index register */
        mov    GPO_REG, %al        /* mueve a EAX 081h que es la dirección del banco GP0 */
        out    %al, %dx          /* transfiere un byte (word o long) de EAX (low AX byte AL) al puerto especificado en EDX */
        mov    SIO_DATA_Port, %dx        /* mueve a EDX 04Fh (dirección del data port) */
        in     %dx, %al           /* transfiere un byte (word o long) de EDX (DX byte) al puerto especificado en EAX (low AX byte AL) */
        and    GPO_0, %al             /*hace un or lógico del bit que indentifica GPO0 - no pone direcciónes de otros GPIOS - 00010000  con EAX (low AX byte AL) */
        out    %al, %dx           /* transfiere un byte (word o long) de EAX (low AX byte AL) al puerto especificado en EDX */

        /* Subroutine Epilogue */
        pop %rdx       /* Recover register values. */
        pop %rbp       /* Restore the caller's base pointer value. */
        ret
        .cfi_endproc










