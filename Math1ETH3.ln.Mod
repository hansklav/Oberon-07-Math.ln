MODULE Math1;	(** portable *)  
(* Relevant parts of Math.Mod for Math.ln from ETH OBERON System 3, Release 2.3
   Ported to Oberon-07 by Hans Klaver 18 May 2024. *)

  IMPORT S := SYSTEM;
  
  VAR (* ln: *) c41, c42, c43, c44, c45: REAL;
 
  PROCEDURE ln*(x: REAL): REAL;
  VAR e: LONGINT; a: REAL; Error: ARRAY 32 OF CHAR;
  BEGIN 
 (* IF x <= 0 THEN Error := "NEGATIVE ARGUMENT"; HALT(80)
    ELSE *)
    ASSERT(x > 0.0);                                                               (*hk*)
    a := S.VAL(REAL, S.VAL(SET, x) - {23..30} + {24..29});  (* expo(a) = 126 *)
 (* e := S.LSH(S.VAL(LONGINT, x), -23) MOD 256 - 126; *) 
    e := ASR(ORD(x), 23) MOD 256 - 126;                                            (*hk*)
    IF a < c41 THEN a := 2.0*a; DEC(e) END ;
    a := (a-1.0)/(a+1.0); 
    a := c42*FLT(e) + a*(c43 + c44/(c45 - a*a));                                   (*hk*)
 (* RETURN a                                  
    END *)                              
  RETURN a                                                                         (*hk*)
  END ln;

BEGIN
	S.PUT(S.ADR(c41), 03F3504F3H);	(* 1/sqrt(2) *)
	S.PUT(S.ADR(c42), 03F317218H);	(* ln(2) *)
	S.PUT(S.ADR(c43), 03F654226H);
	S.PUT(S.ADR(c44), 03FEA3856H);
	S.PUT(S.ADR(c45), 03FD4114DH)
END Math1.
