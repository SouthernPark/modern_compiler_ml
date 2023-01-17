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




