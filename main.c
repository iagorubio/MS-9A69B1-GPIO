#include "9A69B1.h"
/*
    MS-9A69B1 GPIO Code
    MSI MS-9A69B1 Industrial Data Machine
    GPIO Access
    Author: Yago Rubio Sanfiz (c) 2021

    This code is in the Public Domain
*/
int main() {
    enable_config_mode();
    switch_gpio_configuration_SIO_LDN_0x06();

    set_gpio_0_high();
    // delay is OS dependent
    // so please choose your poison
    // https://code.woboq.org/linux/linux/arch/x86/lib/delay.c.html
    // ... AS EXAMPLE
    set_gpio_0_low();
    exit_sio();
}


