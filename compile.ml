(* Production de code pour notre langage *)

open Mips
open Ast
module StrMap = Map.Make (String)

(* Module StrMaps = Map.make(String) *)
let gvars = Hashtbl.create 17

(* sert a sauvergder l'avncé de SP quand on utilise la pile pour stocker des
   resultats temporaires*)
let sp_aux = ref 0

(* Exception a lever quand une variable est utilisee sans etre definie *)
exception VarUndef of string

let push_var reg locvars x = 
  let l = [ Arithi (Add, SP, SP, -4); Sw (reg, Areg (4, SP)) ] in
  let locvars = StrMap.add x (StrMap.cardinal locvars + 1) locvars in
  l, locvars 

let push_tmp = 
  sp_aux := !sp_aux + 1;
  [ Arithi (Add, SP, SP, -4); Sw (V0, Areg (4, SP)) ]

let pop_tmp = 
   sp_aux := !sp_aux - 1;
   [Arithi (Add, SP, SP, 4)]

         

        
let cast_arith = function
  | Add -> Mips.Add
  | Sub -> Mips.Sub
  | Mul -> Mips.Mul
  | Div -> Mips.Div

(* Retrouve la veleur depuis les variables locales. si elle n'est pas présente dans
   les varibales locales, essaie les variables globales. Si elle est introuvable,
   lance une exeception, sinon stocke le resultats dans $v0*)
let compile_var locvars e =
  if StrMap.mem e locvars then (
    let sp_x = StrMap.find e locvars in
    Printf.printf "sp_x = %d; sp_aux = %d; sp = %d\n" sp_x !sp_aux
      (4 * (StrMap.cardinal locvars - sp_x + !sp_aux + 1));
    [ Lw (V0, Areg (4 * (StrMap.cardinal locvars - sp_x + !sp_aux + 1), SP)) ])
  else if Hashtbl.mem gvars e then [ Lw (V0, Alab e) ]
  else raise (VarUndef "Undefined variable\n")

(* Compilation d'une expression *)
let rec compile_expr locvars = function
  | Cst k -> [ Li (V0, k) ]
  | Var x -> compile_var locvars x
  | Binop (op, a, b) -> (
      match b with
      | Cst k -> compile_expr locvars a @ [ Arithi (cast_arith op, V0, V0, k) ]
      | _ ->
            (compile_expr locvars a)
            @ push_tmp
            @ (compile_expr locvars b)
            @ [
                Lw (A0, Areg (4, SP));
                Arith (cast_arith op, V0, A0, V0)
            ]
            @ pop_tmp
  )

   | Letin (x, a, b) ->
      let l =
        compile_expr locvars a
      in let l',locvars = push_var V0 locvars x in
      l @ l' @ compile_expr locvars b @ [ Arithi (Add, SP, SP, 4) ]
  | Call (f, arg) -> (compile_expr StrMap.empty arg) @ [ Move(A0, V0) ; Jal f]


let compile_read x = [ Li (V0, 5); Syscall; Sw (V0, Alab x) ]

let compile_print e =
  match e with
  | Cst k -> [ Arithi (Add, A0, A0, k) ]
  | _ -> compile_expr StrMap.empty e @ [ Move (A0, V0) ]


  let compile_fun f arg exp =
    let l, locvars = push_var A0 StrMap.empty arg in
    let l =
      [Label f; Arithi (Add, SP, SP, -4); Sw (RA, Areg(4, SP)); ] @ l
      @ (compile_expr locvars exp)
      @ [
              Arithi (Add, SP, SP, 4); Lw (RA, Areg(4, SP)); Arithi (Add, SP, SP, 4); Jr RA;
          Endfun f
      ]
    in
    [JEnd f] @ l
  

(* Compilation d'une instruction *)
let compile_instr = function
  | Print e ->
      compile_print e
      @ [ Li (V0, 1); Syscall; Li (V0, 11); Li (A0, 10); Syscall ]
  | Read x ->
      if Hashtbl.mem gvars x then compile_read x
      else (
        Hashtbl.add gvars x (Word (x, 0));
        compile_read x)
  | Function (f, arg, exp) -> compile_fun f arg exp

(* Compile le programme p et enregistre le code dans le fichier ofile *)
let compile_program p ofile =
  let code = List.map compile_instr p |> List.concat in
  let p = { text = code; data = List.of_seq (Hashtbl.to_seq_values gvars) } in
  Mips.print_program p ofile

