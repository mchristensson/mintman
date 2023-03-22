# Mint-Man
## History
Originally implemented for ABC80 by Anders Franzén <5258> (1985-07-05 01.47.21)

> ```
> +++++++++++++++++++++++++++++++
> ! Program ....   MINTMAN
> ! Utgåva  1.0    1985-07-04
> ! av (c) Anders Franzén <5258>
> ! Minne 16 Kbytes
> +++++++++++++++++++++++++++++++
> 
> Detta program simulerar denna
> sommars fluga, herr Mintman, på
> bildskärmen. Man kan spela
> själv ellet låta datorn visa
> en lösning. Programmet g|r
> inga anspråk på att visa den
> bästa lösningen. En "äkta"
> Mintman är kanske det bästa
> om man ligger på stranden och
> latar sig.
>  ```

## About
* Implemented in C++ as a learning project.
* Not designed to mimic the ABC-80 implementation.

## Implementation strategy
1. General board and brick datamodel with support for movement
2. Support for default and perhaps some additional preset initial placement of the bricks. 
3. Game state handling to evalute if game has been solved
4. Running the game from console
5. Implement graphics using SDL2 