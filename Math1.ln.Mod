MODULE Math1;
(*
  PROCEDURE ln* (x: REAL): REAL;  (* hk  18 May 2024 *)
    CONST
      c1 = 0.70710678;  (* 1/ sqrt(2) *)
      c2 = 0.69314718;  (* ln(2) *)
      c3 = 0.89554059;
      c4 = 1.82984424;
      c5 = 1.65677798;
    VAR e: INTEGER; y: REAL;
  BEGIN ASSERT(x > 0.0); UNPK(x, e);
    y := x * 0.5; INC(e);
    IF y < c1 THEN y := 2.0*y; DEC(e) END;
    y := (y-1.0)/(y+1.0);
    y := c2*FLT(e) + y*(c3 + c4/(c5 - y*y))
  RETURN y
  END ln;
*)
  PROCEDURE ln*(x: REAL): REAL;  (* Joerg Straube 22.5.2024 *)
  (* ln(x) = 2*arctanh( (x-1)/(x+1) )
     around 0, arctanh() is almost linear with slope 1
  *)
    CONST
      c1 = 1.4142135;  (* sqrt(2) *)
      c2 = 0.6931472;  (* ln(2) *)
      c3 = 0.89554059;
      c4 = 1.82984424;
      c5 = 1.65677798;
    VAR e: INTEGER;
  BEGIN
    ASSERT(x > 0.0); UNPK(x, e);            (* x in 1 .. 2 *)
    IF x > c1 THEN x := x*0.5; INC(e) END;  (* x in 0.7 .. 1.4) *)
    x := (x - 1.0)/(x + 1.0);               (* x in -0.17 .. 0.17 *)
    x := FLT(e)*c2 + x*(c3 + c4/(c5 - x*x))
  RETURN x 
  END ln;

END Math1.
