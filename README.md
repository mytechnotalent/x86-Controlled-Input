![image](https://github.com/mytechnotalent/x86-Controlled-Input/blob/main/x86%20Controlled%20Input.png?raw=true)

# x86 Controlled Input
x86 controlled input example taking a max of 4 bytes from the terminal and checking for a successful combination of int values in a row.

<br>

# Installation
```bash
git clone https://github.com/mytechnotalent/x86_Controlled_Input.git
cd x86_Controlled_Input
```

<br>

# Running

```bash
nasm -f elf32 x86_controlled_input.asm
ld -m elf_i386 -o x86_controlled_input x86_controlled_input.o
./x86_controlled_input
```

<br>

# License
[Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0)
