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

Original board size should be: `{width: 4, height:5}`

> Made in England by Kelrack Ltd. in the beginning of 80's. Originally called Mint Man, this toy with robot likeness is really a puzzle which you have to solve in order to get the mints sealed in a bag behind the teeth. Educational, funny, and very motivating! 
> What's more interesting, the Mint Man has made it into an all-Finnish version called Minttu-Pekka (akin to Mint-Peter), with instructions & ingredient info embossed on the back. The puzzle measures 9 x 7 x 2 cm, and bears a copyright year 1982.

Ref. [Moonbase Central](https://projectswordtoys.blogspot.com/2011/08/its-mint-man.html)

## About
* Implemented in C++ as a learning project.
* Not designed to mimic the ABC-80 implementation.

## Implementation strategy
1. General board and brick datamodel with support for movement
2. Support for default and perhaps some additional preset initial placement of the bricks. 
3. Game state handling to evalute if game has been solved
4. Running the game from console
5. Implement graphics using SDL2 