use "exercise.sml";
use "test_framework.sml";

val () = general_test (lst_size, "lst_size", [[], [1,2,3]], [0,3])
val () = general_test (max, "max", [(1,2), (0, ~2)], [2, 0])
val () = general_test (maxargs, "maxargs", [prog, prog1, prog2], [2, 4, 0])


