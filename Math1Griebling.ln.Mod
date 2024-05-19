MODULE Math1;  
(* Parts of Math.Mod relevant for Math.ln by Michael Griebling.
   Ported to Oberon-07 by Hans Klaver 18 May 2024.
*)

(*  Math - Oakwood REAL Mathematics.
    Adapted from OOC LowReal.Mod and RealMath.Mod

    Target independent mathematical functions for REAL
    (IEEE single - precision) numbers.

    Numerical approximations are taken from "Software Manual for the
    Elementary Functions" by Cody & Waite and "Computer Approximations"
    by Hart et al.
*)

  IMPORT SYSTEM;

  CONST
 (* large*    = MAX(REAL); *) (* 3.40282347E+38. Largest number this package accepts *)
    large     = 3.40282347E+38;                                                    (*hk*)
    nMask     = {0..22,31};  (* number mask: Sign and mantissa *)
    expMask   = {23..30};    (* exponent mask: exponent value + 127 *)
    ZERO      = 0.0;
    HALF      = 0.5;
   sqrtHalf  = 0.70710678118654752440;
    IllegalLog* = 2;  (* error/exception codes *)
    
  VAR
    ErrorHandler*: PROCEDURE (errno : INTEGER);
 (* err-: INTEGER; *)
    err: INTEGER;
   
  
  PROCEDURE DefaultErrorHandler(errno : INTEGER);
  BEGIN err:=errno END DefaultErrorHandler; 
  

  (* TYPE REAL: 1/sign, 8/exponent, 23/significand *)

  PROCEDURE fraction*(x: REAL): REAL;
  (*
     The value of the call fraction(x) shall be the significand (or
     significant) part of `x'.  Hence the following relationship shall
     hold: x = scale(fraction(x), exponent(x)).
  *)
    VAR s: SET; res: REAL;                                                         (*hk*)
  BEGIN
    IF x = ZERO THEN (*RETURN*) res := ZERO                                        (*hk*)
    ELSE
   (* s := SYSTEM.VAL(SYSTEM.SET32, x) * nMask + {24..29}; *)                    
      s := SYSTEM.VAL(SET, x) * nMask + {24..29};                                  (*hk*)
   (* RETURN SYSTEM.VAL(REAL, s) * 2.0 *)                                    
      res := SYSTEM.VAL(REAL, s) * 2.0                                             (*hk*)
    END
  RETURN res                                                                       (*hk*)
  END fraction;


  PROCEDURE exponent*(x: REAL): INTEGER;
  (*
     The value of the call exponent(x) shall be the exponent value of `x'
     that lies between `expoMin' and `expoMax'.  An exception shall occur
     and may be raised if `x' is equal to 0.0.
   *)
    VAR res: INTEGER;                                                              (*hk*)
  BEGIN
    IF x = ZERO THEN (*RETURN*) res := 0  (* NOTE: x=0.0 should raise exception *)
    ELSE
   (* RETURN SHORT(SYSTEM.LSH(SYSTEM.VAL(SYSTEM.INT32, x), -23) MOD 256) - 127 *)
      res := ASR(ORD(x), 23) MOD 256 - 127                                         (*hk*)
    END
  RETURN res                                                                       (*hk*)
  END exponent;


  PROCEDURE ln* (x: REAL): REAL;
    (* Returns the natural logarithm of x for x > 0 *)
    CONST
      c1 = 0.693359375;    (* 355.0/512.0 *)                                       (*hk*)
      c2 = -2.121944400546905827679E-4;
      A0 = -0.5527074855E+0; B0 = -0.6632718214E+1;
    VAR f, zn, zd, r, z, w, xn: REAL; n: INTEGER;
  BEGIN
    (* ensure illegal inputs are trapped and handled *)
 (* IF x <= ZERO THEN ErrorHandler(IllegalLog); RETURN -large END; *)
    ASSERT(x > 0.0);                                                               (*hk*)

    (* reduce the range of the input *)
    f := fraction(x) * HALF; n := exponent(x) + 1;
    IF f > sqrtHalf THEN zn := (f - HALF) - HALF; zd := f * HALF + HALF
    ELSE zn := f - HALF; zd := zn * HALF + HALF; DEC(n)
    END;

    (* evaluate rational approximation from "Software Manual for the Elementary Functions" *)
    z := zn/zd; w := z * z; r := z + z * (w * A0/(w + B0));

    (* scale the output *)
 (* xn := n; *)                                                                    (*hk*)
    xn := FLT(n)                                                                   (*hk*)
    RETURN (xn * c2 + r) + xn * c1
  END ln;


BEGIN
  ErrorHandler := DefaultErrorHandler
END Math1.
