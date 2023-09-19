(* Production de code pour notre langage *)

open Mips
open Ast


(* Exception à lever quand une variable est utilisée sans être définie *)
exception VarUndef of string

(* Compilation d'une expression *)	
let compile_expr = 
  [ (* TODO *) ]

(* Compilation d'une instruction *)            
let compile_instr = function
  | Print e ->  [Li (V0,1); Move (A0, T 0); Syscall] 
  | Read x ->   [Li (V0, 5); Syscall; Move (T 0, V0)]
     
(* Compile le programme p et enregistre le code dans le fichier ofile *)
let compile_program p ofile =
  let code = List.map compile_instr p |> List.concat in
  let p = 
    { text = code;
      data = [
        (* TODO *)
        ]
    }
  in
  Mips.print_program p ofile;
  
