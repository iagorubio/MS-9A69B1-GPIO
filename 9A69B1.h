/*
    MS-9A69B1 GPIO Code
    MSI MS-9A69B1 Industrial Data Machine
    GPIO Access
    Author: Yago Rubio Sanfiz (c) 2021

    This code is in the Public Domain
*/

#ifndef X86GPIO_9A69B1_9A69B1_H
#define X86GPIO_9A69B1_9A69B1_H
// #define SIO_INDEX_Port 0x4E

extern  void enable_config_mode(void);
extern void switch_gpio_configuration_SIO_LDN_0x06(void);
extern void exit_sio(void);
extern void set_gpio_0_high(void);
extern void set_gpio_0_low(void);

#endif //X86GPIO_9A69B1_9A69B1_H
