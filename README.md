# JavaElm
Generate Elm from Java code.

This project is an example for generate Elm data type with encoder and decoder of the data type and the list of those types.


Required:
- Java
- Gradle


How to:

0. Install all required application and clone this repository.

1. Create a class named "Models". The package of the class will be the name of the generated Elm module. For example, the data in `my.app.Model` will be created in `My.App` elm module.

NOTE: Actuall the name "Models" does not matter. It is the package name that matters.

2. Define regular data type as a method of the Models class. The name of the method is the name of the data type. The name and type of the parameters are the attributes. For examples:

    @Struct
    @Elm
    void Person(String name, int age) {}

will result in a data type `Person` with two attribute name (string) and age (int).
The method must be annotated with `@Struct` and `@Elm`.

3. Define choice type as an inner interface inside Models class. The name of the inner interface MUST be suffixed with `Spec`. The choices are defined as method inside that interface.

    @Choice
    @Elm
    interface MayBeSpec<T> {
        void Just(T data);
        void Nothing();
    }

will result in a choice type with two choices.

4. Build the project with the following command.

    gradle clean build
    
The generated elm files will be in the folder `generated/elm`.
