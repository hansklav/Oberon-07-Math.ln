MODULE Math1;

  PROCEDURE ln* (x: REAL): REAL;  (* hk  18 May 2024 *)
    CONST
      c1 = 0.70710678;  (* 1/ sqrt(2) *)
      c2 = 0.69314718;  (* ln(2) *)
      c3 = 0.89554059;
      c4 = 1.82984424;
      c5 = 1.65677798;
    VAR e: INTEGER; y: REAL;
  BEGIN ASERT(x > 0.0); UNPK(x, e);
    y := x * 0.5; INC(e);
    IF y < c1 THEN y := 2.0*y; DEC(e) END;
    y := (y-1.0)/(y+1.0);
    y := c2*FLT(e) + y*(c3 + c4/(c5 - y*y))
  RETURN y
  END ln;
  
END Math1.
