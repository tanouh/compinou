(* Production de code pour notre langage *)

open Mips
open Ast

module StrMap = Map.Make(String)

(* Module StrMaps = Map.make(String) *)

let global = Hashtbl.create 17
(* Exception à lever quand une variable est utilisée sans être définie *)
exception VarUndef of string

(* Compilation d'une expression *)	
let rec compile_expr = function
  | Var x -> []
  | Binop (op, a, b) -> match b with 
     | Cst k -> (compile_expr a) @ [Arithi (op,V0,V0,k)]
     | _ -> (compile_expr a) @ [Arithi (Sub, SP, SP, 4), Sw(V0, Areg(4,SP))] 
     @ (compile_expr b) @ [Lw (A0, Areg(4,SP)); (Arith (op,V0,A0,V0)); Arithi(Add, SP, SP, 4)]
  | Letin (x, a, b) -> []
  | Call (f, arg) -> []

let compile_binop (op, a, b) = 


let compile_read x = [Li (V0,5); Syscall; Sw (V0, Alab x)]

(* Compilation d'une instruction *)            
let compile_instr locvars = function
  | Print e ->  match e with 
    | Cst k -> [ Arithi (Add, A0, A0, k); Li (V0,1); Syscall] 
    | _ -> compile_expr e @ [ Move (A0, V0); Li (V0,1) ; Syscall] 
  | Read x ->   
     if Hashtbl.mem global x then  compile_read x
     else (
       Hashtbl.add global x (Word (x, 0));
       compile_read x
     )
let compile_stmt p = 
  let locvars = StrMaps.empty in
  let locvars, instr_l = compile_instr locvars p in

     
(* Compile le programme p et enregistre le code dans le fichier ofile *)
let compile_program p ofile =
  let code = List.map compile_instr p |> List.concat in
  let p = 
    { text = code;
      data = 
        List.of_seq (Hashtbl.to_seq_values global)
        
    }
  in
  Mips.print_program p ofile;
  
