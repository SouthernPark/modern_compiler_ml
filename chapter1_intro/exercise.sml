use "slp.sml";

(*
Write an ML function (maxargs : stm ^ int ) that tells the maximum
number of arguments of any print statement within any subexpression of
a given statement. For example, maxargs (prog) is 2.Write an ML function (maxargs : stm ^ int) that tells the maximum
number of arguments of any print statement within any subexpression of
a given statement. For example, maxargs (prog) is 2.

The stm data type is defined in the file "slp.sml"
*)

fun lst_size [] = 0
  | lst_size (a::l) = 1 + (lst_size l)

fun max (x, y) = if x > y then x else y

fun maxargs (PrintStm exp_lst) = max(lst_size exp_lst, foldl (fn (exp, ans) => max (maxargs_exp exp, ans)) 0 exp_lst)
  | maxargs (AssignStm (x, exp))= maxargs_exp exp
  | maxargs (CompoundStm (stm1, stm2)) = max (maxargs stm1, maxargs stm2)
and maxargs_exp (IdExp x) = 0
  | maxargs_exp (NumExp x) = 0
  | maxargs_exp (OpExp (exp1, x, exp2)) = max (maxargs_exp exp1, maxargs_exp exp2)
  | maxargs_exp (EseqExp (stm, exp)) = max (maxargs stm, maxargs_exp exp)



(*
Write an ML function interp : stm->unit that "interprets" a program
in
this language. To write in a "functional" style - without assignment (: =) or
arrays
maintain a list of (variable,integer) pairs, and produce new versions
of this list at each AssignStm
*)

structure MyInterpreter :>
          sig
            val interp: stm -> unit
          end =

struct
type table = string*int list

(* add pair (id, value) as the first element of the list *)
fun update(table, id, value) = (id, value) :: table

(* find the first id in the table and return its value *)
fun lookup([], id) = 0
  | lookup((ele, value)::l, id) = if ele = id then value else lookup(l, id)


fun interpStm (CompoundStm(stm1, stm2), t) =
    let val t = interpStm(stm1, t)
        val t = interpStm(stm2, t)
    in
      t
    end
  | interpStm (AssignStm(id, exp), t) =
    let val (value, t) = interpExp(exp, t)
        val t = update(t, id, value)
    in
      t
    end
  | interpStm (PrintStm [], t) = t
  | interpStm (PrintStm (exp::lst), t)=
    let val (value, t) = interpExp(exp, t)
        val () = print(Int.toString(value) ^ "\n")
    in
      interpStm(PrintStm lst, t)
    end

and interpExp (IdExp id, t) =
    let val value = lookup(t, id)
    in
      (value, t)
    end
  | interpExp (NumExp num, t) = (num, t)
  | interpExp (OpExp(exp1, binop, exp2), t) =
    let val (value1, t) = interpExp(exp1, t)
        val (value2, t) = interpExp(exp2, t)
        val value = case binop of
                        Plus => value1 + value2
                      | Minus => value1 - value2
                      | Times => value1 * value2
                      | Div => value1 div value2
    in
      (value, t)
    end
  | interpExp (EseqExp(stm, exp), t) =
    let val t = interpStm(stm, t)
        val (value, t) = interpExp(exp, t)
    in
      (value, t)
    end
fun interp(stm) = let val t = interpStm(stm, []) in () end

end

(* exercises 1.1 *)
type key = string
datatype tree = LEAF | TREE of tree * key * tree
val empty = LEAF
fun insert(key, LEAF) = TREE(LEAF, key, LEAF)
  | insert(key, TREE(l,k,r)) =
    if key < k then TREE(insert(key,l), k, r)
    else if key>k then TREE(l,k,insert(key,r))
(* the original node will be replaced *)
    else TREE(l, key, r)

(* Implement a member function that returns true if the item is found, else false. *)

fun member (key, LEAF) = false
  | member (key, TREE(l, k, r)) =
    if key = k then true
    else if key < k then member(key, l)
    else member(key, r)


(* Extend the program to include not just membership, but the mapping of keys to bindings: *)

structure KeyValBST =
struct
type key = string
datatype 'a tree = LEAF | TREE of 'a tree * key * 'a * 'a tree
val empty = LEAF

fun insert(LEAF, key, value) = TREE(LEAF, key, value, LEAF)
  | insert(TREE(l,k,v,r), key, value) =
    if key < k then TREE(insert(l, key, value), k, v, r)
    else if key > k then TREE(l, k, v, insert(r, key, value))
    else TREE(l, key, value, r)

fun lookup(LEAF, key) = NONE
  | lookup(TREE(l, k, v, r), key) =
    if key = k then SOME(v)
    else if key < k then lookup(l, key)
    else lookup(r, key)
end


