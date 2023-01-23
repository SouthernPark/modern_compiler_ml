use "exercise.sml";
use "test_framework.sml";

val () = general_test (lst_size, "lst_size", [[], [1,2,3]], [0,3])
val () = general_test (max, "max", [(1,2), (0, ~2)], [2, 0])
val () = general_test (maxargs, "maxargs", [prog, prog1, prog2], [2, 4, 0])

(* 8 7 80 should be printed out *)
val () = MyInterpreter.interp prog

val tr = empty
val tr = insert("abc", tr)
val tr = insert("123", tr)
val tr = insert("d", tr)
val tr = insert("123", tr)
val () = general_test (member, "member", [("abc",tr),("nothing",tr), ("d",tr), ("123", tr)], [true, false, true, true])

val tr = KeyValBST.empty
val tr = KeyValBST.insert(tr, "abc", 1)
val tr = KeyValBST.insert(tr, "123", 2)
val tr = KeyValBST.insert(tr, "d", 3)
val tr = KeyValBST.insert(tr, "123", 4)
val () = general_test (KeyValBST.lookup, "lookup", [(tr, "abc"),(tr,"nothing"), (tr,"d"), (tr,"123")], [SOME(1), NONE, SOME(3), SOME(4)])

