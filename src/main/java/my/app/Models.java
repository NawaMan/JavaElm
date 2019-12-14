package my.app;

import functionalj.types.Choice;
import functionalj.types.Struct;
import functionalj.types.elm.Elm;

public class Models {
    
    @Struct
    @Elm
    void Person(String name, int age) {}
    
    @Struct
    @Elm
    void Company(String name) {}
    
    @Choice
    @Elm
    interface MayBeSpec<T> {
        void Just(T data);
        void Nothing();
    }
    
}
