package my.app;

import functionalj.types.Struct;
import functionalj.types.elm.Elm;

public class Model {
    
    @Struct
    @Elm
    public void Person(String name, int age) {}
    
    @Struct
    @Elm
    public void Company(String name) {}
    
}
