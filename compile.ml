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
  | Print e -> [ (* TODO *) ] 
  | Read x ->  [ (* TODO *) ]
     

(* Compile le programme p et enregistre le code dans le fichier ofile *)
let compile_program p ofile =
  let code = List.map compile_instr p |> List.concat in
  let p = 
    { text = [
        (* TODO *)
      ] ;
      data = [
        (* TODO *)
        ]
    }
  in
  Mips.print_program p ofile;
  
