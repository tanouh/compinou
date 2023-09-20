(* Production de code pour notre langage *)

open Mips
open Ast

module StrMap = Map.Make(String)

(* Module StrMaps = Map.make(String) *)
let gvars = Hashtbl.create 17
(* Exception a lever quand une variable est utilisee sans etre definie *)
exception VarUndef of string

(* 
  Variables qu'on ne read pas dans la pile
   A0 pour charger les globales 
   Dans les résultats on fait en sorte qu'on termine toujours avec A0
*)
let compile_var e = 
  if Hashtbl.mem gvars e then [Lw (V0, Alab e)] 
  else raise (VarUndef "Undefined variable\n")

(* Compilation d'une expression *)	
let rec compile_expr = function
  | Var x -> compile_var e 
  | Binop (op, a, b) -> match b with 
     | Cst k -> (compile_expr a) @ [Arithi (op,V0,V0,k)]
     | _ -> (compile_expr a) @ [Arithi (Sub, SP, SP, 4), Sw(V0, Areg(4,SP))] 
     @ (compile_expr b) @ [Lw (A0, Areg(4,SP)); (Arith (op,V0,A0,V0)); Arithi(Add, SP, SP, 4)]
  | Letin (x, a, b) -> []
  | Call (f, arg) -> []

let compile_binop (op, a, b) = 


let compile_read x = [Li (V0,5); Syscall; Sw (V0, Alab x)]

let compile_print e =
  match e with 
  | Cst k -> [Arithi (Add, A0, A0, k)]
  | _ -> (compile_expr e ) @ [Move (A0, V0)]

(* Compilation d'une instruction *)            
let compile_instr = function
  | Print e -> (compile_print e) @ [ Li (V0,1) ; Syscall; Li (V0, 11); Li (A0, 10) ; Syscall] 
  | Read x -> if Hashtbl.mem gvars x then compile_read x
              else (
                Hashtbl.add gvars x (Word(x, 0));
                compile_read x
              )


(* Compile le programme p et enregistre le code dans le fichier ofile *)
let compile_program p ofile =
  let code = List.map compile_instr p |> List.concat in
  let p = 
    { text = code;
      data = 
        List.of_seq (Hashtbl.to_seq_values gvars)
        
    }
  in
  Mips.print_program p ofile;
  
