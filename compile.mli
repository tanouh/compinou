
exception VarUndef of string
  (** exception lev�e pour signaler une variable non d�clar�e *)

val compile_program : Ast.program -> string -> unit
  (** [compile_program p f] compile le programme [p] et �crit le code MIPS
      correspondant dans le fichier [f] *)

