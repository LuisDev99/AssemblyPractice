;--------------------------------------------|
; int exp_r(int base, int exp, int res){     |
;     if(exp == 0) return res;               |
;     return exp_r(base, exp-1, res*base);   |
; }                                          |
;                                            |
; int exp(int base, int exp){                |
;     return exp_r(base, exp-1, base);       |
; }                                          |
;--------------------------------------------|